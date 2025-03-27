#' Simulate Group Multivariate Data
#'
#' This function generates data for each group from a Multivariate Gamma
#' Distribution by invoking this package's `generate_mvGamma_data()` function
#' once per group. It binds the generated data together into a single data
#' frame.
#'
#' @param param_list A list of named sublists, where each sublist contains the
#' parameters for a group (sample size, shape, rate, and correlation matrix).
#' @param group_col_name The column name of the grouping/label column to be
#' created in the final data frame. The values are taken from the names of the
#' sublists of `param_list`. Defaults to "group". See the example below.
#'
#' @return A data frame with the simulated data for all groups, including the
#' grouping column.
#'
#' @examples
#'
#' # Example using generate_mvGamma_data for MV Gamma distribution
#' param_list <- list(
#'   Male = list(
#'     sampSize = 100,
#'     sampCorr_mat = matrix(c(1, 0.5, 0.5, 1), 2, 2),
#'     shape_num = c(2, 2),
#'     rate_num = c(1, 1)
#'   ),
#'   Female = list(
#'     sampSize = 150,
#'     sampCorr_mat = matrix(c(1, 0.3, 0.3, 1), 2, 2),
#'     shape_num = c(1, 4),
#'     rate_num = c(0.5, 2)
#'   )
#' )
#' simulate_group_gamma(param_list, "Sex")
#'
#' @export
simulate_group_gamma <- function(param_list, group_col_name) {

  # Check if the list of parameters is named
  if (is.null(names(param_list))) {
    stop("param_list must be a list of named sublists for each group.")
  }

  # Initialize an empty list to store the generated data for each group
  all_data <- list()

  # Iterate over each group in param_list
  for (group_name in names(param_list)) {

    # Get the parameters for the current group
    group_params <- param_list[[group_name]]

    # Check if the required parameters are present in the group
    if (is.null(group_params$mean_vec) || is.null(group_params$sampCorr_mat)) {
      stop("Each group must have 'mean_vec' and 'sampCorr_mat' in its parameters.")
    }

    # Check for distribution-specific parameters and generate data
    if (identical(data_gen_fn, generate_mvGamma_data)) {
      # Ensure Gamma-specific parameters are present
      if (is.null(group_params$shape_num) || is.null(group_params$rate_num)) {
        stop("Each group must have 'shape_num' and 'rate_num' for the Gamma distribution.")
      }

      # Generate data using Gamma distribution
      generated_data <- data_gen_fn(
        sampSize = group_params$sampSize,
        mean_vec = group_params$mean_vec,
        sampCorr_mat = group_params$sampCorr_mat,
        shape_num = group_params$shape_num,
        rate_num = group_params$rate_num
      )

    } else if (identical(data_gen_fn, MASS::mvrnorm)) {
      # Generate data using Normal distribution
      generated_data <- data_gen_fn(
        n = group_params$sampSize,
        mu = group_params$mean_vec,
        Sigma = group_params$sampCorr_mat
      )

    } else {
      stop("Unsupported data generation function provided.")
    }

    # Create a data frame for the generated data and add the group label
    generated_data_df <- as.data.frame(generated_data)
    generated_data_df[[group_col_name]] <- group_name  # Add group label

    # Append the data to the list
    all_data[[group_name]] <- generated_data_df
  }

  # Combine all the group data frames into one
  combined_data <- do.call(rbind, all_data)

  return(combined_data)
}
