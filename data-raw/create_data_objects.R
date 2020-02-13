#Create data objects for package from raw data files
env_data <- readr::read_csv("data-raw/env_data.csv")
response_data <- readr::read_csv("data-raw/response_data.csv")
test_6_24 <- readRDS("data-raw/test_6_24.RDS")
small_response <- filter(response_data,
                         Location %in% c("52fd31d7","3421b03c","ff529e8f"),
                         year <= 5)

missing1location <- env_data %>%
  filter(Location != "3421b03c")
missing1year <- env_data %>%
  filter(year != 3)

usethis::use_data(env_data, response_data, overwrite = TRUE)
usethis::use_data(test_6_24, small_response, missing1location,
                  missing1year,
                  overwrite = TRUE, internal = TRUE)
