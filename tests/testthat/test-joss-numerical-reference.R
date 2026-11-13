test_that("archived NHANES PIP threshold arithmetic matches rounded calibration coefficients", {
  # Saved-output audit: simBKMR v1.0.0, 10.5281/zenodo.24021746
  # This is an arithmetic reference check, not a rerun of BKMR MCMC.
  result <- calculate_pip_threshold(absCV = 15.18, sampSize = 949)
  expect_equal(result, 0.646321317, tolerance = 1e-7)
})

test_that("default threshold agrees with the stated generalized logistic expression", {
  cv <- 7.5
  n <- 300
  expected <- (1.30460 + exp(-0.59867 * log2(cv))) ^
    (-0.43565 * log10(n))
  result <- calculate_pip_threshold(absCV = cv, sampSize = n)
  expect_equal(result, expected, tolerance = 1e-12)
})
