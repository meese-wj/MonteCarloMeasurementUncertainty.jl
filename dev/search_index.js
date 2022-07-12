var documenterSearchIndex = {"docs":
[{"location":"api/#MonteCarloMeasurements-API","page":"API Reference","title":"MonteCarloMeasurements API","text":"","category":"section"},{"location":"api/","page":"API Reference","title":"API Reference","text":"","category":"page"},{"location":"api/","page":"API Reference","title":"API Reference","text":"Modules = [MonteCarloMeasurements]","category":"page"},{"location":"api/#MonteCarloMeasurements.AccumulatedSeries","page":"API Reference","title":"MonteCarloMeasurements.AccumulatedSeries","text":"AccumulatedSeries{T}(::String = \"\")  (default T == Float64)\nAccumulatedSeries{T}(::String = \"\", [::Int])  (default T == Float64)\n\nA type of MonteCarloMeasurement that accumulates statistics for a  given observable while performing an online binning analysis provided by OnlineLogBinning.jl.\n\nnote: Note\nThe pre-allocated AccumulatedSeries takes a String as the first argument and an Integer denoting the anticipated datastream length as the second.\n\n\n\n\n\n","category":"type"},{"location":"api/#MonteCarloMeasurements.MonteCarloMeasurement","page":"API Reference","title":"MonteCarloMeasurements.MonteCarloMeasurement","text":"MonteCarloMeasurement\n\nAbstract type that provides an interface for all MonteCarloMeasurements.\n\nwarning: Warning\nRequired Interface FunctionsThe following functions must have methods defined for each new MonteCarloMeasurement.push!: Move a new measurement into the MonteCarloMeasurement instance.\n\nnote: Note\nDefault Interface FunctionsThe following functions have a default method for any given MonteCarloMeasurement.name: Define a name for a given MonteCarloMeasurement instance. \nmeasurement: Construct a measurement from Measurements.jl.\n\n\n\n\n\n","category":"type"},{"location":"api/#MonteCarloMeasurements.TimeSeries","page":"API Reference","title":"MonteCarloMeasurements.TimeSeries","text":"TimeSeries{T <: Number} <: MonteCarloMeasurement\n\nA type of MonteCarloMeasurement that stores the measurements in a  datastream::Vector{T}. Statistics are not accumulated in an online way.\n\n\n\n\n\n","category":"type"},{"location":"api/#Base.eltype-Tuple{TimeSeries}","page":"API Reference","title":"Base.eltype","text":"eltype(meas::TimeSeries)\n\nBase overload of eltype. A wrapper around eltype(meas.datastream).\n\n\n\n\n\n","category":"method"},{"location":"api/#Base.push!-Tuple{AccumulatedSeries, Any}","page":"API Reference","title":"Base.push!","text":"push!(meas::AccumulatedSeries, value)\n\npush! a single value or many values into a [AccumulatedSeries] datastream.\n\n\n\n\n\n","category":"method"},{"location":"api/#Base.push!-Tuple{TimeSeries, Any}","page":"API Reference","title":"Base.push!","text":"push!(meas::TimeSeries, value)\n\npush! an iterable many values into a [TimeSeries] datastream.\n\nAdditional Information\n\nIf the values are sufficiently long, this will trigger the datastream to be resize!d which can have O(n) complexity. It is preferred to  preallocate the requisite memory with TimeSeries(name, size).\n\n\n\n\n\n","category":"method"},{"location":"api/#Base.push!-Tuple{TimeSeries, Number}","page":"API Reference","title":"Base.push!","text":"push!(meas::TimeSeries, single_value::Number)\n\npush! a single numerical value into the datastream. If the current datastream is full, meaning length(meas.datastream) == meas.current_index, then the datastream is resize!d when the value is pushed. Can result in O(n) complexity.\n\n\n\n\n\n","category":"method"},{"location":"api/#Measurements.measurement-Tuple{MonteCarloMeasurement}","page":"API Reference","title":"Measurements.measurement","text":"measurement(::MonteCarloMeasurement)\n\nDispatch on measurement from Measurements.jl for a MonteCarloMeasurement.  This will call a binning_analysis on the datastream stored in the argument.\n\njulia> acc = AccumulatedSeries(\"Measurement Test\");\n\njulia> for idx ∈ 1:Int(2^18) push!(acc, idx % 512) end;\n\njulia> measurement(acc)\n255.5 ± 2.3\n\n\n\n\n\n","category":"method"},{"location":"api/#MonteCarloMeasurements.binning_analysis-Tuple{AccumulatedSeries}","page":"API Reference","title":"MonteCarloMeasurements.binning_analysis","text":"binning_analysis(meas::AccumulatedSeries)\n\nReturn the BinningAccumulator from the AccumulatedSeries.\n\n\n\n\n\n","category":"method"},{"location":"api/#MonteCarloMeasurements.binning_analysis-Tuple{TimeSeries}","page":"API Reference","title":"MonteCarloMeasurements.binning_analysis","text":"binning_analysis(meas::TimeSeries)\n\nConstruct a BinningAccumulator and push! the datastream into it. Then return the newly constructed BinningAccumulator.\n\n\n\n\n\n","category":"method"},{"location":"api/#MonteCarloMeasurements.name-Tuple{MonteCarloMeasurement}","page":"API Reference","title":"MonteCarloMeasurements.name","text":"name(meas::MonteCarloMeasurement)\n\nReturn the name defined by the input MonteCarloMeasurement.\n\njulia> meas = TimeSeries(\"Walter White\");\n\njulia> name(meas)\n\"Walter White\"\n\n\n\n\n\n","category":"method"},{"location":"what_is_a_mcmeasurement/","page":"What is a MonteCarloMeasurement?","title":"What is a MonteCarloMeasurement?","text":"CurrentModule = MonteCarloMeasurements","category":"page"},{"location":"what_is_a_mcmeasurement/#What-is-a-[MonteCarloMeasurement](@ref)?","page":"What is a MonteCarloMeasurement?","title":"What is a MonteCarloMeasurement?","text":"","category":"section"},{"location":"what_is_a_mcmeasurement/","page":"What is a MonteCarloMeasurement?","title":"What is a MonteCarloMeasurement?","text":"There are two defined MonteCarloMeasurements that one can make:","category":"page"},{"location":"what_is_a_mcmeasurement/","page":"What is a MonteCarloMeasurement?","title":"What is a MonteCarloMeasurement?","text":"TimeSeries: stores the entire data stream as a time record for further analysis\nThe memory cost is O(N).\nThe worst-case cost to push! data into a (pre-allocated) TimeSeries is ammortized at O(1). \nAccumulatedSeries: accumulates the data stream into a BinningAccumulator from OnlineLogBinning.jl.\nThe memory cost is O(log N).\nThe worst-case cost to push! data into a (pre-allocated) AccumulatedSeries is also O(log N).","category":"page"},{"location":"what_is_a_mcmeasurement/","page":"What is a MonteCarloMeasurement?","title":"What is a MonteCarloMeasurement?","text":"tip: Tip\nAs one can see, there are inherent tradeoffs to saving either type of MonteCarloMeasurement generated from a simulation. A TimeSeries provides the most sweep-to-sweep information regarding the evolution of a particular measurement, but can be cost-prohibitive in the limit of long simulations with many measurements. An AccumulatedSeries, on the other hand, is incredibly cheap to store, allowing for long runs with many different observables, but no fine detail about the temporal evolution can be recovered.In light of these tradeoffs, we recommend storing a few of the slowest-evolving (scalar) observables as TimeSeries and storing all others as AccumulatedSeries.","category":"page"},{"location":"what_is_a_mcmeasurement/","page":"What is a MonteCarloMeasurement?","title":"What is a MonteCarloMeasurement?","text":"After one is finished push!ing data into either Series, for example at the end of a Monte Carlo random walk, either MonteCarloMeasurement can be analyzed using a binning_analysis that returns a BinningAnalysisResult from OnlineLogBinning.jl. This provides as estimate of the mean of a given observable as well the variance of the mean (var_of_mean), assuming the data stream was correlated. Additionally, it provides other information about the stream, such as the effective uncorrelated length of the stream, etc. – see OnlineLogBinning.jl: Perform the Binning Analysis for details.","category":"page"},{"location":"what_is_a_mcmeasurement/","page":"What is a MonteCarloMeasurement?","title":"What is a MonteCarloMeasurement?","text":"We extend the Measurements.jl interface for our MonteCarloMeasurement as well by dispatching on their measurement function which transforms either a TimeSeries or an AccumulatedSeries into a Measurement. One can then make use of the Measurements.jl package's propagation of error formulas, etc., for all of one's MonteCarloMeasurements.","category":"page"},{"location":"what_is_a_mcmeasurement/","page":"What is a MonteCarloMeasurement?","title":"What is a MonteCarloMeasurement?","text":"DocTestSetup = nothing","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = MonteCarloMeasurements","category":"page"},{"location":"#MonteCarloMeasurements","page":"Home","title":"MonteCarloMeasurements","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: Stable) (Image: Dev) (Image: Build Status)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Documentation for MonteCarloMeasurements.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Pages = [\"what_is_a_mcmeasurement.md\", \"example_usage.md\", \"api.md\"]\nDepth = 5","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"CurrentModule = MonteCarloMeasurements\nDocTestSetup = quote using MonteCarloMeasurements end","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"using MonteCarloMeasurements","category":"page"},{"location":"example_usage/#Example-[MonteCarloMeasurement](@ref)-Usage","page":"Example Usage","title":"Example MonteCarloMeasurement Usage","text":"","category":"section"},{"location":"example_usage/#Generating-a-correlated-datastream","page":"Example Usage","title":"Generating a correlated datastream","text":"","category":"section"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"Consider a datastream generated by the following code snippet:","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"julia> stream_length = Int(2^14)\n16384\n\njulia> datastream = zeros(Float64, stream_length);\n\njulia> for idx in 1:stream_length\n           datastream[idx] = cos( π * idx / 8 ) + (idx % 4) * sin( π * idx / 4 )\n       end","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"The function above is crazy and meaningless and just something I made up with correlations. Now we are going to analyze it using both a TimeSeries and an AccumulatedSeries.","category":"page"},{"location":"example_usage/#Initialization","page":"Example Usage","title":"Initialization","text":"","category":"section"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"One can initialize both MonteCarloMeasurements using the following pre-allocating constructors:","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"julia> t_series = TimeSeries(\"Time Series\", stream_length);\n\njulia> a_series = AccumulatedSeries(\"Accumulated Series\", stream_length);\n","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"Note, one does not need to specify the stream_length, but then there is no pre-allocated memory. The first argument, a String representing the name of a given MonteCarloMeasurement is optional with the default being empty: \"\". However, this name can prove helpful as labels in later analysis or for saving the data. We can retrieve it for an arbitrary MonteCarloMeasurement using the name function as:","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"julia> name(t_series) == \"Time Series\"\ntrue\n\njulia> name(a_series) == \"Accumulated Series\"\ntrue","category":"page"},{"location":"example_usage/#[push!](@ref)ing-data-into-the-[MonteCarloMeasurement](@ref)s","page":"Example Usage","title":"push!ing data into the MonteCarloMeasurements","text":"","category":"section"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"At this point, we must input the data from the datastream into each measurement. We do this using the push! functionality:","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"julia> push!(t_series, datastream);\n\njulia> push!(a_series, datastream);","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"We note that it's also possible to push! single values into MonteCarloMeasurements rather than a whole Vector of values.","category":"page"},{"location":"example_usage/#Analyzing-the-datastream","page":"Example Usage","title":"Analyzing the datastream","text":"","category":"section"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"Finally, we are in a position to analyze the datastream collected by either the TimeSeries or the AccumulatedSeries. ","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"To do so, we can either apply a binning_analysis like the following for the TimeSeries:","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"julia> binning_analysis(t_series)\nBinning Analysis Result:\n    Plateau Present:             true\n    Fitted Rx Plateau:           1.0\n    Autocorrelation time τₓ:     0.0\n    Effective Datastream Length: 16384\n    Binning Analysis Mean:       -3.6166273968685214e-16\n    Binning Analysis Error:      0.012955960977911544","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"Similarly, we can apply it to the AccumulatedSeries:","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"julia> binning_analysis(a_series)\nBinning Analysis Result:\n    Plateau Present:             true\n    Fitted Rx Plateau:           1.0\n    Autocorrelation time τₓ:     0.0\n    Effective Datastream Length: 16384\n    Binning Analysis Mean:       -3.6166273968685214e-16\n    Binning Analysis Error:      0.012955960977911544","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"Moreover, one can choose to export either MonteCarloMeasurement with the measurement function extended from the Measurements.jl package.","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"julia> measurement(t_series)\n-3.6e-16 ± 0.013\n\njulia> measurement(a_series)\n-3.6e-16 ± 0.013","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"Importantly, this then provides an interface between this MonteCarloMeasurements.jl package and the utilities found in the Measurements.jl package since the return type of measurement is given by","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"julia> typeof( measurement(t_series) )\nMeasurements.Measurement{Float64}","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"note: Note\nThe measurement function automatically calls binning_analysis on any MonteCarloMeasurement argument.","category":"page"},{"location":"example_usage/","page":"Example Usage","title":"Example Usage","text":"DocTestSetup = nothing","category":"page"}]
}
