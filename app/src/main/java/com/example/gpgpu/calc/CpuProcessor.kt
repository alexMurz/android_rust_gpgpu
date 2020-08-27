package com.example.gpgpu.calc

import kotlinx.coroutines.*
import kotlin.math.min


class CpuProcessor(capacity: Int): Processor {
    private val buff = FloatArray(capacity) { 0.0f }

    override fun upload(src: FloatArray, srcStart: Int, len: Int, dstStart: Int) {
        for (i in 0 until len) {
            buff[i + dstStart] = src[i + srcStart]
        }
    }

    override fun download(dst: FloatArray, dstStart: Int, len: Int, srcStart: Int) {
        for (i in 0 until len) {
            dst[i + dstStart] = buff[i + srcStart]
        }
    }

    override fun run(range: IntRange): Processor.Future {
        return Future(range, GlobalScope.launch {
            for (i in range) {
                val v = buff[i]
                buff[i] = v * v
            }
        })
    }

    override fun dispose() {}

    inner class Future(private val range: IntRange, private val job: Job): Processor.Future {
        override fun completed() = job.isCompleted

        override fun flush() = runBlocking { job.join() }

        override fun downloadInto(dst: FloatArray, dstStart: Int) {
            val len = min(dst.size - dstStart, range.last - range.first + 1)
            download(dst, dstStart, len, range.first)
        }
    }

}