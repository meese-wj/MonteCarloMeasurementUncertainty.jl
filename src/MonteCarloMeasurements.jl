module MonteCarloMeasurements

using OnlineLogBinning

export MonteCarloMeasurement, TimeSeries, AccumulatedSeries,
       # General MonteCarloMeasurement interface functions
       name, push!

"""
    MonteCarloMeasurement

Abstract type that provides an interface for all `MonteCarloMeasurements`.

!!! warning
    ### Required Interface Functions
    The following _functions_ __must__ have `methods` defined for each new `MonteCarloMeasurement`.
    * [`push!`](@ref): Move a new measurement into the `MonteCarloMeasurement` instance.

!!! note
    ### Default Interface Functions
    The following _functions_ have a default `method` for any given `MonteCarloMeasurement`.
        * [`name`](@ref): Define a `name` for a given `MonteCarloMeasurement` 
"""
abstract type MonteCarloMeasurement end
# *******************************************************************************************************************
# * Required Interface Functions ************************************************************************************
# *******************************************************************************************************************
push!(meas::MonteCarloMeasurement, value) = throw(MethodError(push!, (meas, value,)))

# *******************************************************************************************************************
# * Default Interface Functions *************************************************************************************
# *******************************************************************************************************************
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

# *******************************************************************************************************************
# * Defined subtypes of MonteCarloMeasurements **********************************************************************
# *******************************************************************************************************************

# The misspelling of Series is to conform to Julia standards.
# Unfortunately 'Series' is both plural and singular 😢
include("TimeSeriess.jl")
include("AccumulatedSeriess.jl")


end # MonteCarloMeasurement