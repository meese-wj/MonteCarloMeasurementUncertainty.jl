using MonteCarloMeasurements
using Documenter

DocMeta.setdocmeta!(MonteCarloMeasurements, :DocTestSetup, :(using MonteCarloMeasurements); recursive=true)

makedocs(;
    modules=[MonteCarloMeasurements],
    authors="W. Joe Meese <meese022@umn.edu> and contributors",
    repo="https://github.com/meese-wj/MonteCarloMeasurements.jl/blob/{commit}{path}#{line}",
    sitename="MonteCarloMeasurements.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://meese-wj.github.io/MonteCarloMeasurements.jl",
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
    repo="github.com/meese-wj/MonteCarloMeasurements.jl",
    devbranch="main",
)
