#' Simulate response data given input lagged env data and an expression
#'
#' @param x data.frame containing at least 1 matrix column of lagged data
#' @param mu R expression describing how mean response relates to variables in x
#' @param rfunc function generating response from mean and parameters in ...
#' @param ... additional arguments to rfunc
#'
#' @return data.frame with all the variables in x plus a response variable
#' @export
#'
#' @examples
#' test <- lagData(env_data, response_data, unit = "month", 6, 24, "envVar")
#' # generate a response linear in the lag, normal errors sd = 5
#' test1 <- simResponse(test, 0.05*x1 + rowSums(0.1*lag_6_24*envVar_6_24), sd = 5)
#' fit1 <- mgcv::gam(response ~ x1 + s(lag_6_24, by = envVar_6_24), data = test1)
#' summary(fit1)
#'
#' # poisson response with sine function of lag and an offset
#' test2 <- simResponse(test, exp(-2 + log(offset) - 0.05*x1 +
#' rowSums(envVar_6_24*sin(lag_6_24/pi))), rpois)
#' fit2 <- mgcv::gam(response ~ offset(log(offset))  + x1 + s(lag_6_24, by = envVar_6_24),
#' data = test2, family = poisson)
#' summary(fit2)
#'

simResponse <- function(x, mu, rfunc = stats::rnorm, ...){
  resp_expr <- substitute(mu)
  mean_resp <- eval(resp_expr, envir = x)
  xp <- cbind(x, mu = mean_resp, response = rfunc(nrow(x), mean_resp, ...))
  return(xp)
}
