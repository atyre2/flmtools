#Create data objects for package from raw data files
env_data <- readr::read_csv("data-raw/env_data.csv")
response_data <- readr::read_csv("data-raw/response_data.csv")
test_6_24 <- readRDS("data-raw/test_6_24.RDS")
usethis::use_data(env_data, response_data, overwrite = TRUE)
usethis::use_data(test_6_24, overwrite = TRUE, internal = TRUE)
