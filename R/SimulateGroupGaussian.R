#' Simulate Group Multivariate Gaussian Data
#'
#' @description This function generates data for each group from a Multivariate
#' Gaussian (Normal) Distribution by invoking this distribution's random
#' generator once per group. It binds the generated data together into a single
#' data frame.
#'
#' @param param_list A list of named sublists, where each sublist contains the
#' parameters for a group (sample size, mean, standard deviation, and
#' correlation matrix). The dimension of the parameters for each group must be
#' the same. The generator constructs a covariance matrix as
#' `diag(sampSD) %*% sampCorr_mat %*% diag(sampSD)` and passes it to
#' `MASS::mvrnorm()`. Each group therefore uses the specified marginal
#' standard deviations. The input matrix must be symmetric positive
#' semidefinite with unit diagonal. Note that `calculate_stats_gaussian()`
#' estimates a Spearman correlation matrix; treating those rank correlations
#' as Pearson correlations in a Gaussian covariance is an approximation,
#' not an exact recovery of rank correlation.
#' @param group_col_name The column name of the grouping/label column to be
#' created in the final data frame. The values are taken from the names of the
#' sublists of `param_list`. Defaults to "group". See the example below.
#'
#' @return A data frame with the simulated data for all groups, including the
#' grouping column.
#' 
#' 
#' @export
#' @importFrom MASS mvrnorm
#'
#' @examples
#' # Example using MASS::mvrnorm for normal distribution
#' param_list <- list(
#'   Male = list(
#'     sampSize = 50,
#'     mean_vec = c(1, 2),
#'     sampSD = c(2, 1),
#'     sampCorr_mat = matrix(c(1, 0.5, 0.5, 1), 2, 2)
#'   ),
#'   Female = list(
#'     sampSize = 100,
#'     mean_vec = c(2, 3),
#'     sampSD = c(1, 2),
#'     sampCorr_mat = matrix(c(1, 0.3, 0.3, 1), 2, 2)
#'   )
#' )
#' simulate_group_gaussian(param_list, "Sex")
#' 
simulate_group_gaussian <- function(param_list, group_col_name) {
  if (!is.list(param_list) || length(param_list) == 0L ||
      is.null(names(param_list)) || anyNA(names(param_list)) ||
      any(!nzchar(names(param_list))) || anyDuplicated(names(param_list))) {
    stop("param_list must be a nonempty list of named sublists with unique group names.",
         call. = FALSE)
  }
  if (!is.character(group_col_name) || length(group_col_name) != 1L ||
      is.na(group_col_name) || !nzchar(group_col_name)) {
    stop("group_col_name must be a nonempty column name.", call. = FALSE)
  }

  expected <- c("sampSize", "mean_vec", "sampSD", "sampCorr_mat")
  sim_out <- lapply(names(param_list), function(group_name) {
    pars <- param_list[[group_name]]
    if (!is.list(pars) || !all(expected %in% names(pars))) {
      stop("Each group requires sampSize, mean_vec, sampSD and sampCorr_mat.",
           call. = FALSE)
    }
    n <- pars$sampSize
    mu <- pars$mean_vec
    sd_vec <- pars$sampSD
    corr <- pars$sampCorr_mat
    if (!is.numeric(n) || length(n) != 1L || !is.finite(n) ||
        n < 1 || n > .Machine$integer.max || n != floor(n)) {
      stop("sampSize must be a positive integer.", call. = FALSE)
    }
    if (!is.numeric(mu) || !is.numeric(sd_vec) ||
        length(mu) < 1L || length(mu) != length(sd_vec) ||
        any(!is.finite(mu)) || any(!is.finite(sd_vec)) ||
        any(sd_vec <= 0)) {
      stop("mean_vec and sampSD must have equal, positive dimension; sampSD must be strictly positive.",
           call. = FALSE)
    }
    dim_p <- length(mu)
    if (!is.matrix(corr) || !is.numeric(corr) ||
        !identical(dim(corr), c(dim_p, dim_p)) ||
        any(!is.finite(corr)) ||
        !isTRUE(all.equal(corr, t(corr), tolerance = 1e-8)) ||
        any(abs(diag(corr) - 1) > 1e-8) ||
        any(abs(corr) > 1 + 1e-8)) {
      stop("sampCorr_mat must be a finite, symmetric correlation matrix with unit diagonal.",
           call. = FALSE)
    }
    if (min(eigen(corr, symmetric = TRUE, only.values = TRUE)$values) < -1e-8) {
      stop("sampCorr_mat must be positive semidefinite.", call. = FALSE)
    }

    # D %*% R %*% D converts marginal SDs and a working correlation matrix
    # into a covariance matrix. The upstream estimator supplies Spearman
    # correlations; these are NOT automatically Pearson-equivalent.
    covariance <- sweep(sweep(corr, 1L, sd_vec, "*"), 2L, sd_vec, "*")
    drawn <- MASS::mvrnorm(n = as.integer(n), mu = mu, Sigma = covariance)
    # MASS::mvrnorm returns a vector if n == 1; preserve the p-column format.
    drawn <- matrix(drawn, nrow = as.integer(n), ncol = dim_p)
    df <- as.data.frame(drawn)
    names(df) <- if (!is.null(names(mu)) && all(nzchar(names(mu)))) {
      names(mu)
    } else {
      paste0("V", seq_len(dim_p))
    }
    if (group_col_name %in% names(df)) {
      stop("group_col_name collides with a simulated variable name.",
           call. = FALSE)
    }
    df[[group_col_name]] <- group_name
    df
  })
  do.call(rbind, sim_out)
}
