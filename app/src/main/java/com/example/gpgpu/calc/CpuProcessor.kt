package com.example.gpgpu.calc

import kotlinx.coroutines.*
import java.util.stream.StreamSupport
import kotlin.math.cos
import kotlin.math.min
import kotlin.math.sin


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
            StreamSupport.stream(range.spliterator(), true).forEach {
                val v = buff[it]
                buff[it] = 2.0f* sin(v) - cos(2.0f*v)
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