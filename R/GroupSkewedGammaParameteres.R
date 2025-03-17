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
#' data <- tibble(
#'   GENDER = c('Male', 'Female', 'Male', 'Female'),
#'   VALUE1 = c(1.2, 2.3, 1.5, 2.7),
#'   VALUE2 = c(3.4, 4.5, 3.8, 4.2)
#' )
#' result <- calculate_group_params(data, "GENDER")
#'
calculate_group_params <- function(data, group_col) {
  library(dplyr)
  library(purrr)
  library(tidyr)

  # Define function to compute gamma parameters
  gamma_parameters <- function(x) {
    mean_x <- mean(x, na.rm = TRUE)
    shape <- mean_x^2
    rate <- mean_x
    list(shape = shape, rate = rate)
  }

  # Group data and calculate stats
  data_grouped <- data %>%
    group_by(across(all_of(group_col))) %>%
    nest()

  group_stats <- data_grouped %>%
    mutate(
      stats = map(data, ~ {
        group_data <- .x
        n <- nrow(group_data)

        numeric_cols <- select(group_data, -all_of(group_col))

        mean_vector <- numeric_cols %>%
          summarise(across(everything(), mean, na.rm = TRUE)) %>%
          unlist()

        cor_matrix <- cor(numeric_cols, method = "spearman", use = "pairwise.complete.obs")

        gamma_params <- map(numeric_cols, gamma_parameters)

        list(n = n, mean = mean_vector, gamma = gamma_params, cor = cor_matrix)
      })
    ) %>%
    pull(stats)

  return(group_stats)
}
