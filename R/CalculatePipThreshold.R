#' Calculate PIP Threshold
#' 
#' @description Given a response vector (or statistics from this vector),
#' calculate a PIP threshold that should preserve close to a nominal 5% test 
#' size for Bayesian Kernel Machine Regression (BKMR) feature selection.
#'
#' @param y a response vector for BKMR
#' @param absCV If `y` is not supplied, the absolute value of the coefficient
#' of variation of the response
#' @param sampSize If `y` is not supplied, the number of observations included
#' in the response
#' @param coeffs_ls A list of Richard's Curve parameters. See Details.
#' @param na.rm Remove missing values from `y`? Defaults to `TRUE`
#'
#' @returns A single numeric value; the output of the Richard's Four-Parameter
#' Logistic Regression curve with the coefficient values supplied in
#' `coeffs_ls`.
#' 
#' @details Tanvir: include a link to the Richard's curve, LaTeX code to show
#' what this curve looks like, and a brief (1-2 sentence) explanation of how we
#' calculated the values in `coeffs_ls`.
#' 
#' @export
#' @importFrom stats sd
#'
#' @examples
#' CalculatePipThreshold(absCV = 7.5, sampSize = 300)
#' # should equal 0.6829892

CalculatePipThreshold <- function(
    y, absCV, sampSize,
    coeffs_ls = list(
      A = 0, K = 1.43462, C = 1.59948,
      betaAbsCV = 0.56615, betaSampSize = 0.51345
    ),
    na.rm = TRUE
  ){
  
  # Check inputs
  if (missing(y)) {
    argsMissing_lgl <- missing(absCV) | missing(sampSize)
    if (argsMissing_lgl) {
      stop(
        "If y is not supplied, both absCV and sampSize are required.",
        call. = FALSE
      )
    }
  } else {
    absCV <- abs( sd(y, na.rm = na.rm) / mean(y, na.rm = na.rm) )
    sampSize <- length(y)
  }
  
  # Calculate PIP threshold using Richard's Curve
  denomInner_num <- coeffs_ls$C + exp(-1 * coeffs_ls$betaAbsCV * log2(absCV))
  denom_num <- denomInner_num ^ (coeffs_ls$betaSampSize * log10(sampSize))
  PIP_num <- coeffs_ls$A + (coeffs_ls$K - coeffs_ls$A) / denom_num
  
  PIP_num
  
}
