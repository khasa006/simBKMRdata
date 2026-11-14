# simBKMRdata v0.2.3 — Release Candidate Handoff

**Prepared 14 November 2026. Status: unreleased; package-only PR #9 remains draft and unmerged.** This is a release plan, **not** a GitHub release, CRAN submission, release tag, or DOI.

## Release identity

- Software repository: https://github.com/khasa006/simBKMRdata
- Proposed version/tag: `0.2.3` / `v0.2.3`
- Proposed source branch: `fix-gaussian-pip-v0.2.3`
- Validated candidate commit: `4a99950409a26231f68ff3daa73368ce0c575553`
- Source: [draft PR #9](https://github.com/khasa006/simBKMRdata/pull/9)
- Code license: `GPL (>= 3)`, per package DESCRIPTION
- Released version on `main` / CRAN at review time: **0.2.2**
- Versioned software archive DOI: **not created**. The Zenodo DOI `10.5281/zenodo.24021746` is for the *different* historical research repo.

## Changes intended for the v0.2.3 release

1. Correct `simulate_group_gaussian()` to scale marginal standard deviations into the covariance matrix. This **changes** simulations from earlier versions for non-unit group SDs.
2. Correct `calculate_pip_threshold()` with missing outcome values so `na.rm = TRUE` derives sample size from the observed outcomes, with explicit checks for degenerate response values. The established threshold coefficients are unchanged.
3. Reject invalid Gamma simulation input parameters (`generate_mvGamma_data()`): sample count, shape/rate, and latent Gaussian correlation matrix. Preserve tabular dimensions for single-row and one-variable samples. Do **not** alter the Gaussian-copula transformation.
4. Update help files, tests, vignettes, package author metadata, DESCRIPTION and NEWS. Neither observed participant dataset was altered.

## Validation

- [GitHub Actions run 43634062129](https://github.com/khasa006/simBKMRdata/actions/runs/43634062129), code commit `4a99950409a26231f68ff3daa73368ce0c575553`: **R CMD check Status: OK** and testthat `[ FAIL 0 | WARN 0 | SKIP 0 | PASS 132 ]`.
- JOSS preparation branch with additional research/manuscript tests also passed: [run 43634286336](https://github.com/khasa006/simBKMRdata/actions/runs/43634286336), `[ FAIL 0 | WARN 0 | SKIP 0 | PASS 137 ]`.
- These are Linux GitHub Actions checks, not proof that the package has passed CRAN's incoming checks on every supported OS/R version.
- The release should be retested if the source changes or if PR #9 is rebased or merged, and ideally checked on Windows/macOS and current R release.

## Post-JOSS-review release procedure

JOSS guidance calls for a **versioned software release and software-specific archival DOI upon successful completion of review**: https://joss.readthedocs.io/en/latest/submitting.html. Do not tag early simply to put a software DOI into the draft manuscript.

After the JOSS editor indicates that the review is complete and requests the software archive:

1. Reconfirm source code/author approvals, original participant-data redistribution permission, JOSS agreed changes, and `R CMD check` on the intended final source.
2. Reconcile PR #9 with the exact reviewed software branch and any revised tests. If PR #8 remains separate, ensure that the **tagged code includes reviewed corrections** and does not accidentally roll back JOSS fixes. Merge only after verifying the precise desired contents and branch comparison.
3. Tag the reviewed software commit `v0.2.3`, publish a GitHub release with the notes in `NEWS.md`, and preserve the source tarball. Do not use a moving branch pointer as the archived software identifier.
4. Deposit **simBKMRdata** in Zenodo (separate project from `simBKMR`) or another supported archive, record its version-specific DOI, and report the exact tag/commit/DOI to the JOSS review thread.
5. Update software citation metadata in `paper.bib` if instructed by the editor and rebuild the final PDF.
6. Separately perform CRAN pre-flight/reverse-dependency and manual checks, then submit `0.2.3` through the official CRAN upload workflow when the maintainer elects to do so; a GitHub release is **not** a CRAN release.

## Explicit unresolved points

- The original April 3, 2025 permission email for the unchanged children's metal-exposure dataset has not been independently located; maintain the existing bytes and confirm public redistribution/de-identification for this specific derived dataset.
- No exact Spearman-to-Gaussian latent-correlation calibration is implemented. Upstream Spearman inputs are working correlations, not exact target post-transformation rank correlations.
- Group-wrapper validation and missingness policies remain scoped limitations. Avoid overstating numerical guarantees.
- JOSS editorial screening of research impact and public development history is separate from passing package checks.

**Stop state:** no tag, GitHub release, merge, archival DOI, CRAN submission, or JOSS submission performed by this handoff.
