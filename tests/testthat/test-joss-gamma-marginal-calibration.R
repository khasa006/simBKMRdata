test_that("Gamma generator recovers marginal moments in a diagonal latent design", {
  # Gamma(shape, rate) has mean shape/rate and variance shape/rate^2.
  # Monte Carlo tolerance is deliberately wider than typical sampling error.
  set.seed(20261112)
  z <- generate_mvGamma_data(
    sampSize = 6000,
    sampCorr_mat = diag(2),
    shape_num = c(2, 5),
    rate_num = c(1, 2)
  )
  expect_equal(unname(colMeans(z)), c(2, 2.5), tolerance = 0.20)
  expect_equal(unname(vapply(z, stats::var, numeric(1))), c(2, 1.25),
               tolerance = 0.35)
})

test_that("Gamma copula rank correlation follows the latent normal correlation", {
  # For a Gaussian copula, population Spearman rho is
  # (6/pi) * asin(rho_latent/2), not generally rho_latent.
  latent_rho <- 0.6
  set.seed(20261113)
  z <- generate_mvGamma_data(
    sampSize = 8000,
    sampCorr_mat = matrix(c(1, latent_rho, latent_rho, 1), 2, 2),
    shape_num = c(2, 3),
    rate_num = c(1, 2)
  )
  expected <- 6 / pi * asin(latent_rho / 2)
  observed <- unname(stats::cor(z[[1]], z[[2]], method = "spearman"))
  expect_equal(observed, expected, tolerance = 0.055)
})
