#' Calculate summary statistics for each group
#'
#' This function computes the sample size, mean vector, and Spearman correlation
#' matrix for each group, based on the grouping column.
#'
#' @param data A data frame containing the data to be processed.
#' @param group_col A character string specifying the name of the column to group by.
#'
#' @return A list of lists, where each inner list contains:
#'   - sample size (n)
#'   - sample mean vector (mean)
#'   - Spearman correlation matrix (cor)
#'   - sample skewness (skew)
#' @export
#'
#' @examples
#' myData <- data.frame(
#'   GENDER = c('Male', 'Female', 'Male', 'Female', 'Male', 'Female'),
#'   VALUE1 = c(1.2, 2.3, 1.5, 2.7, 1.35, 2.5),
#'   VALUE2 = c(3.4, 4.5, 3.8, 4.2, 3.6, 4.35)
#' )
#' calculate_group_stats(myData, "GENDER")

calculate_group_stats <- function(data_df, group_col) {
  # Check if the grouping column exists
  if (!group_col %in% names(data_df)) {
    stop("Grouping column not found in the data frame.")
  }

  # Split the data by the grouping column
  data_ls <- split(data_df, data_df[[group_col]])

  # Remove the grouping column and apply statistics calculation for each group
  data_ls <- lapply(
    X = data_ls,
    FUN = function(x) {
      x[, group_col] <- NULL
      x
    }
  )

  # Calculate statistics and moments (N, xBar, sd, corrMat, skew)
  result <- lapply(
    X = data_ls,
    FUN = .group_stats
  )

  return(result)
}

#' Helper function to calculate statistics for each group
#'
#' @param x_df A numeric data frame with observations from one group
#' @return A list of statistics (sample size, mean, standard deviation, correlation matrix, skewness)
#' @export
.group_stats <- function(x_df) {

  # Calculate sample size, mean vector, standard deviation vector, and Spearman correlation matrix
  samp_size <- nrow(x_df)
  mean_vector <- colMeans(x_df, na.rm = TRUE)  # Calculate column-wise mean, removing NA
  samp_sd <- vapply(X = x_df, FUN = sd, FUN.VALUE = numeric(1), na.rm = TRUE)

  # Spearman correlation matrix
  samp_corr <- cor(x_df, method = "spearman", use = "pairwise.complete.obs")

  # Calculate skewness for each column
  samp_skew <- vapply(
    X = seq_len(ncol(x_df)),
    FUN = function(d) {
      if (length(unique(x_df[, d])) > 1) {
        .skewness(x = x_df[, d], xBar = mean_vector[d], sampSD = samp_sd[d], N = samp_size)
      } else {
        return(NA)  # Return NA if the column has only one unique value
      }
    },
    FUN.VALUE = numeric(1)
  )

  # Return all statistics as a list
  out_ls <- list(
    sampSize = samp_size,
    xBar = mean_vector,
    sampSD = samp_sd,
    sampCorr = samp_corr,
    sampSkew = samp_skew
  )

  return(out_ls)
}

#' Helper function to calculate skewness for a vector
#'
#' @param x A numeric vector of data
#' @param xBar The mean of the data
#' @param sampSD The standard deviation of the data
#' @param N The sample size
#' @return The skewness value
#' @export
.skewness <- function(x, xBar, sampSD, N) {
  # Skewness calculation based on sample moments
  numerator <- sum((x - xBar)^3) / N
  denominator <- (sum((x - xBar)^2) / (N - 1))^(3/2)
  numerator / denominator
}
