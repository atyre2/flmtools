#' Environmental data by year, month, and location
#'
#' A anonymized dataset containing an environmental covariate measured by month at many
#' locations for several years
#'
#' @format A data frame with 24288 rows and 4 variables:
#' \describe{
#'   \item{month}{as integer}
#'   \item{year}{as integer}
#'   \item{envVar}{An environmental variable, standardized by month}
#'   \item{Location}{character, label for location}
#' }
#' @source Created by the package author.
"env_data"

#' Environmental data by year and location
#'
#' A anonymized dataset containing an environmental count response, a covariate measured once per year, and a log offset.
#'
#' @format A data frame with 1564 rows and 5 variables:
#' \describe{
#'   \item{year}{as integer}
#'   \item{counts}{An environmental count variable}
#'   \item{Location}{character, label for location}
#'   \item{offset}{log of an offset for count models (e.g. area or time exposed)}
#'   \item{x1}{An environmental covariate measured once per year at each location, standardized.}
#' }
#' @source Created by the package author.
"response_data"
