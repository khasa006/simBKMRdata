#' Calculate summary statistics and gamma parameters for each group
#'
#' This function computes the sample size, mean vector, gamma distribution parameters
#' (shape and rate), and Spearman correlation matrix for each group, based on the grouping column.
#'
#' @param data A data frame containing the data to be processed.
#' @param group_col A character string specifying the name of the column to group by.
#'
#' @return A list of lists, where each inner list contains:
#'   - sample size (n)
#'   - sample mean vector (mean)
#'   - gamma distribution parameters (shape, rate)
#'   - Spearman correlation matrix (cor)
#' @export
#'
#' @examples
#' myData <- data.frame(
#'   GENDER = c('Male', 'Female', 'Male', 'Female', 'Male', 'Female'),
#'   VALUE1 = c(1.2, 2.3, 1.5, 2.7, 1.35, 2.5),
#'   VALUE2 = c(3.4, 4.5, 3.8, 4.2, 3.6, 4.35)
#' )
#' calculate_group_param(myData, "GENDER")
#'
calculate_group_param <- function(data_df, group_col) {

  # split the data by grouping column
  data_ls <- split.data.frame(x = data_df, f = data_df[, group_col])

  # remove the grouping column
  data_ls <- lapply(
    X = data_ls,
    FUN = function(x) {
      x[, group_col] <- NULL
      x
    }
  )

  # Calculate statistics and moments (N, xBar, sd, corrMat, skew, alpha, beta)
  lapply(
    X = data_ls,
    FUN = .group_stats
  )

}

.group_stats <- function(x_df) {
  # Output: list of statistics and moments (N, xBar, sd, corrMat, skew, alpha, beta)

  # Sample size, mean vector, standard deviation vector, and Spearman correlation matrix
  samp_size <- nrow(x_df)
  mean_vector <- colMeans(x_df)
  samp_sd <- vapply(X = x_df, FUN = sd, FUN.VALUE = numeric(1))

  # Spearman correlation matrix
  samp_corr <- cor(
    x = x_df, method = "spearman", use = "pairwise.complete.obs"
  )

  # Calculate skewness (previous code)
  samp_skew <- vapply(
    X = seq_len(ncol(x_df)),
    FUN = function(d) {
      .skewness(
        x = x_df[, d],
        xBar = mean_vector[d],
        sampSD = samp_sd[d],
        N = samp_size
      )
    },
    FUN.VALUE = numeric(1)
  )

  # Calculate alpha_i (mean_vector) and beta_i (mean_vector^2) for each group
  alpha_beta <- data.frame(
    alpha = mean_vector,
    beta = mean_vector^2
  )

  # Return all statistics as a list
  out_ls <- list(
    sampSize = samp_size,
    xBar = mean_vector,
    sampSD = samp_sd,
    sampCorr = samp_corr,
    sampSkew = samp_skew,
    alpha = alpha_beta$alpha,
    beta = alpha_beta$beta
  )

  out_ls
}

# Skewness function
.skewness <- function(x, xBar, sampSD, N) {
  # Skewness calculation based on sample moments
  (sum((x - xBar)^3) / N) / (sum((x - xBar)^2) / (N - 1))^(3/2)
}
