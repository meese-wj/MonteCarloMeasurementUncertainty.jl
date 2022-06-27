using MonteCarloMeasurements
using Test

@testset "MonteCarloMeasurements.jl" begin
    
    @testset "name" begin
        @test name(TimeSeries("Walter White")) == "Walter White"
        @test name(AccumulatedSeries("Jessie Pinkman")) == "Jessie Pinkman"
    end
    
end
