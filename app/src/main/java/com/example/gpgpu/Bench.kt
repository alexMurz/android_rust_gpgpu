package com.example.gpgpu

import com.example.gpgpu.calc.CpuProcessor
import com.example.gpgpu.calc.GpuProcessor
import com.example.gpgpu.calc.Processor
import java.util.stream.StreamSupport
import kotlin.math.absoluteValue
import kotlin.math.cos
import kotlin.math.sin
import kotlin.system.measureNanoTime
import kotlin.time.measureTime

/// Utils object to help benching
object Bench {
    // Simulate doing something to 1080p image
    val N = 3 * 1920 * 1080
    // I iterations
    val I = 5


    @Suppress("NAME_SHADOWING")
    private fun doWith(makeProcessor: () -> Processor, data: FloatArray, cmp: FloatArray, prefix: String, log: (String) -> Unit) {

        val result = FloatArray(N) { 0.0f }
        val createTime: Long
        val disposeTime: Long
        val computeTime: Long
        var uploadTime: Long
        var downloadTime: Long
        val time = measureNanoTime {
            val ctx: Processor
            createTime = measureNanoTime {
                ctx = makeProcessor()
            }

            uploadTime = measureNanoTime { ctx.upload(data) }
            computeTime = measureNanoTime {
                repeat(I) { ctx.run(0 until N).flush() }
            }
            downloadTime = measureNanoTime { ctx.download(result) }
            disposeTime = measureNanoTime { ctx.dispose() }
        }

        for (i in data.indices) {
            val cmp = cmp[i]
            val result = result[i]
            val delta = (cmp - result).absoluteValue
            // Error stacking up when using iterative float modification, hence delta window is huge
            assert(delta < 0.1) { println("Incorrect values at i = $i ($result != $cmp)") }
        }

        log("$prefix time ${time.toFloat() / 1e6f}ms (Full Chain)")
        log("$prefix time ${createTime.toFloat() / 1e6f}ms (Create)")
        log("$prefix time ${uploadTime.toFloat() / 1e6f}ms (Upload) <- Important")
        log("$prefix time ${computeTime.toFloat() / 1e6f}ms (Compute) <- Important")
        log("$prefix time ${downloadTime.toFloat() / 1e6f}ms (Download) <- Important")
        log("$prefix time ${disposeTime.toFloat() / 1e6f}ms (Dispose)")
    }

    fun perform(libLoad: () -> Unit, log: (String) -> Unit) {

        val data = FloatArray(N) { Math.random().toFloat() }
        val rawResult = data.clone()

        val rawTime = measureNanoTime {
            repeat(I) {
                StreamSupport.stream(rawResult.indices.spliterator(), true).forEach {
                    val v = rawResult[it]
                    rawResult[it] = 2.0f* sin(v) - cos(2.0f*v)
                }
            }
        }
        log("Raw time ${rawTime.toFloat() / 1e6f}ms")

        log("----------")
        doWith({ CpuProcessor(N) }, data, rawResult, "CPU", log)

        // Load native library
        libLoad()

        log("----------")
        doWith({ GpuProcessor.new(N)!! }, data, rawResult, "GPU", log)

    }

}