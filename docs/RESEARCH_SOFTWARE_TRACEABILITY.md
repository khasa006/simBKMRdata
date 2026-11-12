# Research-to-software evidence map

This table records relationships between the published/accepted methodological work and the reusable package. It is **not** proof that a particular package release was imported by the original scripts. Human authors must verify precise provenance.

| Research component | Research artifact | Software component | Status |
| --- | --- | --- | --- |
| Exposure distribution and dependence simulations | [Project 1 original scripts](https://github.com/khasa006/simBKMR/tree/main/project1_bkmr_sensitivity/R_original) | `generate_mvGamma_data()`, `simulate_group_data()`, `simulate_group_gamma()`, `simulate_group_gaussian()` | Conceptual match; compare exact formulas, parameter conventions, random seeds, and call history |
| Gaussian and Gamma parameter estimation | Project 1 preparation / parameter scripts | `estimate_mv_moments()`, `estimate_mv_shape_rate()` and group wrappers | Code-level equivalence not yet established |
| Simulation-calibrated PIP threshold | [Project 2 original scripts](https://github.com/khasa006/simBKMR/tree/main/project2_dynamic_threshold/R_original) | `calculate_pip_threshold()` | Published rounded coefficients appear in the package; saved-output numerical audit exists; verify formula and calibration assumptions |
| Saved PIP audit | [Numerical verification](https://github.com/khasa006/simBKMR/blob/main/docs/NUMERICAL_VERIFICATION_2026-11-06.md) | Threshold function defaults | Coefficients reproduced from archived PIP values, **not** original MCMC |
| NHANES applied example | [NHANES provenance audit](https://github.com/khasa006/simBKMR/blob/main/docs/NHANES_PROVENANCE_AUDIT_2026-11-06.md) | `calculate_pip_threshold()` and BKMR vignette | Threshold arithmetic audited; NHANES MCMC not rerun |

## Research archive

Research scripts and selected data: https://github.com/khasa006/simBKMR

Versioned archive: https://doi.org/10.5281/zenodo.24021746

**Distinct licenses:** The software package declares GPL-3-or-later; the separate research repository uses CC0 for eligible author-owned materials. A research archive DOI is not a release DOI for the software package.

## Submission interpretation

Describe the package as a reusable implementation associated with the research. Do not assert that the exact released version was used in the original manuscripts unless confirmed with dated scripts, `library(simBKMRdata)` imports, source-file provenance, or an equivalent independent trace.
