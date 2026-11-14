test_that("Gamma generator rejects invalid sample counts", {
  for (n in list(0, -1, 1.5, NA_real_, Inf, NaN, "10",
                 .Machine$integer.max + 1)) {
    expect_error(generate_mvGamma_data(n, diag(2), c(2, 3), c(1, 2)),
                 "sampSize")
  }
})

test_that("Gamma generator requires positive finite marginal parameters", {
  for (value in c(0, -1, NA_real_, NaN, Inf, -Inf)) {
    expect_error(generate_mvGamma_data(10, diag(2), c(2, value), c(1, 2)),
                 "shape_num")
    expect_error(generate_mvGamma_data(10, diag(2), c(2, 3), c(value, 2)),
                 "rate_num")
  }
  expect_error(generate_mvGamma_data(10, diag(2), c("2", "3"), c(1, 2)),
               "shape_num")
  expect_error(generate_mvGamma_data(10, diag(2), c(2, 3), c("1", "2")),
               "rate_num")
})

test_that("Gamma generator validates latent correlation matrices", {
  args <- list(sampSize = 10, shape_num = c(2, 3), rate_num = c(1, 2))
  bad_shapes <- list(NULL, 1, matrix(1, 1, 1),
                     matrix(1, 2, 3), matrix(NA_real_, 2, 2),
                     matrix(Inf, 2, 2), matrix("1", 2, 2))
  for (mat in bad_shapes) {
    expect_error(do.call(generate_mvGamma_data,
                         c(args, list(sampCorr_mat = mat))),
                 "sampCorr_mat")
  }
  asym <- matrix(c(1, 0.1, 0.5, 1), 2)
  expect_error(generate_mvGamma_data(10, asym, c(2, 3), c(1, 2)),
               "symmetric")
  wrong_diag <- diag(c(2, 1))
  expect_error(generate_mvGamma_data(10, wrong_diag, c(2, 3), c(1, 2)),
               "unit diagonal")
  out_of_range <- matrix(c(1, 1.2, 1.2, 1), 2)
  expect_error(generate_mvGamma_data(10, out_of_range, c(2, 3), c(1, 2)),
               "correlations")
  invalid_psd <- matrix(c(1, -0.9, -0.9,
                          -0.9, 1, -0.9,
                          -0.9, -0.9, 1), 3)
  expect_error(generate_mvGamma_data(10, invalid_psd, rep(2, 3), rep(1, 3)),
               "positive semidefinite")
})

test_that("Gamma generator preserves dimensions for n = 1 and p = 1", {
  set.seed(114)
  one_row <- generate_mvGamma_data(
    sampSize = 1, sampCorr_mat = matrix(c(1, 0.3, 0.3, 1), 2),
    shape_num = c(2, 5), rate_num = c(1, 2)
  )
  expect_s3_class(one_row, "data.frame")
  expect_identical(dim(one_row), c(1L, 2L))
  expect_true(all(is.finite(as.matrix(one_row))))
  expect_true(all(as.matrix(one_row) >= 0))

  one_col <- generate_mvGamma_data(
    sampSize = 6, sampCorr_mat = matrix(1, 1, 1),
    shape_num = 2, rate_num = 1
  )
  expect_identical(dim(one_col), c(6L, 1L))
  expect_true(all(is.finite(one_col[[1]])))

  single <- generate_mvGamma_data(
    sampSize = 1, sampCorr_mat = matrix(1, 1, 1),
    shape_num = 2, rate_num = 1
  )
  expect_identical(dim(single), c(1L, 1L))
  expect_true(is.finite(single[[1]][1]))
})

test_that("Gamma generator retains seeded multivariate behavior", {
  args <- list(sampSize = 30,
               sampCorr_mat = matrix(c(1, 0.4, 0.4, 1), 2),
               shape_num = c(2, 3), rate_num = c(1, 2))
  set.seed(20261114)
  observed <- do.call(generate_mvGamma_data, args)
  set.seed(20261114)
  expected_normal <- MASS::mvrnorm(
    n = args$sampSize, mu = c(0, 0), Sigma = args$sampCorr_mat
  )
  expected <- as.data.frame(cbind(
    stats::qgamma(stats::pnorm(expected_normal[, 1]), 2, rate = 1),
    stats::qgamma(stats::pnorm(expected_normal[, 2]), 3, rate = 2)
  ))
  expect_equal(observed, expected)
})
