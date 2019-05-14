
#' Convert many-obs-per case data into lagged matrices
#'
#' lagData creates two matrix variables: one with the lagged covariates,
#' and a second with the indices used in the smooth term from mgcv.
#'
#' Assumes that lagData have already been aggregated to the appropriate resolution.
#' lagData should have \code{nrows(response)*nUnits - startUnit} *not true.
#' matchon should break response down to one row per combination.
#'
#' @param lagData data.frame or tibble containing the predictor variables to be created as lags. Must be sorted by Location, year, month.
#' @param response data.frame or tibble with the response and one-per-case covariates
#' @param unit character string variable name in lagData by which to lag
#' @param startUnit integer where to start the lagging
#' @param nUnits integer how many rows to lag backwards
#' @param measure character string name of column in lagData to convert to matrices
#'
#' @return returns a dataframe or tibble with as many rows as response, and two
#' new matrix columns
#' @export
#'
#' @examples
#' test <- lagData(env_data, response_data, unit = "month", 6, 24, "envVar")
#' dim(test$envVar_6_24)
#' test$lag_6_24[1:5,1:5]

lagData <- function(lagData, response, unit, startUnit, nUnits, measure){

  period <- max(lagData[,unit])
  N <- nrow(response)
  byMatrix <- matrix(NA, nrow = N, ncol = nUnits+1)
  for (row in 1:N){
    # find the starting point
    startYear <- response[row, "year", drop = TRUE] # year and Location
    startLocation <- response[row, "Location", drop = TRUE]
    endYear <- startYear - floor(nUnits/period) # if nUnits < period then endYear == startYear
    # logical vector to pull out the right part of envData
    pick <- with(lagData, year %in% startYear:endYear & Location == startLocation)
    # pack it in reverse order! first column is year, month == startUnit
    byMatrix[row, ] <- rev(lagData[pick, measure, drop=TRUE][startUnit:(nUnits + period - startUnit)])
  }
  byMatName <- paste(measure, startUnit, nUnits, sep = "_")
  lagMatName <- paste("lag", startUnit, nUnits, sep = "_")
  response[,byMatName] <- byMatrix
  response[,lagMatName] <- matrix(0:nUnits, nrow = N, ncol = nUnits + 1, byrow = TRUE)
  return(response) #return(datag)
}

