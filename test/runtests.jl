using MonteCarloMeasurements
using Test
using Documenter

@testset "MonteCarloMeasurements.jl" begin
    
    @testset "name" begin
        @test name(TimeSeries("Walter White")) == "Walter White"
        @test name(AccumulatedSeries("Jessie Pinkman")) == "Jessie Pinkman"
    end

    @testset "Required Interface Functions" begin
        @test_throws MethodError let 
            struct Thing <: MonteCarloMeasurement val::Int end
            test_thing = Thing(42)
            push!(test_thing, 26)
        end
        
        @test_throws MethodError let 
            struct Thing <: MonteCarloMeasurement val::Int end
            test_thing = Thing(42)
            binning_analysis(test_thing)
        end
    end

    @testset "Measurements" begin
        
        for obs_type ∈ (:TimeSeries, :AccumulatedSeries)
            eval(quote
                acc = $obs_type()
                for idx ∈ 1:Int(2^18) push!(acc, idx % 512) end
                meas = measurement(acc)
                @test meas.val ≈ 255.5 
                @test isapprox(meas.err, 2.264245; atol = 1e-6)
            end)
        end

    end

    @testset "Doctests" begin
        DocMeta.setdocmeta!(MonteCarloMeasurements, :DocTestSetup, :(using MonteCarloMeasurements); recursive=true)
        doctest(MonteCarloMeasurements)
    end
end
