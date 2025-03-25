#' Calculate summary statistics for each group using tidyverse functions
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
#' @export
#'
#' @examples
#' myData <- data.frame(
#'   GENDER = c('Male', 'Female', 'Male', 'Female', 'Male', 'Female'),
#'   VALUE1 = c(1.2, 2.3, 1.5, 2.7, 1.35, 2.5),
#'   VALUE2 = c(3.4, 4.5, 3.8, 4.2, 3.6, 4.35)
#' )
#' calculate_group_stats(myData, "GENDER")
#'
calculate_group_stats <- function(data_df, group_col) {

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

  # Calculate statistics and moments (N, xBar, sd, corrMat, skew)
  lapply(
    X = data_ls,
    FUN = .group_stats
  )

}

.group_stats <- function(x_df) {
  # Input: a numeric data frame with observations from one group
  # Output: list of statistics and moments (N, xBar, sd, corrMat, skew)
  # Example:
  # myDataFemale <- data.frame(
  #   VALUE1 = c(2.3, 2.7, 2.5),
  #   VALUE2 = c(4.5, 4.2, 4.35)
  # )
  # .group_stats(myDataFemale)

  # browser()

  out_ls <- list(
    sampSize = nrow(x_df),
    xBar = colMeans(x_df),
    sampSD = vapply(X = x_df, FUN = sd, FUN.VALUE = numeric(1)),
    sampCorr = cor(
      x = x_df, method = "spearman", use = "pairwise.complete.obs"
    )
  )
  # Tanvir, use vapply() to calculate column-wise skewness
  out_ls[["sampSkew"]] <- vapply(
    X = seq_len(ncol(x_df)),
    FUN = function(d) {
      .skewness(
        x = x_df[, d],
        xBar = out_ls[["xBar"]][d],
        sampSD = out_ls[["sampSD"]][d],
        N = out_ls[["sampSize"]]
      )
    },
    FUN.VALUE = numeric(1)
  )

  out_ls

}

.skewness <- function(x, xBar, sampSD, N) {
  # https://en.wikipedia.org/wiki/Skewness
  (sum((x - xBar)^3) / N) / (sum((x - xBar)^2) / (N - 1))^(3/2)
}


###  ORIGINAL DRAFT USING dplyr::  ###
# # Use dplyr to group by the group_col
# data_grouped <- data %>%
#   group_by_at(group_col) %>%
#   nest()  # Nest the data by groups
#
# # Apply the calculation of statistics for each group
# group_stats <- data_grouped %>%
#   mutate(
#     stats = map(data, ~ {
#       group_data <- .x
#       n <- nrow(group_data)  # Sample size
#       mean_vector <- group_data %>%
#         select(-all_of(group_col)) %>%
#         summarise(across(everything(), mean, na.rm = TRUE)) %>%
#         unlist()  # Get the mean vector
#
#       cor_matrix <- group_data %>%
#         select(-all_of(group_col)) %>%
#         cor(method = "spearman", use = "pairwise.complete.obs")  # Spearman correlation matrix
#
#       # Return the list of statistics for the group
#       list(n = n, mean = mean_vector, cor = cor_matrix)
#     })
#   ) %>%
#   pull(stats)  # Extract the list of statistics
#
# return(group_stats)
