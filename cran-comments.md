## Version 0.1.1 CRAN Review Comments


> Please do not start the description with "This package", package name,
title or similar. 

We changed the start of the description field to "Provides a suite of helper functions..."

> If there are references describing the methods in your package, please
add these in the description field of your DESCRIPTION file in the form
authors (year) <doi:...>
authors (year, ISBN:...)
or if those are not available: <https:...>
with no space after 'doi:', 'https:' and angle brackets for
auto-linking. (If you want to add a title as well please put it in
quotes: "Title")
For more details:
<https://urldefense.com/v3/__https://contributor.r-project.org/cran-cookbook/description_issues.html*references__;Iw!!FjuHKAHQs5udqho!MmUbX-DMsbll3K_k56nEWq0yQVuHkZFvusflkQu5y6BnRaJAAlSsealGn1UT_quLIDveGd_SxeHSL7RP_ZpNrr0HiL-IYM4$ >

We have added the medRxiv pre-print link to the description; the paper is currently under review.

> Please always make sure to reset to user's options(), working directory
or par() after you changed it in examples and vignettes and demos. ->
inst/doc/estimation_and_simulation.R
e.g.:
oldpar <- par(mfrow = c(1,2))
...
par(oldpar)
For more details:
<https://urldefense.com/v3/__https://contributor.r-project.org/cran-cookbook/code_issues.html*change-of-options-graphical-parameters-and-working-directory__;Iw!!FjuHKAHQs5udqho!MmUbX-DMsbll3K_k56nEWq0yQVuHkZFvusflkQu5y6BnRaJAAlSsealGn1UT_quLIDveGd_SxeHSL7RP_ZpNrr0Hios-H14$ >

We are now resetting the user par() options to their previous states.


## Version 0.1.0 R CMD check results

0 errors | 0 warnings | 1 note
```
checking for future file timestamps ... NOTE
  unable to verify current time
```

* This is a new release.

