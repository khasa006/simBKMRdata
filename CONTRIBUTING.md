# Contributing to simBKMRdata

Contributions that improve correctness, documentation, examples, tests, and performance are welcome.

## Before opening a pull request

1. Search [existing issues](https://github.com/khasa006/simBKMRdata/issues) and open an issue for substantial changes or changes to the statistical interpretation.
2. Fork the repository, create a topic branch, and make a focused change.
3. Add or update tests when changing numerical behavior. Use small deterministic examples and set a seed for stochastic checks.
4. Update roxygen documentation, vignettes, and NEWS.md when appropriate.
5. Check the package locally with `devtools::test()` and `devtools::check()`, or `R CMD check`, and disclose any warnings or notes.
6. Submit a pull request describing the motivation, statistical assumptions, tests run, and any compatibility concerns.

## Reporting bugs

Include package and R versions, a small reproducible example, expected versus observed behavior, and `sessionInfo()`. Do not attach private individual-level research data.

## Review and maintenance

The package maintainer listed in `DESCRIPTION` coordinates review and releases. There is no promised response-time guarantee. Mathematical changes should be accompanied by an explanation of the implied distribution, parameters, or decision rule. Significant API changes should be discussed in an issue before implementation.

## Research data and licensing

The software uses the GPL-3-or-later license stated in `DESCRIPTION`. Do not add third-party data or code unless redistribution is permitted and attribution and licensing obligations are satisfied. Contributions are reviewed before merging; the project does not promise automatic acceptance.
