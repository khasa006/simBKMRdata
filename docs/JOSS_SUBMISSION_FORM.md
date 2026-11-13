# JOSS submission form: simBKMRdata

**Prepared for author review; NOT submitted.** Use the [official JOSS submission portal](https://joss.theoj.org/) (select **Submit a paper to JOSS** and sign in). The portal may require interactive GitHub authentication, and the submission must be completed by the corresponding author.

## Repository and manuscript

- **Software title:** simBKMRdata: Correlated Exposure Simulation and Posterior Inclusion Probability Thresholds for Bayesian Kernel Machine Regression
- **Repository:** https://github.com/khasa006/simBKMRdata
- **Submission branch:** `joss-submission-preparation-2026-11`
- **Paper path:** `paper.md`
- **Bibliography:** `paper.bib`
- **Software version represented by branch:** 0.2.3 **development candidate; unreleased**, with two correctness fixes. The **published CRAN version remains 0.2.2**.
- **Programming language:** R
- **License:** GPL-3.0-or-later (as represented by `DESCRIPTION`)
- **Submission category:** Research software / mathematical and statistical software / epidemiology, as available in the current submission form
- **Author responsible for submission:** Kazi Tanvir Hasan
- **Contact:** khasa006@fiu.edu
- **Coauthors:** Ibrahimou Boubakari; Cristian Guerini; Zoran Bursac; Roberto Lucchini; Gabriel Odom (all appear in `paper.md` in the established order).

## Short software description

`simBKMRdata` is an R package providing functions for estimating group-specific distribution parameters and generating multivariate Gaussian and Gamma exposure data used in simulation studies of environmental mixtures. It also evaluates a simulation-calibrated posterior inclusion probability selection threshold for Bayesian kernel machine regression, using the response coefficient of variation and sample size. The package supplies input simulation and selection-calibration utilities; it does not fit BKMR models.

## Research applications and evidence

The package implements reusable functions associated with two methodological research projects by the authors: an investigation of BKMR sensitivity to exposure distributions and an empirical dynamic PIP-thresholding study. The threshold formula and its rounded default coefficients can be traced to a dated 2024 script in the archived research repository and independently checked from saved simulation outputs. The original Gamma simulation scripts used a different software generator, so exact replication of historical exposure simulations using the current package has **not** been established. Do not claim verified independent adoption, end-to-end reproducibility of BKMR MCMC, or formal frequentist Type I error control.

Research archive (separate from the software): https://doi.org/10.5281/zenodo.24021746

## Version and archival DOI

**Do not invent a versioned software DOI.** JOSS guidance places creation of a tagged release and archival software DOI at the end of a successful review. The corrected 0.2.3 code currently lives on an unmerged branch and is not yet released. If the form requires a version, enter `0.2.3 (development)` only if the form accepts a non-released development version, or accurately select the branch commit after consulting the editor. Never claim 0.2.3 is a published CRAN release.

## Author checks before clicking Submit

- [ ] Verify the current JOSS branch **R package check succeeds**, not merely PDF build.
- [ ] Check final PDF for citations, names, author-affiliation display, math and typographic issues.
- [ ] All coauthors review the **post-approval revisions** to AI disclosure and correctness-fix code and agree to be accountable for them.
- [ ] Identify and provide **specific documented research use** of the package or precursor functions, beyond broad association with two methods papers.
- [ ] Verify authorization and de-identification for the bundled 437-row children's metal-exposure dataset; the data documentation's CC BY 4.0 claim does not by itself prove redistribution rights.
- [ ] Confirm funding/acknowledgements or explicitly state none.
- [ ] Review the current JOSS scope and public-development-history criteria; editorial screening can reject codebases with insufficient iterative public development.
- [ ] Verify any change to `main`, branch and package version metadata before submission.

## Important submission status

No paper has been submitted to JOSS from this preparation. Do **not** merge the JOSS preparation pull request or publish a release solely to complete this form. The appropriate submission uses the same GitHub repository and the specified JOSS branch, which contains both the paper and the corrected source code.

**After submission:** save the JOSS submission identifier or public pre-review issue URL here and inform the coauthors. Tagged release and archival DOI are intended to follow successful review.
