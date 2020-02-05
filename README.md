
<!-- README.md is generated from README.Rmd. Please edit that file -->

# flmtools

<!-- badges: start -->

[![Travis Build
Status](https://travis-ci.com/atyre2/flmtools.svg?branch=master)](https://travis-ci.com/atyre2/flmtools)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/atyre2/flmtools?branch=master&svg=true)](https://ci.appveyor.com/project/atyre2/flmtools)
[![codecov](https://codecov.io/gh/atyre2/flmtools/branch/master/graph/badge.svg)](https://codecov.io/gh/atyre2/flmtools)

<!-- badges: end -->

Functions for working with Functional Linear Models fit by package mgcv

## Installation

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("atyre2/flmtools")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(flmtools)
test <- lagData(env_data, response_data, unit = "month", 6, 24, "envVar")
dim(test$envVar_6_24)
#> [1] 1564   25
test$lag_6_24[1:5,1:5]
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,]    0    1    2    3    4
#> [2,]    0    1    2    3    4
#> [3,]    0    1    2    3    4
#> [4,]    0    1    2    3    4
#> [5,]    0    1    2    3    4
```

## Code of Conduct

Please note that the ‘flmtools’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
