# JOSS submission preparation and author sign-off

Status: **draft only; do not submit until all mandatory checks are resolved.**

## Scientific and bibliographic checks

- [x] Coauthor approval reported by corresponding author in November 2026 for six authors in `DESCRIPTION` order; retain records of approval.
- [ ] Confirm approval records also cover each author's ORCID, current affiliation, and software contribution where applicable.
- [ ] Confirm the full author lists, citation metadata, and publication year for both methodological papers. Replace provisional BibTeX records.
- [ ] Confirm that `simBKMRdata` or identifiable precursor functions were used in each research manuscript. Point to exact original scripts and commit IDs. If the package was generalized after the analyses, say so explicitly.
- [ ] Confirm funding and acknowledgements.
- [ ] Have all authors review the AI usage disclosure for accuracy, including AI tools used in earlier software development.
- [ ] Obtain explicit data-owner documentation for redistribution of the 437-row children's metal-exposure dataset, including de-identification, subject IDs, and the asserted CC BY 4.0 license; the current source comment alone is insufficient.
- [ ] Provide a precise method comparison with alternative multivariate simulation packages; no unsupported novelty claims.

## Technical checks

- [ ] Run `R CMD check --as-cran` or `devtools::check()` locally on the PR branch and record results.
- [ ] Check GitHub Actions workflow after pushing; adjust setup if Quarto and dependencies require additional system libraries.
- [ ] Render the paper with the JOSS paper compiler or the JOSS preprint-preview service, check all references and metadata, and review the generated PDF.
- [ ] Ensure every vignette runs on a clean supported R environment and does not depend on undisclosed files.
- [ ] Audit input validation for non-positive sample sizes, invalid Gamma parameters, non-positive-definite matrices, missing values, zero response means, and `na.rm` behavior.
- [x] Add seeded numerical tests for Gamma marginal moments and Gaussian-copula rank dependence; see `test-joss-gamma-marginal-calibration.R` (await successful CI for latest commit).
- [x] Correct PIP and Gamma generator help text without changing numerical behavior; see source roxygen and matching `.Rd` files.
- [ ] Resolve substantive assumptions and input-validation findings documented in `docs/JOSS_SCIENTIFIC_VALIDATION_AUDIT.md`, preferably before a new versioned release.
- [ ] Remove stale template artifacts (e.g. `figures/penguins.png` and `inst/.DS_Store`) after confirming unused.
- [ ] Reconcile the README's unfinished outline with the released API.
- [ ] Review existing open issues and close genuinely resolved issues with evidence.

## Open-development and impact criteria

- [x] Trace the threshold formula and rounded coefficients to dated Project 2 research scripts and the saved-output archive; see `docs/JOSS_SCIENTIFIC_VALIDATION_AUDIT.md`.
- [ ] Establish whether released `simBKMRdata` or an identifiable predecessor was **actually used** in the original manuscript analyses. The 2024 Project 1 script uses `lcmix::rmvgamma()`, so this cannot be inferred. Document any independent external adopters, if verifiable.
- [ ] Request feedback from an independent researcher who installs and tests the package; document actual results rather than inventing endorsements.
- [ ] Continue meaningful public development and issue/PR discussions. The prior concentrated commit pattern may trigger JOSS pre-review rejection even if these files are added.
- [ ] Publish a versioned software release and archive **of simBKMRdata itself** (distinct from the `simBKMR` research-data DOI) when the software changes are reviewed.
- [ ] Update the JOSS bibliography with the package archive DOI.
- [ ] After review, submit the GitHub repository URL and paper path via the official JOSS form. Do not submit the research-analysis repository as the software.
