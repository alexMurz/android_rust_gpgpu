
use crate::defs;
use std::{
    fmt,
    ffi::CStr,
    sync::Arc,
    ops::{ Range },
};
use vulkano::{
    OomError,
    sync::{ self, GpuFuture },
    device::{ Device, DeviceExtensions, DeviceCreationError, Queue },
    descriptor::descriptor::{ DescriptorDesc, DescriptorDescTy, DescriptorBufferDesc, ShaderStages },
    pipeline::{
        shader::ShaderModule,
        ComputePipeline, ComputePipelineCreationError, ComputePipelineAbstract,
    },
    buffer::{ CpuAccessibleBuffer, BufferUsage },
    descriptor::{
        PipelineLayoutAbstract, DescriptorSet,
        pipeline_layout::PipelineLayoutDescPcRange,
        descriptor_set::{ PersistentDescriptorSet, PersistentDescriptorSetBuildError, PersistentDescriptorSetError }
    },
    command_buffer::AutoCommandBufferBuilder,
    memory::DeviceMemoryAllocError,
    instance::{ Instance, InstanceExtensions, PhysicalDevice, QueueFamily, InstanceCreationError }
};

// Macro for `GpuContextCreationError` to impl From<T> GpuContextCreationError::T(T)
// Do not repeat yourself!
macro_rules! impl_from {
    ($target: ty, $($from: ident),*) => {
        $(
            impl From<$from> for $target {
                fn from(v: $from) -> Self {
                    Self::$from(v)
                }
            }
        )*
    };
}

/// All possible context creation errors
#[derive(Debug)] pub enum GpuContextCreationError {
    InstanceCreationError(InstanceCreationError),
    NoPhysicalDevice,
    NoQueueFamily,
    QueueFamilyIsEmpty,
    DeviceCreationError(DeviceCreationError),
    // Compile program
    OutOfHostMemory,
    OutOfDeviceMemory,
    // Create pipeline
    ComputePipelineCreationError(ComputePipelineCreationError),
    // Create buffer
    DeviceMemoryAllocError(DeviceMemoryAllocError),
    // Create set
    PersistentDescriptorSetError(PersistentDescriptorSetError),
    PersistentDescriptorSetBuildError(PersistentDescriptorSetBuildError),
}
impl_from!(GpuContextCreationError,
    InstanceCreationError, DeviceCreationError, ComputePipelineCreationError,
    DeviceMemoryAllocError, PersistentDescriptorSetError, PersistentDescriptorSetBuildError
);

impl From<OomError> for GpuContextCreationError {
    fn from(e: OomError) -> Self {
        match e {
            OomError::OutOfHostMemory => GpuContextCreationError::OutOfHostMemory,
            OomError::OutOfDeviceMemory => GpuContextCreationError::OutOfDeviceMemory,
        }
    }
}

impl std::error::Error for GpuContextCreationError {}
impl fmt::Display for GpuContextCreationError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        (self as &dyn fmt::Debug).fmt(f)
    }
}


/// SPIR-V bytecode
const PROGRAM: &[u8] = include_bytes!("../program/compiled/pow.cs.spirv");
/// Fixed local group size
const LOCAL_GROUP_SIZE: usize = 128;

/// Gpu Future wrapper
#[repr(transparent)]
pub struct Future {
    future: Option<Box<dyn GpuFuture>>
}
impl Future {
    pub fn new<F: 'static + GpuFuture>(f: F) -> Self {
        Self {
            future: Some(Box::new(f))
        }
    }

    /// TODO Check is future execution completed
    pub fn is_completed(&self) -> bool { self.future.is_some() }

    /// Wait for future to be executed
    pub fn flush(&mut self) {
        if let Some(f) = self.future.take() {
            f.then_signal_fence_and_flush().unwrap()
                .wait(None).unwrap();
        }
    }
}

