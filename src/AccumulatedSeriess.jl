# The misspelling of AccumulatedSeries is to conform to Julia standards.
# Unfortunately 'Series' is both plural and singular 😢

"""
    AccumulatedSeries{T}(::String = "")  (default T == Float64)
    AccumulatedSeries{T}(::String = "", [::Int])  (default T == Float64)

A type of [`MonteCarloMeasurement`](@ref) that accumulates statistics for a 
given observable while performing an _online_ binning analysis provided
by [`OnlineLogBinning.jl`](https://meese-wj.github.io/OnlineLogBinning.jl/stable/).

!!! note 
    The _pre-allocated_ [`AccumulatedSeries`](@ref) takes a `String` as the first argument
    and an `Int`eger denoting the anticipated datastream length as the second.
"""
struct AccumulatedSeries{T <: Number} <: MonteCarloMeasurement
    name::String
    datastream::BinningAccumulator{T}

    AccumulatedSeries{T}(name = "") where {T <: Number} = new( name, BinningAccumulator{T}() ) 

    function AccumulatedSeries{T}(name = "", stream_length::Int = zero(Int)) where {T}
        if stream_length == zero(Int)
            return AccumulatedSeries{T}(name)
        end
        return new(name, BinningAccumulator{T}(stream_length))
    end
    AccumulatedSeries(name = "", stream_length::Int = zero(Int)) = AccumulatedSeries{Float64}(name, stream_length)
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