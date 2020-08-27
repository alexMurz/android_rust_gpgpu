package com.example.gpgpu

import android.util.Log
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.example.gpgpu.calc.GpuProcessor

import org.junit.Test
import org.junit.runner.RunWith
import java.util.stream.StreamSupport
import kotlin.math.absoluteValue
import kotlin.math.cos
import kotlin.math.sin
import kotlin.system.measureNanoTime


/**
 * Instrumented test, which will execute on an Android device.
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
@RunWith(AndroidJUnit4::class)
class ExampleInstrumentedTest {

    @Test fun testGpuCtx() {
        // Simulate doing something to 1080p image
        val N = 3 * 1920 * 1080
        // I iterations
        val I = 5

        val data = FloatArray(N) { Math.random().toFloat() }
        val cpuResult = data.clone()
        val gpuResult = FloatArray(N) { 0.0f }

        val cpuTime = measureNanoTime {
            repeat(I) {
                StreamSupport.stream(cpuResult.indices.spliterator(), true).forEach {
                    val v = cpuResult[it]
                    cpuResult[it] = 2.0f*sin(v) - cos(2.0f*v)
                }
            }
        }

        // Load library
        System.loadLibrary("rust")
//        System.load(System.getProperty("user.dir") + "/../rust/target/release/librust.so")

        val gpuCreateTime: Long
        val gpuDisposeTime: Long
        val gpuComputeTime: Long
        var gpuUploadTime: Long
        var gpuDownloadTime: Long
        val gpuTime = measureNanoTime {
            val ctx: GpuProcessor
            gpuCreateTime = measureNanoTime {
                ctx = GpuProcessor.new(N)!!
            }

            gpuUploadTime = measureNanoTime { ctx.upload(data) }
            gpuComputeTime = measureNanoTime {
                repeat(I) { ctx.run(0 until N).flush() }
            }
            gpuDownloadTime = measureNanoTime { ctx.download(gpuResult) }
            gpuDisposeTime = measureNanoTime { ctx.dispose() }
        }

        for (i in data.indices) {
            val cpu = cpuResult[i]
            val gpu = gpuResult[i]
            val delta = (cpu - gpu).absoluteValue
            // Error stacking up when using iterative float modification, hence delta window is huge
            assert(delta < 0.1) { println("Incorrect values at i = $i ($cpu != $gpu)") }
        }

        Log.e("123", "CPU time ${cpuTime.toFloat() / 1e6f}ms")
        Log.e("123", "GPU time ${gpuTime.toFloat() / 1e6f}ms (Full Chain)")
        Log.e("123", "----------")
        Log.e("123", "GPU time ${gpuCreateTime.toFloat() / 1e6f}ms (Create Only)")
        Log.e("123", "GPU time ${gpuUploadTime.toFloat() / 1e6f}ms (Upload Only)")
        Log.e("123", "GPU time ${gpuComputeTime.toFloat() / 1e6f}ms (Compute Only)")
        Log.e("123", "GPU time ${gpuDownloadTime.toFloat() / 1e6f}ms (Download Only)")
        Log.e("123", "GPU time ${gpuDisposeTime.toFloat() / 1e6f}ms (Dispose Only)")
    }
}
