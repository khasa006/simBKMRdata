# Release candidate and JOSS readiness audit

**Reviewed:** 12 November 2026 (US Eastern; GitHub workflows run on 13 November UTC).  
**Status:** Source prepared for scientific review, **not released, merged, or submitted to JOSS**.

## Scope and evidence

Audited the public `simBKMRdata` repository's two draft pull requests, core statistical source, matching tests and help files, `DESCRIPTION`, `NEWS.md`, `.Rbuildignore`, vignettes, JOSS manuscript and PDF compilation, GitHub Actions, historical commits, public issues, CRAN 0.2.2 listing, and read-only historical analysis scripts from `simBKMR`. This is a repository/documentary audit and not independent execution of the research simulations or a human review of confidential original dataset permissions.

| Item | Evidence | Result |
| --- | --- | --- |
| Version control | PR #8 `joss-submission-preparation-2026-11`; PR #9 `fix-gaussian-pip-v0.2.3` | Both open and draft, unmerged; `main` unchanged. |
| Candidate version | `DESCRIPTION` and `NEWS.md` on both draft branches | 0.2.3 proposed only; CRAN remains 0.2.2. |
| Gaussian correction | `R/SimulateGroupGaussian.R` and `test-simulate-group-wrappers.R` | Marginal SDs enter covariance `diag(sampSD) %*% R %*% diag(sampSD)`; tests cover SD recovery and invalid matrices. Input estimated Spearman coefficients are *working Pearson* entries, not exactly calibrated rank correlations. |
| PIP missingness correction | `R/CalculatePipThreshold.R` and `test-calculate-pip-threshold.R` | With `na.rm=TRUE`, sample size excludes missing outcomes; invalid responses rejected. Complete-case formula and default coefficients unchanged. Calibration does not establish formal frequentist Type I error control. |
| Core source synchronization | Compared SHA of eight corresponding core code, help, test, and metadata files across PR #8 and #9, then synchronized new documentation changes | Core statistical corrections match across branches. |
| Automated R package validation | GitHub R package checks succeeded for PR #8 at commit `cfc16018be60e484d153ad436a7ee6eafabc567b` and PR #9 at `49c356ff72a6885b9ef910db475c74376dcc9ff0` | Previous head checks passed; further `NEWS`, `.Rbuildignore`, vignette, and data-documentation edits require new head CI confirmation. Linux `--as-cran --no-manual` only; not a cross-platform check of 0.2.3. |
| JOSS draft | GitHub Actions JOSS paper workflow | PDF compilation succeeded on multiple branch revisions; inspect final PDF before submission. |
| R CMD check NOTES | Earlier CI logs showed 2 NOTES for `.github` and extra top-level files | `.Rbuildignore` updated on both branches. Verify latest check has **zero notes**. |
| CRAN | CRAN package listing/checks | Published 0.2.2; current platform checks of 0.2.2 show OK. This does **not** validate unreleased 0.2.3 on Windows/macOS. |
| JOSS public development history | GitHub `main` commits from 19 February 2025, contributors `khasa006` and `gabrielodom`, public issue IDs 1–7 dating to February–April 2025, iterative edits through May 2025 and September 2026 | Substantive public history and co-development evidenced, improving prior assessment. Most older GitHub issues are still *open*, and no repository GitHub release objects were returned; CRAN distribution exists. |
| Software use | `docs/RESEARCH_SOFTWARE_TRACEABILITY.md` and read-only original `simBKMR` scripts | Threshold functional form/rounded coefficients trace to historical scripts. Original exposure simulation used `lcmix::rmvgamma()`, rather than the current package generator. No evidence yet establishes direct use of the released package in the original methodological studies, or independent external adoption. |
| Dataset license claim | `inst/scripts/data_metalExposChildren_save.R` | Source comment states Prof. Roberto Lucchini emailed permission to share on 3 April 2025 under CC BY 4.0. The actual email/terms were not independently verified; de-identification and authorization scope for all fields (including subject IDs) remain to confirm. |
| Documented AI use | `paper.md` AI usage disclosure | AI-assisted drafting, code review/fixes and tests disclosed. Human validation of *latest* revisions must be confirmed by author(s); earlier coauthor approval was for a prior draft. |
| Package examples and descriptions | `vignettes/packageOverview.qmd`, `vignettes/bkmr_threshold.qmd`, data help files | Revised overly strong statistical claims, corrected meaning of PIP selection vs significance, factor coding and a package-title typo. Final Quarto build needs confirmation on updated head. |

