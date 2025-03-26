#' Helper function to estimate shape, rate, and correlation parameters for
#' observations within a group
#'
#' @param x_df A numeric data frame with observations from ONE group
#' @param using which method will be used to estimate the multivariate Gamma 
#' shape and rate parameters. Defaults to `"MoM"` (method of moments, which was
#' used in the author's paper), or `"gMLE"` (maximum likelihood estimates from
#' the Generalized Gamma distribution without bias correction).
#' @return A list of estimated parameters for Multivariate Gamma distribution
#' (sample size, sample correlation matrix `sampCorr`, sample shape vector
#' `alpha`, sample rate vector `beta`)
#' @export
#'
#' @examples
#' myData <- data.frame(
#'   VALUE1 = c(2.3, 2.7, 5),
#'   VALUE2 = c(4.5, 4.2, 9)
#' )
#' estimate_mv_shape_rate(myData)
estimate_mv_shape_rate <- function(x_df, using = c("MoM", "gMLE")) {
  
  using <- match.arg(using)
  
  moments_ls <- estimate_mv_moments(x_df)
  samp_size <- moments_ls$sampSize
  mean_vector <- moments_ls$xBar
  samp_sd <- moments_ls$sampSD
  samp_corr <- moments_ls$sampCorr
  
  if (using == "MoM") {
    
    # Calculate Gamma distribution parameters with method of moments 
    alpha_num <- (mean_vector^2) / samp_sd^2  # Shape parameter
    beta_num <- samp_sd^2 / mean_vector       # Rate parameter
    
  } else if (using == "gMLE") {
    # https://en.wikipedia.org/wiki/Gamma_distribution#Closed-form_estimators
    
    xlnx <- x_df * log(x_df)
    beta_num <- colMeans(xlnx) - colMeans(x_df) * colMeans(log(x_df))
    alpha_num <- colMeans(x_df) / beta_num
    
  }
  
  # Return all statistics as a list
  list(
    sampSize = samp_size,
    sampCorr = samp_corr,
    alpha = alpha_num,
    beta = beta_num
  )
  
}
