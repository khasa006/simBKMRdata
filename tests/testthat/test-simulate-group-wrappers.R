test_that("simulate_group_gamma combines groups", {
  params <- list(
    Male = list(sampSize = 6, sampCorr_mat = diag(2), shape_num = c(2, 2), rate_num = c(1, 1)),
    Female = list(sampSize = 4, sampCorr_mat = diag(2), shape_num = c(3, 4), rate_num = c(2, 2))
  )
  set.seed(12)
  out <- simulate_group_gamma(params, "Sex")

  expect_equal(nrow(out), 10)
  expect_equal(ncol(out), 3)
  expect_equal(as.integer(table(out$Sex)), c(4L, 6L))
})

test_that("simulate_group_gamma checks names and required parameters", {
  expect_error(
    simulate_group_gamma(list(list(sampSize = 2, sampCorr_mat = diag(2), shape_num = c(2, 2), rate_num = c(1, 1))), "grp"),
    "named sublists"
  )
  bad <- list(A = list(sampSize = 2, sampCorr_mat = diag(2), shape_num = c(2, 2)))
  expect_error(simulate_group_gamma(bad, "grp"), "must contain")
})

test_that("simulate_group_gaussian combines groups", {
  params <- list(
    Male = list(sampSize = 6, mean_vec = c(0, 1), sampSD = c(4, 7), sampCorr_mat = diag(2)),
    Female = list(sampSize = 4, mean_vec = c(2, 3), sampSD = c(8, 9), sampCorr_mat = diag(2))
  )
  set.seed(13)
  out <- simulate_group_gaussian(params, "Sex")

  expect_equal(nrow(out), 10)
  expect_equal(ncol(out), 3)
  expect_equal(as.integer(table(out$Sex)), c(4L, 6L))
})

test_that("simulate_group_gaussian preserves supplied marginal SDs", {
  params <- list(
    A = list(
      sampSize = 5000,
      mean_vec = c(0, 0),
      sampSD = c(10, 20),
      sampCorr_mat = matrix(c(1, 0.35, 0.35, 1), 2, 2)
    )
  )
  set.seed(2026)
  out <- simulate_group_gaussian(params, "grp")

  # New covariance is diag(sampSD) %*% sampCorr_mat %*% diag(sampSD).
  expect_equal(stats::sd(out$V1), 10, tolerance = 0.6)
  expect_equal(stats::sd(out$V2), 20, tolerance = 1.2)
  expect_equal(stats::cor(out$V1, out$V2), 0.35, tolerance = 0.05)
})

test_that("simulate_group_gaussian checks names and required parameters", {
  expect_error(
    simulate_group_gaussian(list(list(sampSize = 2, mean_vec = c(0, 0), sampSD = c(1, 1), sampCorr_mat = diag(2))), "grp"),
    "named sublists"
  )
  bad <- list(A = list(sampSize = 2, mean_vec = c(0, 0), sampCorr_mat = diag(2)))
  expect_error(simulate_group_gaussian(bad, "grp"), "must contain")
})

test_that("simulate_group_gaussian validates the working covariance inputs", {
  base <- list(sampSize = 10, mean_vec = c(0, 1),
               sampSD = c(2, 3), sampCorr_mat = diag(2))
  bad_sd <- base
  bad_sd$sampSD <- c(2, 0)
  expect_error(simulate_group_gaussian(list(A = bad_sd), "group"), "sampSD")

  bad_corr <- base
  bad_corr$sampCorr_mat <- matrix(c(1, 1.2, 1.2, 1), 2)
  expect_error(simulate_group_gaussian(list(A = bad_corr), "group"),
               "correlation matrix")

  bad_psd <- base
  bad_psd$mean_vec <- c(0, 1, 2)
  bad_psd$sampSD <- c(1, 1, 1)
  bad_psd$sampCorr_mat <- matrix(c(1, -.9, -.9,
                                   -.9, 1, -.9,
                                   -.9, -.9, 1), 3)
  expect_error(simulate_group_gaussian(list(A = bad_psd), "group"),
               "positive semidefinite")
})

test_that("simulate_group_gaussian preserves group mean and SD for unequal groups", {
  params <- list(
    A = list(sampSize = 7000, mean_vec = c(3, -5),
             sampSD = c(1.5, 3), sampCorr_mat = diag(2)),
    B = list(sampSize = 7000, mean_vec = c(-2, 4),
             sampSD = c(5, 0.5), sampCorr_mat = diag(2))
  )
  set.seed(20261112)
  z <- simulate_group_gaussian(params, "group")
  for (k in names(params)) {
    block <- z[z$group == k, c("V1", "V2")]
    expect_equal(unname(colMeans(block)), params[[k]]$mean_vec,
                 tolerance = 0.2)
    expect_equal(unname(vapply(block, stats::sd, numeric(1))),
                 params[[k]]$sampSD, tolerance = 0.2)
  }
})
