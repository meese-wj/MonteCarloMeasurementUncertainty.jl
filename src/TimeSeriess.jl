# The misspelling of TimeSeries is to conform to Julia standards.
# Unfortunately 'Series' is both plural and singular 😢

"""
    TimeSeries{T <: Number} <: MonteCarloMeasurement

A type of [`MonteCarloMeasurement`](@ref) that stores the measurements in a 
`datastream::Vector{T}`. Statistics are not accumulated in an _online_
way.
"""
struct TimeSeries{T <: Number} <: MonteCarloMeasurement
    name::String
    datastream::Vector{T}

    TimeSeries{T}(name = "", size = 1) where {T <: Number} = new(name, zeros(T, size))
    TimeSeries(name = "", size = 1) = TimeSeries{Float64}(name, size)
end