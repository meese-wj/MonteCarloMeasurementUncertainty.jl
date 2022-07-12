# The misspelling of AccumulatedSeries is to conform to Julia standards.
# Unfortunately 'Series' is both plural and singular 😢

"""
    AccumulatedSeries{T}(::String = "")  (default T == Float64)
    AccumulatedSeries{T}(::Int, ::String = "")  (default T == Float64)

A type of [`MonteCarloMeasurement`](@ref) that accumulates statistics for a 
given observable while performing an _online_ binning analysis provided
by [`OnlineLogBinning.jl`](https://meese-wj.github.io/OnlineLogBinning.jl/stable/).

!!! note 
    The _pre-allocated_ [`AccumulatedSeries`](@ref) takes an `Int`eger as the first argument,
    and a `String` as the second.
"""
struct AccumulatedSeries{T <: Number} <: MonteCarloMeasurement
    name::String
    datastream::BinningAccumulator{T}

    AccumulatedSeries{T}(name = "") where {T <: Number} = new( name, BinningAccumulator{T}() ) 
    AccumulatedSeries(name = "") = AccumulatedSeries{Float64}(name)

    AccumulatedSeries{T}(stream_length::Int, name = "") where {T} = new(name, BinningAccumulator{T}(stream_length))
    AccumulatedSeries(stream_length::Int, name = "") = AccumulatedSeries{Float64}(stream_length, name)
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