#' Children's Environmental Heavy Metal Exposure Data
#'
#' @description
#' This dataset originates from a real-world cohort study led by Dr. Lucchini
#' and collaborators, focusing on environmental exposures in children. It
#' includes measurements of five metal concentrations—Cadmium, Mercury, Arsenic,
#' Lead, and Manganese—alongside standardized intelligence quotient (IQ) scores,
#' and some other socio-economic and demographic variables.
#'
#' @format
#' A data frame with 437 rows and 13 columns:
#' \describe{
#'   \item{ID}{Subject's ID}
#'   \item{age}{Subject's age in years}
#'   \item{QI}{Intelligence quotient}
#'   \item{Cadmium}{Cd urine concentration	ng/ml}
#'   \item{Mercury}{Hg urine concentration	ng/ml}
#'   \item{Arsenic}{As urine concentration	ng/ml}
#'   \item{Lead}{Pb blood concentration	ng/ml}
#'   \item{Manganese}{Mn hair concentration	ng/g}
#'   \item{Sex}{Sex encoded as a factor with levels Female and Male}
#'   \item{BMI}{Body Mass Index (kg/m2)}
#'   \item{SES}{Socioeconomic status as an ordered factor (LOW, MEDIUM, HIGH)}
#'   \item{Distance_metres}{Distance to nearest industrial site (m)}
#'   \item{SPM}{Raven's Standard Progressive Matrices}
#' }
#'
#' @source Prof. Roberto Lucchini; see inst/scripts/data_metalExposChildren*.R
#' for processing details. The preparation script records an April 3, 2025,
#' permission email from Prof. Lucchini and indicates CC BY 4.0 distribution.
#' The original permission correspondence should be retained by the authors.
"metalExposChildren_df"
