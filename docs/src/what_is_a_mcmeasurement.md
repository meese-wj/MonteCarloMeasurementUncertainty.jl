```@meta
CurrentModule = MonteCarloMeasurementUncertainty
```

# What is a [`MonteCarloMeasurement`](@ref)?

There are two defined [`MonteCarloMeasurement`](@ref)s that one can make:

* [`TimeSeries`](@ref): stores the entire data stream as a time record for further analysis
  * The memory cost is ``O(N)``.
  * The worst-case cost to [`push!`](@ref) data into a (pre-allocated) [`TimeSeries`](@ref) is ammortized at ``O(1)``. 
* [`AccumulatedSeries`](@ref): accumulates the data stream into a `BinningAccumulator` from [`OnlineLogBinning.jl`](https://meese-wj.github.io/OnlineLogBinning.jl/stable/).
  * The memory cost is ``O(\log N)``.
  * The worst-case cost to [`push!`](@ref) data into a (pre-allocated) [`AccumulatedSeries`](@ref) is also ``O(\log N)``.

!!! tip
    As one can see, there are inherent tradeoffs to saving either type of [`MonteCarloMeasurement`](@ref) generated from a simulation. A [`TimeSeries`](@ref) provides the most sweep-to-sweep information regarding the evolution of a particular measurement, but can be cost-prohibitive in the limit of long simulations with many measurements. An [`AccumulatedSeries`](@ref), on the other hand, is incredibly cheap to store, allowing for long runs with many different observables, but no fine detail about the temporal evolution can be recovered.
    
    In light of these tradeoffs, we recommend storing a few of the slowest-evolving (scalar) observables as [`TimeSeries`](@ref) and storing all others as [`AccumulatedSeries`](@ref).

After one is finished [`push!`](@ref)ing data into either `Series`, for example at the end of a Monte Carlo random walk, either [`MonteCarloMeasurement`](@ref) can be analyzed using a [`binning_analysis`](@ref) that returns a `BinningAnalysisResult` from [`OnlineLogBinning.jl`](https://meese-wj.github.io/OnlineLogBinning.jl/stable/). This provides as estimate of the `mean` of a given observable as well the variance of the mean (`var_of_mean`), assuming the data stream was correlated. Additionally, it provides other information about the stream, such as the effective _uncorrelated_ length of the stream, _etc._ -- see [`OnlineLogBinning.jl`: Perform the Binning Analysis](https://meese-wj.github.io/OnlineLogBinning.jl/stable/example/#Perform-the-Binning-Analysis) for details.

We extend the [`Measurements.jl`](https://juliaphysics.github.io/Measurements.jl/stable/) interface for our [`MonteCarloMeasurement`](@ref) as well by dispatching on their [`measurement`](@ref) function which transforms either a [`TimeSeries`](@ref) or an [`AccumulatedSeries`](@ref) into a [`Measurement`](https://github.com/JuliaPhysics/Measurements.jl/blob/5e84abee8ca66205d21cd654e9a2d7aa6fab9923/src/Measurements.jl#L36-L56). One can then make use of the [`Measurements.jl`](https://juliaphysics.github.io/Measurements.jl/stable/) package's propagation of error formulas, _etc._, for all of one's [`MonteCarloMeasurement`](@ref)s.

```@meta
DocTestSetup = nothing
```