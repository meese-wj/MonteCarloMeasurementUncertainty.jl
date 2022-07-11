# The misspelling of AccumulatedSeries is to conform to Julia standards.
# Unfortunately 'Series' is both plural and singular 😢

"""
    AccumulatedSeries{T <: Number} <: MonteCarloMeasurement

A type of [`MonteCarloMeasurement`](@ref) that accumulates statistics for a 
given observable while performing an _online_ binning analysis provided
by [`OnlineLogBinning.jl`](https://meese-wj.github.io/OnlineLogBinning.jl/dev/).
"""
struct AccumulatedSeries{T <: Number} <: MonteCarloMeasurement
    name::String
    datastream::BinningAccumulator{T}

    AccumulatedSeries{T}(name = "") where {T <: Number} = new( name, BinningAccumulator{T}() ) 
    AccumulatedSeries(name = "") = AccumulatedSeries{Float64}(name)
end

"""
    push!(meas::AccumulatedSeries, value)

`push!` a single `value` or many `value`s into a [`AccumulatedSeries`] `datastream`.
"""
push!(meas::AccumulatedSeries, value) = begin push!(meas.datastream, value); return meas end

"""
    binning_analysis(meas::AccumulatedSeries)

Return the `BinningAccumulator` from the [`AccumulatedSeries`](@ref).
"""
binning_analysis(meas::AccumulatedSeries) = fit_RxValues(meas.datastream)