package com.example.gpgpu.calc

interface Processor {
    /**
     * Processor `act` future control
     */
    interface Future {
        fun completed(): Boolean
        fun flush()
        fun downloadInto(dst: FloatArray, dstStart: Int = 0)
    }

    /**
     * Upload new data to inner processing buffer
     */
    fun upload(src: FloatArray, srcStart: Int = 0, len: Int = src.size, dstStart: Int = 0)

    /**
     * Download data from inner buffer
     */
    fun download(dst: FloatArray, dstStart: Int = 0, len: Int = dst.size, srcStart: Int = 0)

    /**
     * Process data in range
     */
    fun run(range: IntRange): Future

    /**
     * Dispose all underlying data
     */
    fun dispose()

    companion object {
        fun new(capacity: Int): Processor {
            return CpuProcessor(capacity)
        }
    }

}