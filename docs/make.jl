using MonteCarloMeasurementUncertainty
using Documenter

DocMeta.setdocmeta!(MonteCarloMeasurementUncertainty, :DocTestSetup, :(using MonteCarloMeasurementUncertainty); recursive=true)

makedocs(;
    modules=[MonteCarloMeasurementUncertainty],
    authors="W. Joe Meese <meese022@umn.edu> and contributors",
    repo="https://github.com/meese-wj/MonteCarloMeasurementUncertainty.jl/blob/{commit}{path}#{line}",
    sitename="MonteCarloMeasurementUncertainty.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://meese-wj.github.io/MonteCarloMeasurementUncertainty.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "What is a MonteCarloMeasurement?" => "what_is_a_mcmeasurement.md",
        "Example Usage" => "example_usage.md",
        "API Reference" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/meese-wj/MonteCarloMeasurementUncertainty.jl",
    devbranch="main",
)
