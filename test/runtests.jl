using MonteCarloMeasurementUncertainty
using Test
using Documenter

@testset "MonteCarloMeasurementUncertainty.jl" begin
    
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

                # check for proper propagated error from Measurements.jl
                prop_meas = (meas / meas.val)^2 - meas / meas.val + meas / meas.val * exp( - (meas / meas.val) )
                @test prop_meas.val ≈ exp(-1)
                @test prop_meas.err ≈ ( meas.err / meas.val )
            end)
        end

        @testset "Analysis Equivalence" begin
            for obs_type ∈ (:TimeSeries, :AccumulatedSeries)
                eval(quote
                    $( Symbol("acc_$(obs_type)") ) = $obs_type()
                    for idx ∈ 1:Int(2^18) push!($( Symbol("acc_$(obs_type)") ), idx % 512) end
                    $( Symbol("result_$(obs_type)") ) = binning_analysis($( Symbol("acc_$(obs_type)") ))
                end)
            end
        
            @test result_TimeSeries.plateau_found == result_AccumulatedSeries.plateau_found
            @test result_TimeSeries.RxAmplitude ≈ result_AccumulatedSeries.RxAmplitude
            @test result_TimeSeries.effective_length == result_AccumulatedSeries.effective_length
            @test result_TimeSeries.binning_mean ≈ result_AccumulatedSeries.binning_mean
            @test result_TimeSeries.binning_error ≈ result_AccumulatedSeries.binning_error
        end
    end

    @testset "Doctests" begin
        DocMeta.setdocmeta!(MonteCarloMeasurementUncertainty, :DocTestSetup, :(using MonteCarloMeasurementUncertainty); recursive=true)
        doctest(MonteCarloMeasurementUncertainty)
    end
end
