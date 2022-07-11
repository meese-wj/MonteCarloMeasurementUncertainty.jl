module MonteCarloMeasurements

# Module imports
import Base: eltype, push!
import OnlineLogBinning: BinningAccumulator, fit_RxValues
import Measurements: measurement

export MonteCarloMeasurement, TimeSeries, AccumulatedSeries,
#      General MonteCarloMeasurement interface functions
       name, push!, binning_analysis, measurement

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
    * [`name`](@ref): Define a `name` for a given `MonteCarloMeasurement` instance. 
    * [`measurement`](@ref): Construct a measurement from [`Measurements.jl`](https://github.com/JuliaPhysics/Measurements.jl).
"""
abstract type MonteCarloMeasurement end
# *******************************************************************************************************************
# * Required Interface Functions ************************************************************************************
# *******************************************************************************************************************
push!(meas::MonteCarloMeasurement, value) = throw(MethodError(push!, (meas, value,)))
binning_analysis(meas::MonteCarloMeasurement) = throw(MethodError(binning_analysis, (meas,)))

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

"""
    measurement(::MonteCarloMeasurement)

Dispatch on [`measurement`](https://github.com/JuliaPhysics/Measurements.jl/blob/5e84abee8ca66205d21cd654e9a2d7aa6fab9923/src/Measurements.jl#L106-L119)
from [`Measurements.jl`](https://github.com/JuliaPhysics/Measurements.jl) for a [`MonteCarloMeasurement`](@ref). 
This will call a [`binning_analysis`](@ref) on the datastream stored in the argument.

```jldoctest measurement_example
julia> acc = AccumulatedSeries("Measurement Test");

julia> for idx ∈ 1:Int(2^18) push!(acc, idx % 512) end;

julia> measurement(acc)
255.5 ± 2.3
```
Compare this [`measurement`](https://github.com/JuliaPhysics/Measurements.jl/blob/5e84abee8ca66205d21cd654e9a2d7aa6fab9923/src/Measurements.jl#L106-L119)
outcome to that of the [`binning_analysis`](@ref).

```jldoctest measurement_example
julia> binning_analysis(acc) 
Binning Analysis Result:
    Plateau Present:             true
    Fitted Rx Plateau:           61.513088051303235
    Autocorrelation time τₓ:     30.256544025651618
    Effective Datastream Length: 4261
    Binning Analysis Mean:       255.5
    Binning Analysis Error:      2.264245800097835
```
"""
function measurement(obs::MonteCarloMeasurement) 
    result = binning_analysis(obs)
    return measurement( result.binning_mean, result.binning_error )
end

# *******************************************************************************************************************
# * Defined subtypes of MonteCarloMeasurements **********************************************************************
# *******************************************************************************************************************

# The misspelling of Series is to conform to Julia standards.
# Unfortunately 'Series' is both plural and singular 😢
include("TimeSeriess.jl")
include("AccumulatedSeriess.jl")


end # MonteCarloMeasurement