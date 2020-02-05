
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
test$envVar_6_24[1:5,1:5]
#>           [,1]       [,2]       [,3]        [,4]       [,5]
#> [1,] -1.814588  0.4147297 -0.8106267  0.01793560 -0.2340466
#> [2,] -1.398805 -0.6188605 -0.2926461 -0.03419035 -0.7086876
#> [3,] -1.852108 -1.2623994 -1.5570320  0.13727948 -0.9648743
#> [4,] -1.766835 -0.7007030 -0.8072138  0.05019164 -1.3552247
#> [5,] -1.470783 -0.1804599 -0.3980886  0.17245816 -0.7682544
```

## Code of Conduct

Please note that the ‘flmtools’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
