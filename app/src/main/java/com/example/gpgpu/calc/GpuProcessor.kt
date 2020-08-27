package com.example.gpgpu.calc

import kotlin.math.min


class GpuProcessor private constructor(private val ctx: Long): Processor {
    companion object {
        fun new(capacity: Int): GpuProcessor? {
            val ctx = Rust.ctxCreate(capacity)
            return if (ctx > 0) GpuProcessor(ctx) else null
        }
    }

    override fun dispose() {
        Rust.ctxDrop(ctx)
    }

    override fun upload(src: FloatArray, srcStart: Int, len: Int, dstStart: Int) {
        Rust.ctxUpload(ctx, src, srcStart, len, dstStart)
    }

    override fun download(dst: FloatArray, dstStart: Int, len: Int, srcStart: Int) {
        Rust.ctxDownload(ctx, dst, srcStart, len, dstStart)
    }

    override fun run(range: IntRange): Processor.Future {
        return Future(range, Rust.ctxRun(ctx, range.first, range.last))
    }

    inner class Future(private val range: IntRange, private val ptr: Long): Processor.Future {
        override fun completed(): Boolean = Rust.futureIsCompleted(ptr)
        override fun flush() = Rust.futureFlush(ptr)

        override fun downloadInto(dst: FloatArray, dstStart: Int) {
            val len = min(dst.size - dstStart, range.last - range.first + 1)
            download(dst, dstStart, len, range.first)
        }
    }
}


@Suppress("FunctionName")
private object Rust {
    // Load library
    init {
//            System.loadLibrary("rust") // System.mapLibraryName("rust"))
//        System.load("/home/alexmurz/Documents/code/simd_bench/rust/target/debug/librust.so") // System.mapLibraryName("rust"))
    }

    /**
     * Create new GpuContext
     * return 0 if failed
     */
    external fun ctxCreate(capacity: Int): Long

    /**
     * Kill GpuContext, after call context should not be used
     */
    external fun ctxDrop(ptr: Long)

    /**
     * Put new data
     */
    external fun ctxUpload(ptr: Long, src: FloatArray, srcStart: Int, len: Int, dstStart: Int)

    /**
     * Read data
     */
    external fun ctxDownload(ptr: Long, dst: FloatArray, dstStart: Int, len: Int, srcStart: Int)

    /**
     * Start execution, return Future ptr
     */
    external fun ctxRun(ptr: Long, lo: Int, hi: Int): Long

    /**
     * Check future completion status
     */
    external fun futureIsCompleted(ptr: Long): Boolean

    /**
     * Wait for future to finish execution
     */
    external fun futureFlush(ptr: Long)

}