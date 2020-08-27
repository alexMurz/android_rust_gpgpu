package com.example.gpgpu

import kotlin.system.measureNanoTime

/// Utils object to help benching
object Bench {
    const val N = 100

    class Scope {
        var total = 0L // ns
        fun reset() { total = 0 }
        inline fun ignore(f: () -> Unit) { f() }
        inline fun measure(f: () -> Unit) { total += measureNanoTime(f) }
    }

    class Timer(capacity: Int) {
        val scope = Scope()
        private val data = LongArray(capacity)
        private var count = 0

        fun add(t: Long) {
            data[count] = t
            count++
        }

        inline fun dispatch(f: Scope.() -> Unit) {
            scope.reset()
            f(scope)
            add(scope.total)
        }

        fun finish(percentile: Float) = Result(data, percentile)
    }

    class Result(data: LongArray, percentile: Float) {
        init { data.sort() }

        /// total - ignore percentile
        val totalAverage: Long = data.average().toLong()
        val totalBest: Long = data.firstOrNull() ?: 0
        val totalWorst: Long = data.lastOrNull() ?: 0
        val totalDistribution: Long = (totalBest - totalWorst) / 2
        val totalMedian: Long = totalDistribution + totalBest

        val average: Long
        val best: Long
        val worst: Long
        val distribution: Long
        val median: Long

        init {
            val lowIdx = (percentile * data.size).toInt()
            val hiIdx = ((1.0 - percentile) * data.size).toInt()
            val slice = data.slice(lowIdx .. hiIdx)

            average = slice.average().toLong()
            best = slice.firstOrNull() ?: 0
            worst = slice.lastOrNull() ?: 0
            distribution = (worst - best) / 2
            median = distribution + best
        }

    }

    inline fun measure(flag: String? = null, percentile: Float = 0.5f, sampleCount: Int = N, log: Boolean = true, f: Scope.() -> Unit): Result {
        assert(percentile > 0 && percentile <= 1.0)

        val timer = Timer(sampleCount)
        for (i in 0 until sampleCount) timer.dispatch(f)
        val result = timer.finish(percentile / 2.0f)

        if (log) {
            val trace = Thread.currentThread().stackTrace
            println(
                "${trace[1].className}.${trace[1].methodName} - Bench ${flag ?: ""} " +
                        "measured ${result.average}ns " +
                        "(+- ${result.distribution}ns) " +
                        "Best: ${result.best}ns, " +
                        "Worst ${result.worst}ns, " +
                        "Abs Best: ${result.totalBest}ns, " +
                        "Abs Worst: ${result.totalWorst}ns"
            )
        }

        return result
    }
}