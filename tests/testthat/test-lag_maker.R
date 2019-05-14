context("test-lag_maker.R")

test <- lagData(env_data, response_data, unit = "month", 6, 24, "envVar")
# SORT results to allow comparison
test <- test[order(test$Location, test$year),]
# this data frame is internal
test_6_24 <- test_6_24[order(test_6_24$Location, test_6_24$year),]
test_that("lagData output correct", {
  expect_named(test, names(test_6_24), ignore.order = TRUE)
  expect_equal(test$Location, test_6_24$Location)
  expect_equivalent(test$envVar_6_24, test_6_24$envVar_6_24)
  expect_equivalent(test$lag_6_24+1, test_6_24$lag_6_24)
})
