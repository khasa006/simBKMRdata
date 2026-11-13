# simBKMRdata 0.2.3

* Corrected `simulate_group_gaussian()` to use group-specific marginal
  standard deviations when constructing a covariance matrix:
  `diag(sampSD) %*% sampCorr_mat %*% diag(sampSD)`. Previously,
  `sampSD` was ignored and unit marginal variances were generated when
  a correlation matrix was supplied. This **changes simulated values**
  for any group with non-unit `sampSD`.
* Corrected `calculate_pip_threshold(y = ..., na.rm = TRUE)` to use the
  number of nonmissing outcomes in the calibration sample-size term.
  Previously, missing outcomes were still counted. Complete-case
  calculations and the published default coefficients are unchanged.
* Added validation for degenerate or nonfinite threshold inputs and
  incompatible Gaussian group parameters, with regression tests.
* Clarified the statistical convention: `sampCorr_mat` is treated as a
  working Pearson correlation matrix when constructing Gaussian
  covariance. Upstream estimated Spearman correlations do not necessarily
  equal the Pearson correlations in the generated sample.
* The threshold remains an empirical simulation-calibrated selection rule,
  not guaranteed frequentist Type I error control.

# simBKMRdata 0.2.2

* Added a comprehensive `testthat` edition 3 test suite covering all exported
  functions, including PIP-threshold calculation, transformations, moment and
  Gamma-parameter estimation, multivariate Gamma generation, and grouped
  Gaussian/Gamma simulation workflows.
* Moved package tests to the standard `tests/testthat/` location used by
  `R CMD check`.
* Clarified the documented Gaussian simulation behavior: when
  `sampCorr_mat` is supplied to `MASS::mvrnorm()`, it is used directly as
  `Sigma`. Thus, a correlation matrix produces standardized Gaussian variables
  with unit marginal variances. The Gaussian simulation implementation itself
  is unchanged in this release.
* Added the package website/source repository and bug-report URLs to
  `DESCRIPTION`.
* Updated package references in `DESCRIPTION`.

# simBKMRdata 0.2.1

* Corrected estimates in `calculate_pip_threshold()`.
* Collected feedback from remaining authors and made corresponding changes in
  the vignettes; updated package author information.
* Prepared vignette materials for journal submission.

# simBKMRdata 0.1.1

* Fixed issues identified during CRAN review.

# simBKMRdata 0.1.0

* Initial release.
