# JOSS submission preparation and author sign-off

Status: **draft only; do not submit until all mandatory checks are resolved.**

## Scientific and bibliographic checks

- [x] Coauthor approval reported by corresponding author in November 2026 for six authors in `DESCRIPTION` order; retain records of approval.
- [x] Corresponding author confirmed author and affiliation details, including **Kazi Tanvir Hasan affiliations [1, 2]**, corrected Boubakari Ibrahimou display name, and the given/family metadata corrections for Cristian Guerini and Zoran Bursac. Individual coauthor approval records remain private and were not independently inspected.
- [x] Cross-check both methodological paper author lists, public DOI metadata and publication years; cite the 2025 medRxiv preprint using its verifiable title/DOI and identify the revised paper accepted in 2026 separately. Final peer-reviewed DOI remains unavailable; see `docs/JOSS_FINAL_MANUSCRIPT_REVIEW.md`.
- [x] Trace original-script lineage and distinguish it from demonstrable import of the released package; the original 2024 scripts predate public package development and do not prove direct package use. Current executable research workflows are documented separately; see `docs/RESEARCH_SOFTWARE_TRACEABILITY.md`.
- [x] Corresponding author confirmed no software funding and no acknowledgements; paper states no external funding and omits the acknowledgements section.
- [ ] Confirm conflict-of-interest disclosure requirements at submission; none was asserted by the author.
- [x] Corresponding author confirmed human review, editing and validation of the AI-assisted manuscript, software corrections, tests and documentation. Updated AI disclosure accordingly.
- [ ] Obtain explicit data-owner documentation for redistribution of the 437-row children's metal-exposure dataset, including de-identification, subject IDs, and the asserted CC BY 4.0 license; the current source comment alone is insufficient.
- [ ] Provide a precise method comparison with alternative multivariate simulation packages; no unsupported novelty claims.

## Technical checks

- [ ] Run `R CMD check --as-cran` or `devtools::check()` locally on the PR branch and record results.
- [x] Check GitHub Actions on the JOSS and 0.2.3 branches; successful R package checks and JOSS paper builds recorded for the corrected statistical and manuscript content. Recheck latest branch head after any new commits.
- [x] Retrieve and inspect **all four pages** of the successful JOSS draft PDF artifact; verify text flow, author blocks, affiliations, citations and preview-only placeholders. See `docs/JOSS_FINAL_MANUSCRIPT_REVIEW.md`.
- [x] Re-inspect the final author-confirmed four-page JOSS PDF (run `43349928309`): **Hasan affiliations [1,2]**, six authors, 2025 medRxiv citation, no-funding statement, no acknowledgements, affirmative AI validation disclosure. Repeat only if paper inputs change.
- [ ] Ensure every vignette runs on a clean supported R environment and does not depend on undisclosed files.
- [ ] Audit input validation for non-positive sample sizes, invalid Gamma parameters, non-positive-definite matrices, missing values, zero response means, and `na.rm` behavior.
- [x] Add seeded numerical tests for Gamma marginal moments and Gaussian-copula rank dependence; see `test-joss-gamma-marginal-calibration.R` (await successful CI for latest commit).
- [x] Correct PIP and Gamma generator help text without changing numerical behavior; see source roxygen and matching `.Rd` files.
- [x] Implement Gaussian marginal-SD and nonmissing PIP sample-size corrections with regression tests on draft branch and isolated release PR #9.
- [x] Confirm 0.2.3 release-candidate CI success at PR #9 head `a2ef709eb1a94e06c0d4fc5ce5c95c3faf38b6be`; **do not merge, tag or publish** before JOSS submission at the corresponding author's request.
- [ ] Resolve remaining Spearman-to-Pearson calibration, Gamma input validation, and redistribution-permission findings documented in `docs/JOSS_SCIENTIFIC_VALIDATION_AUDIT.md`.
- [ ] Remove stale template artifacts (e.g. `figures/penguins.png` and `inst/.DS_Store`) after confirming unused.
- [ ] Reconcile the README's unfinished outline with the released API.
- [ ] Review existing open issues and close genuinely resolved issues with evidence.

## Open-development and impact criteria

- [x] Trace the threshold formula and rounded coefficients to dated Project 2 research scripts and the saved-output archive; see `docs/JOSS_SCIENTIFIC_VALIDATION_AUDIT.md`.
- [x] Document **verified developer research workflows** that directly call package functions in executable Quarto vignettes and have passed a GitHub Actions vignette rebuild. See `docs/RESEARCH_SOFTWARE_TRACEABILITY.md` and `paper.md`.
- [x] Distinguish associated papers from actual released-package usage: the 2024 original study scripts do not show package imports and Project 1 uses `lcmix::rmvgamma()`. No independent external adopter has been verified.
- [ ] JOSS editorial screening may still judge package vignettes insufficient research-impact evidence; stronger independent research use (if available) would materially strengthen the submission.
- [ ] Request feedback from an independent researcher who installs and tests the package; document actual results rather than inventing endorsements.
- [ ] Continue meaningful public development and issue/PR discussions. The prior concentrated commit pattern may trigger JOSS pre-review rejection even if these files are added.
- [ ] After successful JOSS review, publish a tagged, versioned software release and archive **of simBKMRdata itself** (distinct from the `simBKMR` research-data DOI). The corresponding author requested JOSS submission **before** publishing version 0.2.3, consistent with JOSS's post-review release process.
- [ ] Add the final package archive DOI for publication after the release is archived; do not invent it in the initial manuscript.
- [x] Prepare exact branch and manuscript details in `docs/JOSS_SUBMISSION_FORM.md`.
- [ ] Submit the corrected software branch and `paper.md` via the official JOSS submission portal, after pending technical/data/impact/human validation checks. Do not submit the research-analysis repository as the software.
