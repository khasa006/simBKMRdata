#' Generate Multivariate Skewed Gamma Transformed Data
#'
#' This function generates multivariate normal samples, transforms them into Z-scores,
#' and then applies a `qgamma` transformation to each variable.
#'
#' @param N Number of samples to generate.
#' @param mean_vec A numeric vector of means for the normal distribution.
#' @param cov_mat A covariance matrix for the normal distribution.
#' @param shape_num A numeric vector of shape parameters for the Gamma transformation.
#' @param rate_num A numeric vector of rate parameters for the Gamma transformation.
#'
#' @return A list containing:
#'   - \code{norm_samples}: The generated multivariate normal samples.
#'   - \code{norm_cdf}: The CDF of the normal samples.
#'   - \code{gamma_samples}: The transformed Gamma samples.
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
#' mean_vec <- rep(0, p)
#' cov_mat <- diag(p)
#' generate_mvGamma_data(N, mean_vec, cov_mat, shapeGamma_num, rateGamma_num)

generate_mvGamma_data <- function(N, mean_vec, cov_mat, shape_num, rate_num) {
  # Check that the length of shape_num and rate_num match the number of variables (p)
  p <- length(mean_vec)
  if (length(shape_num) != p) {
    stop("The length of shape_num must match the number of variables (p).")
  }
  if (length(rate_num) != p) {
    stop("The length of rate_num must match the number of variables (p).")
  }

  # Generate multivariate normal samples
  norm_samples <- MASS::mvrnorm(n = N, mu = mean_vec, Sigma = cov_mat)

  # Calculate the CDF of the normal samples
  norm_cdf <- stats::pnorm(norm_samples)

  # Function to apply qgamma transformation to each variable
  mvGamma_fn <- function(normCdf_mat, shape_num, rate_num) {
    dataP <- ncol(normCdf_mat)
    dataN <- nrow(normCdf_mat)

    # Apply the qgamma transformation to each column
    matrix(
      data = vapply(
        X = seq_len(dataP),
        FUN = function(d) {
          stats::qgamma(p = normCdf_mat[, d], shape = shape_num[d], rate = rate_num[d])
        },
        FUN.VALUE = numeric(dataN)
      ),
      nrow = dataN, ncol = dataP, byrow = FALSE
    )
  }

  # Apply the gamma transformation
  gamma_samples <- mvGamma_fn(norm_cdf, shape_num, rate_num)

  # Return the results as a list
  return(list(norm_samples = norm_samples, norm_cdf = norm_cdf, gamma_samples = gamma_samples))
}
