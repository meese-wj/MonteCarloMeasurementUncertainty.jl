```@meta
CurrentModule = MonteCarloMeasurementUncertainty
```

# MonteCarloMeasurementUncertainty (MCMU) [![GithubLink](assets/GitHub-Mark-Light-32px.png)](https://github.com/meese-wj/MonteCarloMeasurementUncertainty.jl)

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://meese-wj.github.io/MonteCarloMeasurementUncertainty.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://meese-wj.github.io/MonteCarloMeasurementUncertainty.jl/dev)
[![Build Status](https://github.com/meese-wj/MonteCarloMeasurementUncertainty.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/meese-wj/MonteCarloMeasurementUncertainty.jl/actions/workflows/CI.yml?query=branch%3Amain)

This package converts a (correlated) data stream into a [`measurement`](@ref) with a `val`ue and `err`or with the help of the [`OnlineLogBinning.jl`](https://meese-wj.github.io/OnlineLogBinning.jl/stable/) and [`Measurements.jl`](https://juliaphysics.github.io/Measurements.jl/stable/) packages.

Add this package from Julia's [General Registry](https://github.com/JuliaRegistries/General) in any the usual way. For example, in the Julia `REPL`, simply hit `]` to open the `pkg` manager hosted by [`Pkg`](https://docs.julialang.org/en/v1/stdlib/Pkg/):

```julia
pkg> add MonteCarloMeasurementUncertainty
```

Then hit `Backspace` to exit `pkg` mode. And _voila!_ You now have access to [`MCMU`](https://github.com/meese-wj/MonteCarloMeasurementUncertainty.jl)!

## Contents

This short intro tutorial will have you on your way to taking [`MonteCarloMeasurement`](@ref)s with proper uncertainty analysis in no time!

```@contents
Pages = ["what_is_a_mcmeasurement.md", "example_usage.md", "api.md"]
Depth = 5
```
