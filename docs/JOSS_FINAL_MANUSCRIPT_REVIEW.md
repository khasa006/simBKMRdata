# JOSS Step 4: manuscript, PDF, metadata, and bibliography review

**Review performed:** November 12, 2026 (Eastern); JOSS GitHub builds date-stamped November 13 UTC.  
**Disposition:** Editorial and metadata audit completed; **author sign-off still required** before submission. No release, tag, merge, CRAN submission, or JOSS submission authorized.

## PDF inspection

The exact JOSS-generated PDF from successful [run 43347370101](https://github.com/khasa006/simBKMRdata/actions/runs/43347370101) was retrieved (workflow artifact `paper.pdf`) and visually reviewed as **four rendered pages** in addition to text extraction.

- The paper includes the six-author byline, five numbered affiliations, corresponding-author marker, Summary, Statement of need, State of the field, Software design, Research impact statement, AI usage disclosure, Acknowledgements, and References.
- Dual Yale/FIU affiliations for Kazi Tanvir Hasan render together; Cristian Guerini's institution is **University of Brescia, Italy**, without an added department.
- Text is readable, with no obvious clipping, overlapping text, missing entire sections, or missing citations in the four-page preview.
- The large DRAFT watermark; JOSS placeholder DOI `10.xxxxxx/draft`; January 1, 1970 submission date; and missing volume, issue and page metadata are **preview-template placeholders**, not manuscript claims. They must **not** be copied into actual submission metadata.
- The last page contains only the final few bibliography entries, which is a normal page-break consequence rather than a layout error; no manual page-size change is necessary.
- A second JOSS PDF artifact from successful [run 43348779687](https://github.com/khasa006/simBKMRdata/actions/runs/43348779687) was retrieved and inspected after the updated author byline and 2025 preprint citation were committed (`cae752530eb14f6bf316aaf690435bd6db358014`). It remains four pages; the byline correctly displays **Boubakari Ibrahimou**, and the medRxiv reference displays the verified 2025 title and DOI. Subsequent commits to `docs/` only do not change the paper text or bibliography. Repeat PDF review only if `paper.md`, `paper.bib`, the PDF workflow or other paper inputs change.

## Verified bibliography

1. **Bobb et al. (2015):** `10.1093/biostatistics/kxu058` is listed consistently.
2. **Venables & Ripley (2002):** `Modern Applied Statistics with S`, fourth edition, Springer, DOI `10.1007/978-0-387-21706-2`.
3. **Hasan et al. BKMR distribution sensitivity:** The publisher lists Hasan, Odom, Bursac, and **Boubakari Ibrahimou**; `Journal of Statistical Computation and Simulation` 96(7), 1752–1771 (2026); DOI `10.1080/00949655.2025.2608780`; online publication December 29, 2025. The BibTeX metadata are consistent.
4. **Dynamic threshold:** The publicly citable medRxiv preprint is **2025**, DOI `10.1101/2025.04.14.25325822`, title ending `...in High-Dimensional Environmental Health Data`, by Hasan, Odom, Bursac, Lucchini, and Ibrahimou. The author-reported **revised** paper, with a different title ending `...in the Data`, was accepted by `Research in Statistics` in November 2026. No verified final peer-reviewed journal DOI is available here. Accordingly, `paper.bib` now cites the actual 2025 preprint with its own title/date/DOI; `paper.md` clearly distinguishes that from the later accepted manuscript. Update the preprint citation to final journal metadata **only after independently verifying** final production details.
5. **simBKMRdata package:** The CRAN persistent DOI `10.32614/CRAN.package.simBKMRdata` currently points to released 0.2.2; bibliographic software version remains **0.2.2** in the paper pending actual 0.2.3 publication. The JOSS branch `DESCRIPTION` is a development candidate 0.2.3; no 0.2.3 software DOI has been invented.
6. **simBKMR historical research archive:** Zenodo DOI `10.5281/zenodo.24021746` belongs to the **separate research repository**, not `simBKMRdata`.

## Author metadata consistency

- The paper includes six contributors in this established order: Kazi Tanvir Hasan; **Boubakari Ibrahimou**; Cristian Guerini; Zoran Bursac; Roberto Lucchini; Gabriel Odom.
- The displayed name **Boubakari Ibrahimou** was verified against the FIU faculty profile and published methods paper, correcting the earlier inverted `Ibrahimou Boubakari` byline. The published author profiles support `Cristian Guerini` and `Zoran Bursac` in English given-name–family-name order.
- The R package `DESCRIPTION` had three coauthors' `person(given, family)` fields reversed. They have been corrected on **both draft branches** without changing author order, email addresses, ORCIDs, affiliations, or data assets.
- **Required final sign-off:** The affected coauthors must approve the display-name correction and the original authors must confirm current affiliations and ORCIDs. The prior reported coauthor approval covered an earlier draft.

## Research and statistical statements

- The JOSS paper accurately states that the package **does not fit BKMR models** itself.
- The Gamma generator uses Gaussian copula transforms, and estimated Spearman correlations are not generally target Pearson correlations. The paper acknowledges these distinctions rather than promising exact empirical correlation preservation.
- The PIP-threshold curve is **simulation-calibrated**; no formal frequentist Type I-error guarantee is asserted.
- The research-impact statement identifies executed developer vignettes, distinguishes the methods-paper lineage from verified released-package imports, and makes no unsupported external-adoption claims.

## AI disclosure and journal policy

The [current JOSS author AI policy](https://joss.readthedocs.io/en/latest/policies.html) requires tool/model identification, what assistance was provided in manuscript/code/docs, and **affirmative human-author review, editing and validation of all AI-assisted outputs**. The paper identifies OpenAI ChatGPT / GPT-6 and scope correctly, but presently states that human review of latest changes **remains to be done**. **Do not change this to an affirmative verification statement until a human author has actually performed and attested to that review.** Editors and reviewers also restrict conversational use of AI during the review process (except translation).

## Open decisions before actual submission

1. Confirm the final display names, ORCIDs, affiliations, and revised six-person author order with the coauthors, notably **Boubakari Ibrahimou**.
2. Authors must personally inspect/validate AI-assisted changes and approve the full paper, paper metadata, updated code, tests, and disclosure.
3. Confirm **funding sources or absence of external funding for the software project**, acknowledgment of contributors outside the author list if applicable, and required conflict-of-interest disclosures. The current Acknowledgements section contains a pending administrative note; it is **not publishable as final copy**.
4. Retain the 3 April 2025 data-sharing approval and confirm public redistribution scope and de-identification for the **existing unchanged dataset**; do not replace or regenerate the data.
5. JOSS PDF was visually reviewed on the final *paper-source* revision. Check the latest branch-head `R CMD check --as-cran` results, including any WARNINGS/NOTES; rerender/review the PDF only if paper inputs change.
6. After author approval and verification, submit to JOSS separately. **Do not merge, publish, tag, or release 0.2.3 in advance** at the corresponding author's request.

## Primary evidence links

- [JOSS manuscript](../paper.md) and [BibTeX](../paper.bib).
- [JOSS draft PR #8](https://github.com/khasa006/simBKMRdata/pull/8).
- [Release candidate PR #9](https://github.com/khasa006/simBKMRdata/pull/9).
- [2026 sensitivity article](https://doi.org/10.1080/00949655.2025.2608780).
- [2025 threshold preprint](https://doi.org/10.1101/2025.04.14.25325822).
- [Boubakari Ibrahimou at FIU](https://stempel.fiu.edu/faculty-staff/profiles/ibrahimou-boubakari.html).
- [JOSS manuscript format](https://joss.readthedocs.io/en/latest/paper.html).

## Corresponding-author final clarifications (12 November 2026)

The corresponding author explicitly confirmed all author metadata except one requested correction: Kazi Tanvir Hasan is affiliated with **(1) Department of Psychiatry, Yale School of Medicine** and **(2) Department of Biostatistics, Robert Stempel College of Public Health & Social Work, Florida International University**. The redundant institution-only FIU index 5 was removed from `paper.md`. No external funding was received for the software, and no acknowledgements are required. The author also confirmed human validation of the AI-assisted changes. The AI disclosure now explicitly records review, editing, and validation without asserting independent verification of every coauthor's email approval. A new PDF build must be checked for these final changes; earlier visual inspections covered preceding revisions.

## Final author-confirmed manuscript PDF verification

Verified the actual four-page GitHub Actions PDF generated at JOSS draft workflow run [43349928309](https://github.com/khasa006/simBKMRdata/actions/runs/43349928309) for commit `d9945063f06e9726ab565ac701bcad8af6e49c65`. The first page renders **Kazi Tanvir Hasan¹,²** with affiliation 1 (Yale School of Medicine, Department of Psychiatry) and affiliation 2 (FIU, Department of Biostatistics, Robert Stempel College). The obsolete index 5 is absent. All six authors and the four remaining affiliation definitions are visible. The final text includes the author-confirmed AI validation statement and **Funding: No external funding was received for development of this software**. The Acknowledgements heading is absent. The preprint citation is displayed with the 2025 medRxiv DOI; the historical research archive and software citations remain distinct. This is an inspected PDF, not solely a passing-build assertion.

The PDF is a **JOSS draft**, with expected `DRAFT`, placeholder DOI, placeholder submission date and publication metadata. The final archive was reviewed without touching any dataset assets. Subsequent `docs/`-only changes do not alter paper rendering. A human review of the original 3 April 2025 dataset permission email and authorization of public de-identification remain outstanding, and JOSS editorial eligibility remains a separate judgment.
