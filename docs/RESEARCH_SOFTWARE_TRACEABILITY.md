# Research-to-software evidence map for JOSS

Updated 12 November 2026. This document distinguishes **confirmed executable research workflows using the package** from *historical methods lineage* and unverified external adoption. It is not evidence that the exact released package was imported by either original methodological study.

## Confirmed package-based research workflows

| Workflow | Package or research functions used | Verifiable implementation and execution | What this demonstrates |
| --- | --- | --- | --- |
| Applied exposure-mixture example with children's metal concentrations and IQ | `simBKMRdata::calculate_pip_threshold()`; `bkmr::kmbayes()`; `bkmr::ExtractPIPs()`; public dataset `metalExposChildren_df` included in the package | [`vignettes/bkmr_threshold.qmd`](../vignettes/bkmr_threshold.qmd), which reads the included dataset, log-transforms the five exposures, fits an illustrative 1,000-iteration BKMR model with variable selection, extracts PIPs, and calculates the empirical PIP threshold; successful [GitHub Actions R package check](https://github.com/khasa006/simBKMRdata/actions/runs/43345933384) reports **creating vignettes OK**, **package vignettes OK**, **rebuilding vignette outputs OK** | **Documented, executed developer research example** of integrating the released-package API with a BKMR analysis; not a published inference, independent replication, clinical conclusion, or evidence of external adoption. The fitted model is for illustration only. |
| Subgroup-specific exposure distribution estimation and simulation using an existing dataset | `calculate_stats_gamma()`, `simulate_group_data()`, `generate_mvGamma_data()` | [`vignettes/packageOverview.qmd`](../vignettes/packageOverview.qmd) includes parameter estimation by sex and generation of Gamma exposures from the estimates; the same GitHub Actions package-check logs report successful vignette creation and rebuilding | **Documented, executed developer workflow** showing estimation/simulation functionality. The latent Gaussian matrix is not a promise of exact empirical Spearman or Pearson correlation preservation. |
| Reproducible synthetic Gamma marginal / copula diagnostic | `generate_mvGamma_data()` | [`tests/testthat/test-joss-gamma-marginal-calibration.R`](../tests/testthat/test-joss-gamma-marginal-calibration.R) and [`R package checks`](https://github.com/khasa006/simBKMRdata/actions/runs/43345929147) | Tests demonstrate expected marginal moments and Gaussian-copula rank dependence within Monte Carlo tolerance; they are software tests, **not themselves proof of scientific publication impact**. |

The existing 437-row dataset may be used **only in its current distributed version**, as directed by the corresponding author. Identical binary file hashes were verified across `main`, the JOSS branch, and the 0.2.3 candidate. The dataset preparation script reports email permission from Roberto Lucchini on 3 April 2025 under CC BY 4.0, but the original permission record and data de-identification authorization were **not** independently verified in this audit.

## Historical research and methodological lineage (not evidence of original package imports)

| Research component | Historical source | Current software component | Verification |
| --- | --- | --- | --- |
| Simulation-calibrated PIP cutoff for the accepted dynamic-threshold study | [Original threshold comparison script](https://github.com/khasa006/simBKMR/blob/main/project2_dynamic_threshold/R_original/compareTestSize_20241211.R), lines 138–171 and 210–215 | `calculate_pip_threshold()` | **Direct mathematical correspondence** of the logistic form and rounded default coefficients `C=1.30460`, `betaAbsCV=0.59867`, `betaSampSize=0.43565`. This original script defines `pipThresh_fn()` locally rather than importing `simBKMRdata`. |
| Numerical verification of threshold coefficients and NHANES application | [Saved-PIP numerical audit](https://github.com/khasa006/simBKMR/blob/main/docs/NUMERICAL_VERIFICATION_2026-11-06.md) and [NHANES provenance audit](https://github.com/khasa006/simBKMR/blob/main/docs/NHANES_PROVENANCE_AUDIT_2026-11-06.md) | Threshold default coefficients | Saved-output reanalysis reports fitted values agreeing to five decimals, and approximately 0.64632 at CV=15.18 and n=949. **No independent full original BKMR MCMC reproduction is claimed.** |
| Original sensitivity-to-distribution study | [Historical Gamma simulation](https://github.com/khasa006/simBKMR/blob/main/project1_bkmr_sensitivity/R_original/createSImulatedData_20240111.R), lines 9–10 and 50–75 | `generate_mvGamma_data()`, `simulate_group_gamma()` | Historical code used `lcmix::rmvgamma()`, not the current package generator. Gamma-generation equivalence and direct original package usage are **not established**. |
| Historical NHANES urinary-metal analysis | [Original NHANES script](https://github.com/khasa006/simBKMR/blob/main/project2_dynamic_threshold/R_original/realDataAnalysis_20240110.R) | `calculate_pip_threshold()` | Script loads `bkmr` and `tidyverse` and calculates applied results without a visible `library(simBKMRdata)` import. Treat as related method, not proof that the package ran in that study. |

## Research publications connected to the methods

1. Hasan, K. T., Odom, G., Bursac, Z., and Ibrahimou, B. *The sensitivity of Bayesian kernel machine regression (BKMR) to data distribution: a comprehensive simulation analysis*, **Journal of Statistical Computation and Simulation** 96(7), 1752–1771, DOI: https://doi.org/10.1080/00949655.2025.2608780 (online December 2025).
2. Hasan et al. *Enhancing Bayesian Kernel Machine Regression: A Dynamic Thresholding Framework to Address Variability and Skewness in the Data*, **Research in Statistics**, accepted November 2026 (full bibliographic metadata and final DOI pending).

These works support the **scientific motivation, method lineage, and calibration context** of `simBKMRdata`, but are not cited as publications that demonstrably imported the released package. Package source was first made public in February 2025, after the dated 2024 research scripts.

## JOSS screening interpretation

JOSS accepts verifiable developer research use as minimum evidence, and its [submission screening guidance](https://joss.readthedocs.io/en/latest/submitting.html#pre-review-screening-criteria) recognizes clear integration in research workflows. The two executable vignettes therefore supply **specific developer-use evidence**, not merely future proposed use. However, reviewers may reasonably regard illustrative demonstrations as weaker evidence of **demonstrated research impact** than a research publication using the package, documented external adoption, or a separately executed analysis. No such stronger evidence has been verified here. The editorial decision belongs to JOSS.

The package has sustained public development since February 2025 by multiple contributors, including public GitHub issues and dated commits; this is independent context for JOSS's open-development screen, not proof of external research adoption.

## Reproducibility and restrictions

- R package source: https://github.com/khasa006/simBKMRdata
- JOSS draft and unreleased corrected 0.2.3 code: https://github.com/khasa006/simBKMRdata/pull/8
- Separate release-candidate PR (no release): https://github.com/khasa006/simBKMRdata/pull/9
- Read-only historical research scripts and selected saved outputs: https://github.com/khasa006/simBKMR
- Historical analysis archive DOI: https://doi.org/10.5281/zenodo.24021746

`simBKMRdata` is licensed GPL-3-or-later, whereas the historical research repository applies CC0 only to eligible research material. The research archive's DOI is **not** a software-release DOI for `simBKMRdata`. Do not merge, release, tag, or submit JOSS until explicitly requested.
