package com.example.gpgpu

import android.util.Log
import androidx.test.ext.junit.runners.AndroidJUnit4

import org.junit.Test
import org.junit.runner.RunWith


/**
 * Instrumented test, which will execute on an Android device.
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
@RunWith(AndroidJUnit4::class)
class ExampleInstrumentedTest {

    @Test fun testGpuCtx() {
        Bench.perform(
            { System.loadLibrary("rust") },
            { Log.e("123", it) }
        )
    }
}
