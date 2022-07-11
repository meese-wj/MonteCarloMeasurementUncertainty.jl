# The misspelling of TimeSeries is to conform to Julia standards.
# Unfortunately 'Series' is both plural and singular 😢

"""
    TimeSeries{T <: Number} <: MonteCarloMeasurement

A type of [`MonteCarloMeasurement`](@ref) that stores the measurements in a 
`datastream::Vector{T}`. Statistics are not accumulated in an _online_
way.
"""
mutable struct TimeSeries{T <: Number} <: MonteCarloMeasurement
    name::String
    current_index::Int
    datastream::Vector{T}

    TimeSeries{T}(name = "", size = one(Int)) where {T <: Number} = new(name, one(Int), zeros(T, size))
    TimeSeries(name = "", size = one(Int)) = TimeSeries{Float64}(name, size)
end

"""
    eltype(meas::TimeSeries)

Base overload of `eltype`. A wrapper around `eltype(meas.datastream)`.
"""
eltype(meas::TimeSeries) = eltype(meas.datastream)

"""
    push!(meas::TimeSeries, single_value::Number)

`push!` a single numerical value into the datastream. If the current
datastream is full, meaning `length(meas.datastream) == meas.current_index`,
then the datastream is `resize!`d when the value is pushed. Can result in
`O(n)` complexity.
"""
function push!(meas::TimeSeries, single_value::Number)
    if meas.current_index == length(meas.datastream) + one(Int)
        push!(meas.datastream, convert(eltype(meas), single_value))
        meas.current_index += one(Int)
        return meas
    end
    meas.datastream[meas.current_index] = convert(eltype(meas), single_value)
    meas.current_index += one(Int)
    return meas
end

"""
    push!(meas::TimeSeries, value)

`push!` an iterable many `value`s into a [`TimeSeries`] `datastream`.

# Additional Information
If the values are sufficiently long, this will trigger the `datastream` to
be `resize!`d which can have `O(n)` complexity. It is preferred to 
preallocate the requisite memory with [`TimeSeries`](@ref)`(name, size)`.
"""
function push!(meas::TimeSeries, values)
    if length(values) + meas.current_index > length(meas.datastream)
        resize!(meas.datastream, length(values) + meas.current_index - one(Int))
    end
    for val ∈ values
        push!(meas, val)
    end
    return meas
end

"""
    binning_analysis(meas::TimeSeries)

Construct a `BinningAccumulator` and `push!` the datastream into it.
Then return the newly constructed `BinningAccumulator`.
"""
function binning_analysis(meas::TimeSeries) 
    bacc = BinningAccumulator{eltype(meas)}()
    push!(bacc, meas.datastream)
    return fit_RxValues(bacc)
end