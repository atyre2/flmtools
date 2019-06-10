
#' Convert many-obs-per case data into lagged matrices
#'
#' lagData creates two matrix variables: one with the lagged covariates,
#' and a second with the indices used in the smooth term from mgcv.
#'
#' Assumes that lagData have already been aggregated to the appropriate resolution.
#' lagData should have \code{nrows(response)*nUnits - startUnit} *not true.
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

#' Convert many-obs-per case data into lagged matrices
#'
#' lagData2 creates two matrix variables: one with the lagged covariates,
#' and a second with the indices used in the smooth term from mgcv.
#'
#' Assumes that lagData have already been aggregated to the appropriate resolution.
#' lagData should have \code{nrows(response)*nUnits - startUnit} *not true.
#' matchon should break response down to one row per combination.
#'
#' @param response data.frame or tibble with the response and one-per-case covariates
#' @param lagData data.frame or tibble containing the predictor variables to be created as lags.
#' @param matchon a named character vector of variables to join by. For example, matchon = c("a" = "b") will match response.a to lagData.b.
#' @param matchtimes a named character vector of variables to join times.
#' @param nUnits integer how many rows of the smaller time variable to lag backwards
#'
#' @return returns a dataframe or tibble with as many rows as response, and two
#' new matrix columns
#' @export
#'
#' @examples
#' test <- lagData(env_data, response_data, unit = "month", 6, 24, "envVar")
#' dim(test$envVar_6_24)
#' test$lag_6_24[1:5,1:5]

lagData2 <- function(response, lagData, matchon, matchtime, nUnits){
  foo = response # not sure what's going on here.
  if (length(matchtime) != 2) stop("matchtime must have two time units")
  matchonvars <- dplyr::common_by(by = matchon, response, lagData)
  matchtimevars <- dplyr::common_by(by = matchtime, response, lagData)
  period <- max(lagData[,matchtimevars$y[2]])
  N <- nrow(response)
  # build the time table
  startUnit <- response[1,matchtimevars$x[2], drop = TRUE] # assume they are all the same - # better: check!
  Unit2 <- unique(lagData[, matchtimevars$y[2]])
  Unit1 <- unique(lagData[, matchtimevars$y[1]])
  laggedUnits2 <- rep(startUnit, times = nUnits + 1) - 0:nUnits
  tmptable <- response[,c(matchonvars$x, matchtimevars$x)]
  tmptable <- cbind(tmptable, matrix(laggedUnits2, nrow = N, ncol = nUnits + 1, byrow = TRUE))
  tmptable <- tidyr::gather(tmptable, key = "key", value = "laggedUnit2", (length(c(matchonvars$x, matchtimevars$x))+1):ncol(tmptable))
  tmptable[,matchtimevars$x[1]] <- tmptable[,matchtimevars$x[1]] + (tmptable[,"laggedUnit2"] - 1) %/% period
  tmptable[,matchtimevars$x[2]] <- tmptable[,"laggedUnit2"] %% period
  tmptable[,matchtimevars$x[2]][tmptable[,matchtimevars$x[2]] == 0] <- period

  return(tmptable)
}

