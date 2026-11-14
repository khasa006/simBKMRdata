# JOSS submission form: simBKMRdata

**Prepared for author review; NOT submitted.** Use the [official JOSS submission portal](https://joss.theoj.org/) (select **Submit a paper to JOSS** and sign in). The portal may require interactive GitHub authentication, and the submission must be completed by the corresponding author.

## Repository and manuscript

- **Software title:** simBKMRdata: Correlated Exposure Simulation and Posterior Inclusion Probability Thresholds for Bayesian Kernel Machine Regression
- **Repository:** https://github.com/khasa006/simBKMRdata
- **Submission branch:** `joss-submission-preparation-2026-11`
- **Paper path:** `paper.md`
- **Bibliography:** `paper.bib`
- **Software version represented by branch:** 0.2.3 **development candidate; unreleased**, with the Gaussian marginal-SD, PIP missingness, and Gamma input-domain/dimension corrections. The **published CRAN version remains 0.2.2**.
- **Programming language:** R
- **License:** GPL-3.0-or-later (as represented by `DESCRIPTION`)
- **Submission category:** Research software / mathematical and statistical software / epidemiology, as available in the current submission form
- **Author responsible for submission:** Kazi Tanvir Hasan
- **Contact:** khasa006@fiu.edu
- **Corresponding author affiliations:** (1) Yale School of Medicine, Department of Psychiatry; (2) Florida International University, Department of Biostatistics, Robert Stempel College of Public Health & Social Work
- **Coauthors:** Boubakari Ibrahimou; Cristian Guerini; Zoran Bursac; Roberto Lucchini; Gabriel Odom (all appear in `paper.md` in the established order).

## Short software description

`simBKMRdata` is an R package providing functions for estimating group-specific distribution parameters and generating multivariate Gaussian and Gamma exposure data used in simulation studies of environmental mixtures. It also evaluates a simulation-calibrated posterior inclusion probability selection threshold for Bayesian kernel machine regression, using the response coefficient of variation and sample size. The package supplies input simulation and selection-calibration utilities; it does not fit BKMR models.

## Research applications and evidence

**Verified developer research workflow:** the package vignettes use `simBKMRdata` functions on an existing metal-exposure dataset to estimate group-specific Gamma parameters and generate synthetic exposures, and apply `calculate_pip_threshold()` after a BKMR model fit and PIP extraction. GitHub Actions successfully rebuilt the vignettes. See `docs/RESEARCH_SOFTWARE_TRACEABILITY.md` for exact files and CI evidence. These are executable examples by the developer group, not independent published studies or external adoption.

**Methods lineage:** Two methodological studies motivated the package: BKMR sensitivity to exposure distributions and empirical dynamic PIP thresholding. The threshold formula and its default coefficients can be traced to dated 2024 research code and numerically checked from saved simulation outputs. The earlier Gamma simulations used `lcmix::rmvgamma()` rather than the current package generator; the original scripts do not establish import of the released package. Do not claim exact historical reconstruction, formal Type I error control, or external adoption.

Research archive (separate from the software): https://doi.org/10.5281/zenodo.24021746

## Version and archival DOI

**Do not invent a versioned software DOI.** JOSS guidance places creation of a tagged release and archival software DOI at the end of a successful review. The corrected 0.2.3 code currently lives on an unmerged branch and is not yet released. If the form requires a version, enter `0.2.3 (development)` only if the form accepts a non-released development version, or accurately select the branch commit after consulting the editor. Never claim 0.2.3 is a published CRAN release.

## Author checks before clicking Submit

- [x] Verify the last code-containing JOSS branch R package check succeeds: run `43634286336`, `Status: OK`, 137 passing tests, no failures/warnings/skips. Recheck current branch SHA before submitting because subsequent documentation-only commits trigger CI.
- [x] Inspect final author-confirmed 4-page JOSS PDF; verified corresponding-author indices 1 and 2, all six authors, references, no-funding and AI disclosure (workflow `43349928309`).
- [x] Corresponding author confirms the revised manuscript, corrected code and tests, authorship details, and AI-assisted work were human-reviewed, edited and validated; coauthor approval was previously reported.
- [x] Identify documented developer research workflows in the executable package vignettes, with successful R CI vignette rebuilding; see `docs/RESEARCH_SOFTWARE_TRACEABILITY.md`.
- [ ] Consider whether additional peer-reviewed or independent usage evidence is available, since JOSS editors may view examples alone as insufficient impact.
- [ ] Verify authorization and de-identification for the bundled 437-row children's metal-exposure dataset; the data documentation's CC BY 4.0 claim does not by itself prove redistribution rights.
- [x] Corresponding author confirmed no external software funding and no acknowledgements. The paper now includes a no-funding statement and omits the Acknowledgements section.
- [ ] Review the current JOSS scope and public-development-history criteria; editorial screening can reject codebases with insufficient iterative public development.
- [ ] Verify any change to `main`, branch and package version metadata before submission.

## Important submission status

No paper has been submitted to JOSS from this preparation. Do **not** merge the JOSS preparation pull request or publish a release solely to complete this form. The appropriate submission uses the same GitHub repository and the specified JOSS branch, which contains both the paper and the corrected source code.

**After submission:** save the JOSS submission identifier or public pre-review issue URL here and inform the coauthors. Tagged release and archival DOI are intended to follow successful review.

## Final preparation and JOSS release sequence (14 November 2026)

- [x] Confirm both candidate sources have successful GitHub Actions checks: JOSS [43634286336](https://github.com/khasa006/simBKMRdata/actions/runs/43634286336); package-only 0.2.3 [43634062129](https://github.com/khasa006/simBKMRdata/actions/runs/43634062129).
- [x] Prepare release sequencing and provenance handoff in `docs/JOSS_FINAL_HANDOFF_2026-11.md` (this branch) and `docs/RELEASE_0.2.3_HANDOFF.md` (PR #9 branch).
- [ ] Resolve original derived-dataset redistribution permission and de-identification documentation; currently connected Gmail search did not locate the April 3, 2025 message.
- [ ] Evaluate actual research impact and JOSS public-development-history screening; developer vignettes support documented package use but do not by themselves prove external adoption or guarantee editorial eligibility.
- [ ] Conduct final corresponding-author confirmation of the actual submitted version of paper and code, including any changes since the prior human validation.
- [ ] Enter repository and paper details into the JOSS portal and submit; **no submission has been made here**.
- [ ] After successful JOSS review, create GitHub software tag/release, deposit a software-specific archive, and update the paper and review thread with the actual DOI. CRAN submission follows its own process.
