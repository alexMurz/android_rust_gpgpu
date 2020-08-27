package com.example.gpgpu

import org.junit.Test

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
class ExampleUnitTest {

    @Test fun testGpuCtx() {
        Bench.perform(
            { System.load(System.getProperty("user.dir") + "/../rust/target/release/librust.so") },
            { println(it) }
        )
    }

}
