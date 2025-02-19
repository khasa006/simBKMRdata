#' Title
#'
#' @param y 
#' @param absCV 
#' @param sampSize 
#' @param coeffs_ls 
#' @param na.rm 
#'
#' @returns
#' @export
#'
#' @examples
#' 

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

# Test
# CalculatePipThreshold(absCV = 7.5, sampSize = 300)
# should equal 0.6829892
