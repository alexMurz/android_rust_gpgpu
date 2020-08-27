
////////////////////////////////////////
//// Utils to generate pipelines

use vulkano::{
    descriptor::{
        descriptor::DescriptorDesc,
        pipeline_layout::{PipelineLayoutDescPcRange, PipelineLayoutDesc},
    },
    pipeline::shader::{ShaderInterfaceDefEntry, ShaderInterfaceDef, GraphicsEntryPoint, ComputeEntryPoint}
};

pub struct StageDefIterator(Vec<Option<ShaderInterfaceDefEntry>>);
impl Iterator for StageDefIterator {
    type Item = ShaderInterfaceDefEntry;

    #[inline] fn next(&mut self) -> Option<Self::Item> {
        if let Some(v) = self.0.pop() {
            v
        } else { None }
    }

    #[inline] fn size_hint(&self) -> (usize, Option<usize>) {
        let len = (self.0.len()) as usize;
        (len, Some(len))
    }
}
impl ExactSizeIterator for StageDefIterator { }

#[derive(Clone)]
pub struct StageDef(pub Vec<Option<ShaderInterfaceDefEntry>>);
unsafe impl ShaderInterfaceDef for StageDef {
    type Iter = StageDefIterator;
    fn elements(&self) -> Self::Iter {
        StageDefIterator(self.0.clone())
    }
}


// Layout set, contains binding (binding can be empty (None))
pub type LayoutSet = Vec<Option<DescriptorDesc>>;

// Descriptor contains sets and push constants
#[derive(Debug, Clone)]
pub struct LayoutDescriptor {
    pub sets: Vec<LayoutSet>,
    pub push: Vec<Option<PipelineLayoutDescPcRange>>,
}
unsafe impl PipelineLayoutDesc for LayoutDescriptor {
    // Number of descriptor sets it takes.
    fn num_sets(&self) -> usize { self.sets.len() }
    // Number of entries (bindings) in each set.
    fn num_bindings_in_set(&self, set: usize) -> Option<usize> { Some(self.sets.get(set)?.len()) }
    // Descriptor descriptions.
    fn descriptor(&self, set: usize, binding: usize) -> Option<DescriptorDesc> {
        self.sets.get(set)?.get(binding)?.clone()
    }
    // Number of push constants ranges (think: number of push constants).
    fn num_push_constants_ranges(&self) -> usize { self.push.len() }
    // Each push constant range in memory.
    fn push_constants_range(&self, num: usize) -> Option<PipelineLayoutDescPcRange> { self.push.get(num)?.clone() }
}

/// Graphics Entry Point Generalized Type
pub type ShaderGraphicsEntryPoint<'a, Sc> = GraphicsEntryPoint<'a, Sc, StageDef, StageDef, LayoutDescriptor>;
pub type ShaderComputeEntryPoint<'a, Sc> = ComputeEntryPoint<'a, Sc, LayoutDescriptor>;
