using MonteCarloMeasurements
using Test

@testset "MonteCarloMeasurements.jl" begin
    
    @testset "name" begin
        @test name(TimeSeries("Walter White")) == "Walter White"
        @test name(AccumulatedSeries("Jessie Pinkman")) == "Jessie Pinkman"
    end

    @testset "Required Interface Functions" begin
        @test_throws MethodError let 
            struct Thing <: MonteCarloMeasurement val::Int end
            test_thing = Thing(42)
            MonteCarloMeasurements.push!(test_thing, 26)
        end
        
        @test_throws MethodError let 
            struct Thing <: MonteCarloMeasurement val::Int end
            test_thing = Thing(42)
            binning_analysis(test_thing)
        end
    end
end
