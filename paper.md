---
title: 'simBKMRdata: Correlated Exposure Simulation and Posterior Inclusion Probability Thresholds for Bayesian Kernel Machine Regression'
tags:
  - R
  - environmental epidemiology
  - exposure mixtures
  - simulation
  - Bayesian kernel machine regression
  - variable selection
authors:
  - name: Kazi Tanvir Hasan
    orcid: 0000-0002-7723-4177
    affiliation: [1, 2]
    corresponding: true
    email: khasa006@fiu.edu
  - name: Boubakari Ibrahimou
    orcid: 0000-0003-3173-4317
    affiliation: 2
  - name: Cristian Guerini
    orcid: 0009-0004-4480-5182
    affiliation: 3
  - name: Zoran Bursac
    orcid: 0000-0001-9306-0907
    affiliation: 2
  - name: Roberto Lucchini
    orcid: 0000-0002-9723-0237
    affiliation: 4
  - name: Gabriel Odom
    orcid: 0000-0003-1341-4555
    affiliation: 2
affiliations:
  - name: Department of Psychiatry, Yale School of Medicine, New Haven, Connecticut, United States
    index: 1
  - name: Department of Biostatistics, Robert Stempel College of Public Health & Social Work, Florida International University, Miami, Florida, United States
    index: 2
  - name: University of Brescia, Italy
    index: 3
  - name: Department of Environmental Health Sciences, Robert Stempel College of Public Health & Social Work, Florida International University, Miami, Florida, United States
    index: 4
date: 12 November 2026
bibliography: paper.bib
---
# Summary

Researchers studying combined exposures to environmental chemicals often encounter measurements that are positively skewed, correlated, and different across population subgroups. Bayesian kernel machine regression (BKMR) is one approach for examining potentially nonlinear associations between exposure mixtures and an outcome [@bobb2015]. Evaluating the behavior of these analyses requires simulated exposure data with specified distributions and dependence structures. `simBKMRdata` is an R package for estimating parameters from multivariate observations, generating correlated Gaussian and Gamma exposure data, simulating subgroup-specific datasets, applying transformations, and computing a response-dependent posterior inclusion probability (PIP) threshold. The package provides building blocks for reproducible simulation experiments rather than fitting BKMR models itself.

# Statement of need

Simulation experiments can expose sensitivity to sampling conditions that may be obscured by a single applied analysis. In environmental mixture studies, Gaussian simulations alone may not represent the skewness observed in biomarker concentrations, while subgroup heterogeneity may change marginal distributions and relationships among exposures. Researchers need to vary these features deliberately while retaining a transparent link between estimated sample characteristics and simulation inputs.

The `simBKMRdata` package is intended for statisticians, environmental epidemiologists, and researchers evaluating mixture methods. Its functions cover estimation of group-specific Gaussian and Gamma-related parameters, generation of multivariate synthetic exposures, and simple grouped data assembly. A separate function computes a PIP selection threshold from the response coefficient of variation and sample size, using coefficients from a simulation-calibrated generalized logistic relationship. The threshold is an empirical selection heuristic for the investigated simulation settings; it does **not** guarantee frequentist Type I error control.

Two related methodological studies motivate the software: a study of BKMR sensitivity to data distributions [@hasan_sensitivity] and work on dynamic PIP thresholds published initially as a preprint [@hasan_threshold], with a revised manuscript accepted by *Research in Statistics* in November 2026 (final journal citation pending). They address statistical methods and their evaluation; this paper describes the reusable software interface and its role in research workflows. The manuscript-specific research scripts, saved simulation outputs, and verification notes are preserved separately [@simbkmr_archive].

# State of the field

The R package `bkmr` implements Bayesian kernel machine regression, including posterior summaries for exposure-response relationships and PIPs [@bobb2015]. The `MASS` package supplies multivariate normal generation with `mvrnorm()` [@mass2002], and R's `stats` package supplies distribution functions and quantiles. These are essential building blocks but do not by themselves provide the package's subgroup estimation and simulation interfaces or its particular calibrated PIP rule. Other copula and multivariate simulation software can be used to generate non-Gaussian data; `simBKMRdata` is not presented as a new copula algorithm.

