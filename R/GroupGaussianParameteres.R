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
#' data <- tibble(
#'   GENDER = c('Male', 'Female', 'Male', 'Female'),
#'   VALUE1 = c(1.2, 2.3, 1.5, 2.7),
#'   VALUE2 = c(3.4, 4.5, 3.8, 4.2)
#' )
#' result <- calculate_group_stats(data, "GENDER")
#'
calculate_group_stats <- function(data, group_col) {

  # Use dplyr to group by the group_col
  data_grouped <- data %>%
    group_by_at(group_col) %>%
    nest()  # Nest the data by groups

  # Apply the calculation of statistics for each group
  group_stats <- data_grouped %>%
    mutate(
      stats = map(data, ~ {
        group_data <- .x
        n <- nrow(group_data)  # Sample size
        mean_vector <- group_data %>%
          select(-all_of(group_col)) %>%
          summarise(across(everything(), mean, na.rm = TRUE)) %>%
          unlist()  # Get the mean vector

        cor_matrix <- group_data %>%
          select(-all_of(group_col)) %>%
          cor(method = "spearman", use = "pairwise.complete.obs")  # Spearman correlation matrix

        # Return the list of statistics for the group
        list(n = n, mean = mean_vector, cor = cor_matrix)
      })
    ) %>%
    pull(stats)  # Extract the list of statistics

  return(group_stats)
}
