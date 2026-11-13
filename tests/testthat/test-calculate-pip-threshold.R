test_that("calculate_pip_threshold reproduces the documented value", {
  out <- calculate_pip_threshold(absCV = 7.5, sampSize = 300)
  expect_equal(out, 0.6549943, tolerance = 1e-7)
})

test_that("calculate_pip_threshold can calculate inputs from y", {
  y <- c(2, 3, 4, 5, 6, 7)
  explicit <- calculate_pip_threshold(
    absCV = abs(stats::sd(y) / mean(y)),
    sampSize = length(y)
  )
  from_y <- calculate_pip_threshold(y = y)
  expect_equal(from_y, explicit)
})

test_that("calculate_pip_threshold requires both summary inputs", {
  expect_error(
    calculate_pip_threshold(absCV = 1),
    "both absCV and sampSize are required"
  )
  expect_error(
    calculate_pip_threshold(sampSize = 100),
    "both absCV and sampSize are required"
  )
})

test_that("calculate_pip_threshold accepts user-supplied coefficients", {
  coeffs <- list(A = 0, K = 1, C = 1, betaAbsCV = 0, betaSampSize = 1)
  out <- calculate_pip_threshold(absCV = 2, sampSize = 10, coeffs_ls = coeffs)
  expect_equal(out, 0.5)
})

test_that("calculate_pip_threshold uses the observed nonmissing sample size", {
  y <- c(2, 3, 4, 5, 6, 7, NA_real_, NA_real_)
  expected <- calculate_pip_threshold(
    absCV = abs(stats::sd(y, na.rm = TRUE) / mean(y, na.rm = TRUE)),
    sampSize = sum(!is.na(y))
  )
  expect_equal(calculate_pip_threshold(y = y), expected)
  expect_equal(calculate_pip_threshold(y = y), calculate_pip_threshold(y = y[!is.na(y)]))
  expect_error(calculate_pip_threshold(y = y, na.rm = FALSE), "missing values")
})

test_that("calculate_pip_threshold preserves complete-case thresholds", {
  y <- c(1, 2, 5, 10, 12, 15)
  expected <- calculate_pip_threshold(
    absCV = abs(stats::sd(y) / mean(y)), sampSize = length(y)
  )
  expect_equal(calculate_pip_threshold(y = y), expected)
  expect_equal(calculate_pip_threshold(absCV = 7.5, sampSize = 300),
               0.6549943, tolerance = 1e-7)
})

test_that("calculate_pip_threshold rejects degenerate and invalid inputs", {
  expect_error(calculate_pip_threshold(y = c(1, 1, 1)), "nonzero SD")
  expect_error(calculate_pip_threshold(y = c(-1, 1)), "nonzero mean")
  expect_error(calculate_pip_threshold(y = c(1, NA_real_)), "at least two")
  expect_error(calculate_pip_threshold(y = c(1, Inf, 3)), "finite observed")
  expect_error(calculate_pip_threshold(absCV = 0, sampSize = 300), "absCV")
  expect_error(calculate_pip_threshold(absCV = 1, sampSize = 1), "sampSize")
  expect_error(calculate_pip_threshold(y = c(1, 2), na.rm = NA), "na.rm")
})
