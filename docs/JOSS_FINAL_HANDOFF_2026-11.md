# JOSS submission handoff and candidacy assessment — 14 November 2026

**Status: materials built and tested, but original dataset-redistribution evidence and final author/editor judgments remain outstanding. JOSS paper has not been submitted. No 0.2.3 software release has been made.**

## Submission metadata

- Paper: `paper.md`, bibliography: `paper.bib`, in the source repository `https://github.com/khasa006/simBKMRdata`
- Source/paper branch: `joss-submission-preparation-2026-11`
- Candidate package version in branch: `0.2.3` (unreleased)
- Released CRAN software version: `0.2.2`
- Software license: `GPL (>= 3)`
- Six author list and ORCIDs in `paper.md`; Kazi Tanvir Hasan is corresponding author with Yale Psychiatry affiliation index 1 and FIU Biostatistics index 2.
- No external funding or acknowledgments, as confirmed by the corresponding author; AI usage and human validation are disclosed.
- Related methods papers: 2026 JSCS article DOI `10.1080/00949655.2025.2608780`; 2025 medRxiv threshold preprint DOI `10.1101/2025.04.14.25325822`, with revised paper accepted by Research in Statistics and final journal DOI pending.
- Archive DOI `10.5281/zenodo.24021746` belongs **only** to the separate `simBKMR` historical analysis repo, not to this software.

## Successful technical verification

- Source code and candidate package checks: `R CMD check Status: OK`, 137 passing tests, zero failures/warnings/skips, [GitHub Actions run 43634286336](https://github.com/khasa006/simBKMRdata/actions/runs/43634286336). [JOSS PDF run 43634286380](https://github.com/khasa006/simBKMRdata/actions/runs/43634286380) succeeded.
- Independent package-only candidate PR #9: `R CMD check Status: OK`, 132 passing tests, zero failures/warnings/skips, [run 43634062129](https://github.com/khasa006/simBKMRdata/actions/runs/43634062129).
- Numerical fixes: Gaussian subgroup marginal SD scaling; missing-response PIP sample size; Gamma generator domain validation and `n=1/p=1` tabular shape.
- The source, release notes, and help for the Gamma fix match across PRs #8 and #9; additional JOSS-only tests/docs are in PR #8. All changes to software numerical methods require an author-side scientific review before later release.
- New documentation-only commits trigger extra runs; **do not confuse older passing runs with head-commit results**. Check exact SHA at submission time.

## JOSS criteria that still require judgment

The current [JOSS submission policy](https://joss.readthedocs.io/en/latest/submitting.html) requires public development history over six months and verified *research use*, plus adequate open-development practices. The public GitHub repo was created February 19, 2025; commits on `main` include February–May 2025 work and a September 2026 release, followed by substantial November 2026 draft-branch work. Thus it is not a fresh repository, but periods of concentrated development and the package's level of demonstrated adoption are legitimate editorial risks. Avoid predicting acceptance.

The 2024 original Gamma study used a separate `lcmix::rmvgamma()` implementation, while the original threshold study script defines the mathematical predecessor of the current cutoff. Neither study establishes that the public `simBKMRdata` release was imported. Current package functions are demonstrably exercised in rebuilt developer research vignettes; no independent external adopter has been verified. These facts must remain explicit in the research-impact statement and any submission form.

Existing Spearman inputs are not automatically transformed to a latent Gaussian dependence parameter that reproduces the same post-Gamma rank correlation; users should inspect simulated dependence. Missing-data parameter-estimation conventions and generic grouped-wrapper validation are documented limitations, not verified solved issues.

## Required documentary confirmation

The package script `inst/scripts/data_metalExposChildren_save.R` explicitly records that Professor Roberto Lucchini emailed permission on April 3, 2025, for a derived children's metal-exposure dataset under CC BY 4.0. The source remark is useful provenance evidence, **but not the original email or independent verification of its full scope**. A search of the currently connected Gmail account using sender/name and 2025 date queries did not retrieve the original permission message; this does not mean the email does not exist in another mailbox.

Before submitting or making a new public redistribution assertion, have the original email or a renewed written confirmation available, addressing:

- Permission to publicly redistribute the **specific unchanged** packaged derived dataset, under stated CC BY 4.0 terms;
- Whether the current file contains any subject identifiers or potentially identifying values requiring de-identification/ethics review, and who is authorized to determine that status;
- Attribution requirements and any restrictions on downstream sharing.

Do not modify, substitute, regenerate, or redistribute a new version of the observational dataset to solve this documentation gap.

## Recommended JOSS filing sequence

1. Resolve/retain documentary data permission, ensure current source/metadata are accurately described, and have authors validate the final branch, code, tests, paper and disclosure.
2. Check the latest head SHA checks after the documentation-only handoff. Inspect PDF artifact for the latest paper-source revision (it has not changed since the last inspected four-page build).
3. At [JOSS's submission portal](https://joss.theoj.org/), enter the public repository URL and `paper.md` from the JOSS preparation branch; identify related methodology papers and honestly describe actual package research use and public history. **Do not claim a dedicated `simBKMRdata` software DOI exists.**
4. Retain the JOSS submission number or editorial pre-review issue and respond to requests through the public review process.
5. **After successful JOSS review**, prepare final tagged GitHub version `v0.2.3`, release notes, and a **simBKMRdata-specific** archive DOI, then add the DOI to the paper and review thread. CRAN distribution is an independent later maintainer action.

## Release preparation companion

See [PR #9](https://github.com/khasa006/simBKMRdata/pull/9) and `docs/RELEASE_0.2.3_HANDOFF.md` **on its branch** for the release-candidate changes and post-review release procedure.

## Permissions and action limits

This handoff does **not** claim that software has passed JOSS editorial screening, that original participant-data permission has been independently authenticated, or that an outside party has independently validated the historical research MCMC. It makes no release, tag, merge, CRAN upload, Zenodo deposit, or JOSS submission.