The rationale for maintaining this package separately, instead of extending `bkmr`, is that synthetic-data generation and simulation calibration are distinct from fitting an inferential model. A researcher may use the generated data with `bkmr`, another mixture model, or a benchmarking pipeline. The package offers a focused interface for the specific simulation conditions evaluated in the related methodological work, rather than replacing general-purpose simulation libraries.

# Software design

The package separates parameter estimation from data generation. Functions estimate multivariate moments or Gamma parameters from observed inputs, including by group; simulation functions then use explicit sample sizes, marginal parameters, and dependence matrices to generate synthetic samples. For multivariate Gamma variables, the implementation draws latent Gaussian observations, applies the standard normal cumulative distribution function, and transforms resulting probabilities through marginal Gamma quantiles. This yields specified Gamma marginals while retaining dependence through a Gaussian copula. The supplied matrix describes latent Gaussian dependence: Pearson and rank correlations after Gamma transformation need not equal its entries. For grouped Gaussian simulations, `simBKMRdata` constructs a covariance matrix by scaling the input correlation matrix with group-specific marginal standard deviations and passes it to `MASS::mvrnorm()`. When the correlations are estimated using Spearman's method, treating them as Pearson correlations in this covariance matrix is an approximation; the software does not automatically calibrate the two measures. Group-specific generators then combine the separately parameterized samples.

This composition permits parameter estimation and simulation to be tested separately and allows a common workflow across multiple subgroups. It also exposes limitations: users must supply valid model parameters and dependence matrices, and simulation outputs should be checked against target marginal and dependence summaries. The implementation prioritizes readability and standard R package conventions over replacing the numerical routines supplied by established dependencies.

The `calculate_pip_threshold()` function evaluates the calibrated logistic formula using the absolute response coefficient of variation and sample size, or a response vector from which these are calculated. When missing outcomes are excluded, the sample size is the number of nonmissing observations. Degenerate response inputs raise explicit errors. The calibrated coefficients are supplied as defaults but may be overridden. Its calibration depends on the underlying simulation design and outcome characteristics; it should not be interpreted as a universally validated decision boundary. Package help files, testthat checks, and Quarto vignettes document common usage and expected numerical behavior. The package is distributed through CRAN and developed publicly on GitHub [@simbkmrdata].

# Research impact statement

The software has documented research use by its developers in executable examples. The package's `bkmr_threshold.qmd` vignette applies `calculate_pip_threshold()` to a BKMR analysis of the existing children's metal-exposure example dataset, while `packageOverview.qmd` estimates group-specific Gamma parameters and generates synthetic exposures. Both were successfully rebuilt as package vignettes in automated R checks. These examples demonstrate functioning research workflows, but are not independent studies or evidence of adoption outside the author group.

Two methodological studies motivate the package: work on BKMR sensitivity to exposure distributions [@hasan_sensitivity] and simulation-calibrated PIP selection thresholds [@hasan_threshold]. The cited 2025 preprint precedes the revised manuscript accepted for publication in November 2026. The historical threshold script uses the same mathematical expression and default coefficients as the package, and saved-output checks reproduce the fitted coefficients [@simbkmr_archive]. However, these results do not establish that the released package was imported in either study. The original Gamma simulation used a different generator. We therefore distinguish the verified package-based examples from the studies that established the underlying methods; full historical BKMR MCMC reproduction and independent external use are not claimed.

# AI usage disclosure

Generative AI (OpenAI ChatGPT, GPT-6, November 2026) assisted with initial manuscript drafting, repository documentation, workflow configuration, code review, proposed bug fixes, and scaffolding regression tests. The underlying statistical methods and original research findings predate this assistance. The corresponding author confirms that the AI-assisted manuscript, documentation, code changes, and tests have been reviewed, edited, and validated by a human author. The authors take responsibility for the software, methodological decisions, and all scientific claims.

# Funding

No external funding was received for development of this software.

# References
