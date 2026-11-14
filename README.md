# simBKMRdata

**simBKMRdata** is an R package for simulation studies of correlated Gaussian and Gamma exposure data, subgroup-specific distributional parameter estimation, data transformation, and calculation of an empirical PIP threshold for Bayesian kernel machine regression (BKMR).

It supplies simulation and calibration functions; the separate [bkmr](https://cran.r-project.org/package=bkmr) package fits BKMR models.

## Installation

The released package can be installed from CRAN:

```r
install.packages("simBKMRdata")
library(simBKMRdata)
```

## Minimal example

Generate four correlated Gamma exposure variables using a latent Gaussian correlation matrix:

```r
library(simBKMRdata)
set.seed(2026)
latent_cor <- matrix(0.3, nrow = 4, ncol = 4)
diag(latent_cor) <- 1
z <- generate_mvGamma_data(
  sampSize = 200,
  sampCorr_mat = latent_cor,
  shape_num = c(2, 3, 4, 5),
  rate_num = c(1, 1, 2, 2)
)
head(z)
```

The correlation matrix characterizes the *latent Gaussian variables*. Correlations observed after applying Gamma quantile transformations generally differ. Assess simulated moments and dependence for each study design.

Estimate a response-dependent PIP selection threshold:

```r
threshold <- calculate_pip_threshold(absCV = 7.5, sampSize = 300)
threshold
# Approximately 0.6549943 with the default coefficients
```

The dynamic threshold is a **simulation-calibrated selection heuristic**, not a guarantee of nominal frequentist Type I error control. Application outside the calibration design requires independent validation.

## Documentation and examples

- [Package overview](vignettes/packageOverview.qmd)
- [Estimation and simulation](vignettes/estimation_and_simulation.qmd)
- [Dynamic PIP threshold example](vignettes/bkmr_threshold.qmd)
- [Function reference](man/)
- [Tests](tests/testthat/)

The current examples include analysis of a metal-exposure dataset. Verify data provenance and all redistribution permissions before reusing such data.

## Research background

The package was developed in connection with:

1. Hasan et al., *The sensitivity of Bayesian kernel machine regression (BKMR) to data distribution: a comprehensive simulation analysis*, *Journal of Statistical Computation and Simulation*, DOI: [10.1080/00949655.2025.2608780](https://doi.org/10.1080/00949655.2025.2608780).
2. Hasan et al., *Enhancing Bayesian Kernel Machine Regression: A Dynamic Thresholding Framework to Address Variability and Skewness in the Data*, accepted in *Research in Statistics* (November 2026; final bibliographic information pending).

Historical manuscript analysis scripts, selected output data, and verification materials are preserved in [simBKMR](https://github.com/khasa006/simBKMR), [research archive DOI 10.5281/zenodo.24021746](https://doi.org/10.5281/zenodo.24021746).

The research archive documents numerical verification from saved PIP outputs, but does not claim to reproduce every original BKMR model fit end to end. Precise provenance relating original study scripts to released package functions is still under author review.

## Citing

For methodological claims, cite the corresponding research article. For reproducible research code, cite the [simBKMR research archive](https://doi.org/10.5281/zenodo.24021746). When a dedicated software version DOI for `simBKMRdata` is archived, cite that DOI as well. The research-data archive DOI is **not** a versioned software archive for this R package.

## Development and support

The code is developed openly on [GitHub](https://github.com/khasa006/simBKMRdata). See [contributing instructions](CONTRIBUTING.md), [support](SUPPORT.md), [news](NEWS.md), and the [issue tracker](https://github.com/khasa006/simBKMRdata/issues).

**Software license:** GNU General Public License version 3 or later (`GPL (>= 3)` in `DESCRIPTION`). Third-party data retain their own applicable conditions.

## JOSS manuscript

The [JOSS draft](paper.md) and [submission status checklist](docs/JOSS_SUBMISSION_CHECKLIST.md) are under preparation and are not evidence that the software has already been accepted or reviewed by JOSS.
