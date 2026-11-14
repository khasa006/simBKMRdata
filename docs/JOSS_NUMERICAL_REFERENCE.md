# JOSS package-level numerical reference checks

The published `simBKMRdata` package (0.2.2) exposes `calculate_pip_threshold()`, which evaluates a fixed, simulation-calibrated curve. The research archive [simBKMR v1.0.0](https://doi.org/10.5281/zenodo.24021746) records independent recovery of its default rounded coefficients from saved PIP outputs.

## Documented coefficients and reference result

| Quantity | Value | Basis |
| --- | ---: | --- |
| C | 1.30460 | Rounded coefficient from archived PIP output fitting |
| betaAbsCV | 0.59867 | Rounded coefficient from archived PIP output fitting |
| betaSampSize | 0.43565 | Rounded coefficient from archived PIP output fitting |
| Absolute response CV | 15.18 | NHANES example; archived inputs audited separately |
| Sample size | 949 | NHANES example complete-case count |
| Calculated threshold | Approximately 0.646321317 | Formula with rounded coefficients |

Package-level test `tests/testthat/test-joss-numerical-reference.R` checks this threshold and a separate direct formula evaluation. The test verifies *arithmetic equivalence* with the package formula, **not** original MCMC reproducibility or statistical type-I-error control.

The archive [numerical verification report](https://github.com/khasa006/simBKMR/blob/main/docs/NUMERICAL_VERIFICATION_2026-11-06.md) further describes saved-output checks, with explicit methodological limitations.

## Remaining evidence

- Match package functions to dated manuscript scripts, including any precursor versions.
- Validate the Gamma generator against reference marginal moments and the chosen dependence measure.
- Verify handling of missing outcomes in `calculate_pip_threshold()`.
- Independently run the new test and the entire package suite with R; until then these are proposed tests, not passing results.
- Obtain review of the final JOSS author list and external software use claims.

The separate research repository is **not** modified by this check.
