#' Generate Multivariate Skewed Gamma Transformed Data
#'
#' @description Generates a latent multivariate Gaussian sample using
#' `MASS::mvrnorm()`, applies `pnorm()` to each component, then transforms
#' probabilities with marginal `qgamma()` calls. A valid latent correlation
#' matrix has unit diagonal and must be positive semidefinite to obtain the
#' specified Gamma marginal distributions. Pearson and rank correlations of
#' the resulting Gamma variables generally differ from the latent correlations.
#'
#' @param sampSize A single positive integer number of samples to generate.
#' @param sampCorr_mat A finite symmetric positive-semidefinite latent Gaussian
#' correlation matrix with unit diagonal, passed to `MASS::mvrnorm()` as a
#' covariance matrix. Its entries are not generally the Gamma Pearson or
#' Spearman correlations.
#' @param shape_num A finite, strictly positive numeric vector of Gamma shape
#' parameters, one per simulated variable.
#' @param rate_num A finite, strictly positive numeric vector of Gamma rate
#' parameters, one per simulated variable.
#' @return A data frame with `sampSize` rows and one column per variable,
#' including for `sampSize = 1` or a one-variable correlation matrix.
#'
#' @importFrom MASS mvrnorm
#' @importFrom stats pnorm qgamma
#' @export
#'
#' @examples
#' p <- 4
#' N <- 1000
#' shapeGamma_num <- c(0.5, 0.75, 1, 1.25)
#' rateGamma_num <- 1:4
#' cov_mat <- diag(p)
#' generate_mvGamma_data(N, cov_mat, shapeGamma_num, rateGamma_num)

generate_mvGamma_data <- function(sampSize,
                                  sampCorr_mat,
                                  shape_num,
                                  rate_num) {

  if (!is.numeric(sampSize) || length(sampSize) != 1L ||
      !is.finite(sampSize) || sampSize < 1 ||
      sampSize > .Machine$integer.max || sampSize != floor(sampSize)) {
    stop("sampSize must be a single positive integer.", call. = FALSE)
  }
  if (!is.matrix(sampCorr_mat) || !is.numeric(sampCorr_mat) ||
      length(dim(sampCorr_mat)) != 2L ||
      nrow(sampCorr_mat) < 1L || nrow(sampCorr_mat) != ncol(sampCorr_mat) ||
      any(!is.finite(sampCorr_mat))) {
    stop("sampCorr_mat must be a finite, nonempty, square numeric correlation matrix.",
         call. = FALSE)
  }
  p <- ncol(sampCorr_mat)
  if (!is.numeric(shape_num) || length(shape_num) != p) {
    stop("The length of shape_num must match the number of variables (p).",
         call. = FALSE)
  }
  if (!is.numeric(rate_num) || length(rate_num) != p) {
    stop("The length of rate_num must match the number of variables (p).",
         call. = FALSE)
  }
  if (any(!is.finite(shape_num)) || any(shape_num <= 0)) {
    stop("shape_num must contain only finite, strictly positive values.",
         call. = FALSE)
  }
  if (any(!is.finite(rate_num)) || any(rate_num <= 0)) {
    stop("rate_num must contain only finite, strictly positive values.",
         call. = FALSE)
  }
  if (!isTRUE(all.equal(sampCorr_mat, t(sampCorr_mat),
                        tolerance = 1e-8)) ||
      any(abs(diag(sampCorr_mat) - 1) > 1e-8) ||
      any(abs(sampCorr_mat) > 1 + 1e-8)) {
    stop("sampCorr_mat must be symmetric with a unit diagonal and correlations in [-1, 1].",
         call. = FALSE)
  }
  if (min(eigen(sampCorr_mat, symmetric = TRUE,
                only.values = TRUE)$values) < -1e-8) {
    stop("sampCorr_mat must be positive semidefinite.", call. = FALSE)
  }

  n <- as.integer(sampSize)
  norm_samples <- MASS::mvrnorm(
    n = n,
    mu = rep.int(0, p),
    Sigma = sampCorr_mat
  )
  # mvrnorm() may drop dimensions for a single observation; qgamma's
  # column-wise transform always requires an n-by-p matrix.
  norm_samples <- matrix(norm_samples, nrow = n, ncol = p)
  norm_cdf <- stats::pnorm(norm_samples)
  .mvGamma_fn(norm_cdf, shape_num, rate_num)
}

# Function to apply qgamma transformation to each variable
.mvGamma_fn <- function(normCdf_mat, shape_num, rate_num) {
  dataP <- ncol(normCdf_mat)
  dataN <- nrow(normCdf_mat)

  out_mat <- matrix(
    data = vapply(
      X = seq_len(dataP),
      FUN = function(d) {
        stats::qgamma(
          p = normCdf_mat[, d],
          shape = shape_num[d],
          rate = rate_num[d]
        )
      },
      FUN.VALUE = numeric(dataN)
    ),
    nrow = dataN, ncol = dataP, byrow = FALSE
  )
  as.data.frame(out_mat)
}
