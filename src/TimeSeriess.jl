# The misspelling of TimeSeries is to conform to Julia standards.
# Unfortunately 'Series' is both plural and singular 😢

using Base

"""
    TimeSeries{T <: Number} <: MonteCarloMeasurement

A type of [`MonteCarloMeasurement`](@ref) that stores the measurements in a 
`datastream::Vector{T}`. Statistics are not accumulated in an _online_
way.
"""
struct TimeSeries{T <: Number} <: MonteCarloMeasurement
    name::String
    current_index::Int
    datastream::Vector{T}

    TimeSeries{T}(name = "", size = 1) where {T <: Number} = new(name, 1, zeros(T, size))
    TimeSeries(name = "", size = 1) = TimeSeries{Float64}(name, size)
end

Base.eltype(meas::TimeSeries) = eltype(meas.datastream)

function push!(meas::TimeSeries, single_value::Number)
    if meas.current_index == length(meas.datastream)
        push!(meas.datastream, convert(eltype(meas), single_value))
        return meas
    end
    meas.datastream[meas.current_index] = convert(eltype(meas), single_value)
    meas.current_index += 1
    return meas
end

function push!(meas::TimeSeries, values)
    for val ∈ values
        push!(meas, val)
    end
    return meas
end