## JOSS eligibility assessment

JOSS currently screens on sustained public development (`>6` months), iterative contributions, active open-source workflows and **demonstrated research use**; mere association with papers is not enough. The GitHub timeline supports a real 2025–2026 history, with contributions by multiple developers and public issues, though its concentrated development periods and unresolved public issues remain review questions. The direct software-use record and documented research impact are the most important editorial risks.

## Blockers and human decisions

1. **Original data permission:** Retrieve or retain Lucchini's actual 3 April 2025 permission email and confirm CC BY 4.0 terms encompass the distributed derived dataset and its fields and de-identification. An author comment is evidence of a reported permission, not independent verification.
2. **Research impact:** Provide specific code or reproducible workflow showing current package use in a study, or verified early-package usage / documented adopter. Do not imply identical simulation implementations where historical scripts differ.
3. **Human-author validation:** Coauthors approved an earlier draft, but the corrected statistical behavior and subsequent vignette/AI-disclosure revisions need review/sign-off.
4. **Latest CI:** Confirm both latest head commits pass R package check and JOSS paper build after the new documentation changes. Check for warnings and NOTES, not just overall green status.
5. **Remaining technical limitations:** The Gamma generator's input-validation domain and latent Gaussian vs observed rank-correlation calibration are disclosed but not fully addressed. Avoid claiming exact reproduction of empirically estimated correlations; consider future method/API design after scientific review.
6. **Release discipline:** Do not merge PR #8/#9, create `v0.2.3` tags/releases, deposit a software DOI, submit to CRAN, or submit JOSS before requested user action. User expressly wants validation and preparation **without release**.

## References checked

- JOSS submission: https://joss.readthedocs.io/en/latest/submitting.html
- JOSS review criteria: https://joss.readthedocs.io/en/latest/review_criteria.html
- Published package: https://cran.r-project.org/web/packages/simBKMRdata/index.html
- GitHub CI: https://github.com/khasa006/simBKMRdata/actions
- JOSS draft PR #8: https://github.com/khasa006/simBKMRdata/pull/8
- Statistical fix PR #9: https://github.com/khasa006/simBKMRdata/pull/9


## Dataset version restriction (author clarification, November 2026)

The corresponding author states that **only the dataset version currently distributed in `simBKMRdata` may be used**. Do not regenerate it from earlier cohort files, substitute a more extensive dataset, add new participants or variables, or change participant-level values during JOSS preparation or the proposed 0.2.3 update.

Git object verification across `main`, the JOSS preparation branch, and the 0.2.3 candidate branch shows identical blob SHA values for:

- `data/metalExposChildren_df.rda`: `354a64e7a5850a45faa63acaa6c7ee48bf824aa8`
- `inst/extdata/metalExposChildren.csv`: `b3c78ccf6bad39cf686a05c9f373bf2edb824d5f`
- `inst/scripts/data_metalExposChildren_save.R`: `26de97b410e822bdde4dfedbbe9a5418a609343b`

These hashes verify that neither prepared branch changes the existing dataset assets. Source-level `R/data_metalExposChildren.R` and the corresponding `.Rd` help were edited for documentation only. Identical hashes do not independently verify de-identification, license scope, or that the original permission email covers the two distributed assets; retain the author-reported April 3, 2025 authorization with the private project records.

**Decision:** preserve the two current data assets byte-for-byte; no new dataset version is authorized by this clarification.
