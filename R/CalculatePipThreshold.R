#' Calculate PIP Threshold
#'
#' @description Given a response vector (or statistics from this vector),
#' evaluate a simulation-calibrated PIP threshold for Bayesian Kernel
#' Machine Regression (BKMR) feature selection. The output is an empirical
#' selection heuristic, not a guarantee of frequentist Type I error control.
#'
#' @param y a response vector for BKMR
#' @param absCV If `y` is not supplied, the absolute value of the coefficient
#' of variation of the response
#' @param sampSize If `y` is not supplied, the number of observations included
#' in the response
#' @param coeffs_ls A list of Richard's Curve parameters. See Details.
#' @param na.rm Whether missing values are ignored when computing the mean
#' and SD of `y`. Defaults to `TRUE`. If missing values are excluded,
#' `sampSize` is the number of nonmissing observations.
#'
#' @returns A single numeric value; the output of the Richard's Four-Parameter
#' Logistic Regression curve with the coefficient values supplied in
#' `coeffs_ls`.
#'
#' @details This function evaluates a generalized logistic curve fitted
#' previously to simulation-based 95th percentiles of PIPs over response CV
#' and sample size. The function uses the supplied fixed coefficients; it does
#' not fit a regression model or call `nls()`. The default coefficients reflect
#' the calibration conditions in the related accepted methodological study.
#' Use outside those conditions requires separate calibration assessment.
#' \deqn{
#'   PIP(q_{95}) = A + \frac{K-A}{ (C + \exp(-\beta_1x_1) )^{\beta_2x_2} }
#' }
#' Where-
#'
#' A: Fixed left asymptote (0);
#'
#' K: Right asymptote;
#'
#' C: Constant;
#'
#' \eqn{\beta_1, \beta_2}: Midpoint shift parameters for CV and sample size;
#'
#' x1: Log2-transformed |CV| (log2(|CV|));
#'
#' x2: Log-transformed sample size (log10(Sample Size)).
#'
#' The coefficients and their saved-output numerical verification are described
#' in the BKMR analysis archive: <https://doi.org/10.5281/zenodo.24021746>.
#' When `y` is supplied, its nonmissing observation count is used for the
#' sample-size term if `na.rm = TRUE`. At least two observed values, a nonzero
#' mean, and nonzero SD are required. Invalid or degenerate inputs cause an
#' explicit error. Existing complete-case calculations are unchanged.
#'
#' For more information on Richard's curve, see
#' <https://en.wikipedia.org/wiki/Generalised_logistic_function>
#'
#' @export
#' @importFrom stats sd
#'
#' @examples
#' calculate_pip_threshold(absCV = 7.5, sampSize = 300)
#' # should equal approximately 0.6549943
#'
calculate_pip_threshold <- function(
    y, absCV, sampSize,
    coeffs_ls = list(
      A = 0, K = 1, C = 1.30460,
      betaAbsCV = 0.59867, betaSampSize = 0.43565
    ),
    na.rm = TRUE
  ) {

  if (!is.logical(na.rm) || length(na.rm) != 1L || is.na(na.rm)) {
    stop("na.rm must be TRUE or FALSE.", call. = FALSE)
  }

  if (missing(y)) {
    if (missing(absCV) || missing(sampSize)) {
      stop("If y is not supplied, both absCV and sampSize are required.",
           call. = FALSE)
    }
  } else {
    if (!is.numeric(y) || any(!is.finite(y[!is.na(y)]))) {
      stop("y must be a numeric vector with finite observed values.",
           call. = FALSE)
    }
    if (anyNA(y) && !na.rm) {
      stop("y contains missing values; set na.rm = TRUE to exclude them.",
           call. = FALSE)
    }
    y_observed <- if (na.rm) y[!is.na(y)] else y
    sampSize <- length(y_observed)
    if (sampSize < 2L || !is.finite(mean(y_observed)) ||
        mean(y_observed) == 0 ||
        !is.finite(stats::sd(y_observed)) || stats::sd(y_observed) == 0) {
      stop("y must contain at least two observations with nonzero mean and nonzero SD.",
           call. = FALSE)
    }
    absCV <- abs(stats::sd(y_observed) / mean(y_observed))
  }

  if (!is.numeric(absCV) || length(absCV) != 1L ||
      !is.finite(absCV) || absCV <= 0) {
    stop("absCV must be a single finite positive number.", call. = FALSE)
  }
  if (!is.numeric(sampSize) || length(sampSize) != 1L ||
      !is.finite(sampSize) || sampSize < 2 ||
      sampSize != floor(sampSize)) {
    stop("sampSize must be an integer of at least 2.", call. = FALSE)
  }
  keys <- c("A", "K", "C", "betaAbsCV", "betaSampSize")
  if (!is.list(coeffs_ls) || !all(keys %in% names(coeffs_ls)) ||
      any(vapply(coeffs_ls[keys], function(x) {
        !is.numeric(x) || length(x) != 1L || !is.finite(x)
      }, logical(1)))) {
    stop("coeffs_ls must contain finite scalar A, K, C, betaAbsCV, and betaSampSize.",
         call. = FALSE)
  }

  inner <- coeffs_ls$C +
    exp(-coeffs_ls$betaAbsCV * log2(absCV))
  if (!is.finite(inner) || inner <= 0) {
    stop("The logistic denominator base must be finite and positive.",
         call. = FALSE)
  }
  result <- coeffs_ls$A +
    (coeffs_ls$K - coeffs_ls$A) /
    (inner ^ (coeffs_ls$betaSampSize * log10(sampSize)))
  if (!is.finite(result)) {
    stop("The calculated threshold is not finite.", call. = FALSE)
  }
  result
}