/// Gpu Context
pub struct GpuContext {
    #[allow(dead_code)]
    capacity: usize,
    queue: Arc<Queue>,
    pipeline: Arc<dyn ComputePipelineAbstract + Send + Sync>,
    pub buffer: Arc<CpuAccessibleBuffer<[f32]>>,
    set: Arc<dyn DescriptorSet + Send + Sync>,
}
impl GpuContext {
    /// Create new `GpuContext` with buffer cap at `capacity`
    pub fn new(capacity: usize) -> Result<Self, GpuContextCreationError> {
        let instance = Instance::new(
            None,
            &InstanceExtensions::none(),
            None,
        )?;

        // Acquire any physical device, usually discrete is first
        let physical = PhysicalDevice::enumerate(&instance).next()
            .ok_or(GpuContextCreationError::NoPhysicalDevice)?;

        // Queue families
        let queue_family = physical.queue_families().find(QueueFamily::supports_compute)
            .ok_or(GpuContextCreationError::NoQueueFamily)?;

        // Get device and queues for queue family
        let (device, mut queues) = Device::new(
            physical,
            physical.supported_features(),
            &DeviceExtensions {
                khr_storage_buffer_storage_class: true,
                .. DeviceExtensions::none()
            },
            [(queue_family, 0.5)].iter().cloned()
        )?;

        let queue = queues.next().ok_or(GpuContextCreationError::QueueFamilyIsEmpty)?;

        let pipeline = unsafe {
            let cs = ShaderModule::new(
                device.clone(),
                PROGRAM
            )?;
            let entry_point = cs.compute_entry_point(
                CStr::from_bytes_with_nul_unchecked(b"main\0"),
                defs::LayoutDescriptor {
                    sets: vec![
                        // Set - 0
                        vec![
                            // Binding - 0
                            Some(DescriptorDesc {
                                ty: DescriptorDescTy::Buffer(DescriptorBufferDesc {
                                    dynamic: Some(false),
                                    storage: true
                                }),
                                array_count: 1,
                                readonly: false,
                                stages: ShaderStages::compute()
                            })
                        ]
                    ],
                    push: vec![
                        Some(PipelineLayoutDescPcRange {
                            stages: ShaderStages::compute(),
                            offset: 0,
                            size: 4,
                        })
                    ]
                }
            );
            Arc::new(ComputePipeline::new(
                device.clone(),
                &entry_point,
                &()
            )?)
        };

        // Round up to nearest 64 for performance
        let buffer_size = if (capacity % LOCAL_GROUP_SIZE) > 0 {
            (capacity / LOCAL_GROUP_SIZE + 1) * LOCAL_GROUP_SIZE
        } else { capacity };
        // let buffer = CpuAccessibleBuffer::from_iter(
        //     device.clone(),
        //     BufferUsage::all(),
        //     false,
        //     vec![0.0f32; buffer_size].into_iter()
        // )?;
        let buffer = unsafe {
            CpuAccessibleBuffer::uninitialized_array(
                device.clone(),
                buffer_size,
                BufferUsage::all(),
                false,
            )?
        };

        let set = {
            let layout = pipeline.layout().descriptor_set_layout(0).unwrap();
            Arc::new(PersistentDescriptorSet::start(layout.clone())
                .add_buffer(buffer.clone())?
                .build()?
            )
        };

        Ok(Self { capacity, queue, pipeline, buffer, set })
    }

    /// Run program in buffer range
    pub fn run(&self, range: Range<usize>) -> Future {
        let device = self.queue.device().clone();
        let queue = &self.queue;
        let pipeline = &self.pipeline;
        let set = &self.set;

        let l = range.start / LOCAL_GROUP_SIZE;
        let r = range.end / LOCAL_GROUP_SIZE;

        let mut cbb = AutoCommandBufferBuilder::primary_one_time_submit(
            device.clone(),
            queue.family()
        ).unwrap();
        cbb.dispatch(
            [(r-l+1) as u32, 1, 1],
            pipeline.clone(),
            set.clone(),
            l * LOCAL_GROUP_SIZE
        ).unwrap();
        let cb = cbb.build().unwrap();

        let future = sync::now(device)
            .then_execute(queue.clone(), cb).unwrap();

        Future::new(future)
    }

}
