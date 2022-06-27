module MonteCarloMeasurements

using OnlineLogBinning

export MonteCarloMeasurement, TimeSeries, AccumulatedSeries,
       # General MonteCarloMeasurement interface functions
       name

"""
    MonteCarloMeasurement

Abstract type that provides an interface for all `MonteCarloMeasurements`.

!!! note
    # Interface Functions
    The following _functions_ __must__ have `methods` defined for each new `MonteCarloMeasurement`.
    * [`name`](@ref): Define a `name` for a given `MonteCarloMeasurement` 
"""
abstract type MonteCarloMeasurement end

"""
    name(meas::MonteCarloMeasurement)

Return the `name` defined by the input [`MonteCarloMeasurement`](@ref).

```jldoctest
julia> meas = TimeSeries("Walter White");

julia> name(meas)
"Walter White"
```
"""
name(meas::MonteCarloMeasurement) = meas.name

# The misspelling of Series is to conform to Julia standards.
# Unfortunately 'Series' is both plural and singular 😢
include("TimeSeriess.jl")
include("AccumulatedSeriess.jl")


end # MonteCarloMeasurement