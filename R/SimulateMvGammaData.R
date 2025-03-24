# Function to generate multivariate normal samples, transform to Z-scores, and apply qgamma transformation
generate_mvGamma_data <- function(N, p, mean_vec, cov_mat, shape_num, rate_num) {

  # Generate multivariate normal samples
  norm_samples <- MASS::mvrnorm(n = N, mu = mean_vec, Sigma = cov_mat)

  # Convert to CDF values (Z-score transformation)
  norm_cdf <- pnorm(norm_samples)

  # Apply qgamma transformation
  mvGamma_fn <- function(normCdf_mat, shape_num, rate_num) {
    dataP <- ncol(normCdf_mat)
    dataN <- nrow(normCdf_mat)

    matrix(
      data = vapply(
        X = seq_len(dataP),
        FUN = function(d) {
          qgamma(p = normCdf_mat[, d], shape = shape_num[d], rate = rate_num[d])
        },
        FUN.VALUE = matrix(NA_real_, nrow = dataN)
      ),
      nrow = dataN, ncol = dataP, byrow = FALSE
    )
  }

  gamma_samples <- mvGamma_fn(norm_cdf, shape_num, rate_num)

  return(
    list(
      norm_samples = norm_samples,
      norm_cdf = norm_cdf,
      gamma_samples = gamma_samples
    )
  )
}

# Parameters
p <- 4
N <- 1000
shapeGamma_num <- c(0.5, 0.75, 1, 1.25)
rateGamma_num <- 1:4
mean_vec <- rep(0, p)
cov_mat <- diag(nrow = p)

# Set seed for reproducibility
set.seed(2025)

# Generate data
output <- generate_mvGamma_data(N, p, mean_vec, cov_mat, shapeGamma_num, rateGamma_num)

# Extract results
norm_samples <- output$norm_samples
norm_cdf <- output$norm_cdf
gamma_samples <- output$gamma_samples

# Plot density of last variable
par(mfrow = c(2, 1))
plot(density(norm_samples[, 4]), main = "Density of Normal Samples")
plot(density(gamma_samples[, 4]), main = "Density of Gamma Transformed Samples")
par(mfrow = c(1, 1))
