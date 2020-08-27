#![feature(box_syntax)]

pub mod defs;
pub mod ctx;

// #[cfg(target_os="android")]
#[allow(non_snake_case)]
mod android {
    use jni::{
        JNIEnv,
        objects::{ JClass },
        sys::{ jfloatArray, jint, jlong, jboolean },
    };
    use crate::ctx::{GpuContext, Future};
    use std::sync::Mutex;

    #[inline(always)]
    fn to_ptr<T>(v: T) -> jlong {
        let v = Box::new(v);
        let ptr = Box::into_raw(v);
        ptr as jlong
    }

    #[inline(always)]
    fn from_ptr<'a, T>(ptr: jlong) -> Option<&'a mut T> {
        let ptr = ptr as * mut T;
        if ptr.is_null() {
            None
        } else {
            let b = unsafe { Box::from_raw(ptr as *mut T) };
            Some(Box::leak(b))
        }
    }


    // com.example.gpgpu.calc.Rust.ctxCreate
    #[no_mangle]
    pub extern "system" fn Java_com_example_gpgpu_calc_Rust_ctxCreate(
        _: JNIEnv, _: JClass,
        capacity: jint
    ) -> jlong {
        match GpuContext::new(capacity as _) {
            Ok(v) => to_ptr(Mutex::new(v)),
            Err(e) => {
                eprintln!("Error creating GpuContext: {:?}", e);
                0
            }
        }
    }

    // com.example.gpgpu.calc.Rust.ctxDrop
    #[no_mangle]
    pub extern "system" fn Java_com_example_gpgpu_calc_Rust_ctxDrop(
        _: JNIEnv, _: JClass,
        ptr: jlong
    ) {
        let ptr = ptr as * mut Mutex<GpuContext>;
        if !ptr.is_null() {
            let obj = unsafe { Box::from_raw(ptr) };
            drop(obj)
        }
    }

    // com.example.gpgpu.calc.Rust.ctxUpload
    #[no_mangle]
    pub extern "system" fn Java_com_example_gpgpu_calc_Rust_ctxUpload(
        env: JNIEnv, _: JClass,
        ptr: jlong, arr: jfloatArray, src_start: jint, len: jint, dst_start: jint,
    ) {
        if let Some(ctx) = from_ptr::<Mutex<GpuContext>>(ptr) {
            let ctx = ctx.lock().expect("Unable to lock Context");
            let mut dst = ctx.buffer.write().expect("Unable to obtain RW Lock");
            let dst_end = (dst_start + len) as _;
            let dst_start = dst_start as _;
            env.get_float_array_region(
                arr, src_start, &mut dst[dst_start .. dst_end]
            ).unwrap();
        }
    }

    // com.example.gpgpu.calc.Rust.ctxDownload
    #[no_mangle]
    pub extern "system" fn Java_com_example_gpgpu_calc_Rust_ctxDownload(
        env: JNIEnv, _: JClass,
        ptr: jlong, arr: jfloatArray, dst_start: jint, len: jint, src_start: jint,
    ) {
        if let Some(ctx) = from_ptr::<Mutex<GpuContext>>(ptr) {
            let ctx = ctx.lock().expect("Unable to lock Context");
            let src = ctx.buffer.read().unwrap();
            let src_end = (src_start + len) as _;
            let src_start = src_start as _;
            env.set_float_array_region(
                arr, dst_start, &src[src_start .. src_end]
            ).unwrap();
        }
    }

    // com.example.gpgpu.calc.Rust.ctxRun
    #[no_mangle]
    pub extern "system" fn Java_com_example_gpgpu_calc_Rust_ctxRun(
        _: JNIEnv, _: JClass,
        ptr: jlong, lo: jint, hi: jint
    ) -> jlong {
        if let Some(ctx) = from_ptr::<Mutex<GpuContext>>(ptr) {
            let ctx = ctx.lock().expect("Unable to lock Context");
            let lo = lo as _;
            let hi = hi as _;
            let future = ctx.run(lo..hi);
            to_ptr(future)
        } else {
            0
        }
    }

    // com.example.gpgpu.calc.Rust.futureIsCompleted
    #[no_mangle]
    pub extern "system" fn Java_com_example_gpgpu_calc_Rust_futureIsCompleted(
        _: JNIEnv, _: JClass,
        ptr: jlong
    ) -> jboolean {
        if let Some(ctx) = from_ptr::<Future>(ptr) {
            ctx.is_completed() as _
        } else {
            true as _
        }
    }

    // com.example.gpgpu.calc.Rust.futureFlush
    #[no_mangle]
    pub extern "system" fn Java_com_example_gpgpu_calc_Rust_futureFlush(_: JNIEnv, _: JClass, ptr: jlong) {
        if let Some(ctx) = from_ptr::<Future>(ptr) {
            ctx.flush()
        }
    }
}

