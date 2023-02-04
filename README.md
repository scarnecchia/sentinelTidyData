
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sentinelTidyData

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/sentinelTidyData)](https://CRAN.R-project.org/package=sentinelTidyData)
<!-- badges: end -->

The goal of sentinelTidyData is to provide tools to make it easier to
work with the SAS datasets returned by [F.D.A Sentinel
Initiative’s](https://www.sentinelinitiative.org/) [Data
Characterization and Quality Assurance
Package](https://dev.sentinelsystem.org/projects/QA/repos/qa_package/browse).

## Installation

You can install the development version of sentinelTidyData from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("scarnecchia/sentinelTidyData")
```

## Example

Convert datasets where TRUE and FALSE is represented using numeric or
character values to a logical:

``` r
library(sentinelTidyData)
data_test <- tibble::tribble(
  ~dp, ~enr, ~dem, ~dia, ~dis, ~dth, ~enc, ~lab, ~pro, ~count,
  "NSDP",   1L,   1L,   0L,   0L,   0L,   0L,   0L,   0L,  24109,
  "NSDP",   1L,   1L,   0L,   0L,   0L,   0L,   1L,   0L,     57,
  "NSDP",   1L,   1L,   0L,   0L,   0L,   1L,   0L,   0L,      7,
)

sentinelTidyData::tidy_match(data_test)
#> # A tibble: 3 × 10
#>   dp    enr   dem   dia   dis   dth   enc   lab   pro   count
#>   <chr> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <dbl>
#> 1 NSDP  TRUE  TRUE  FALSE FALSE FALSE FALSE FALSE FALSE 24109
#> 2 NSDP  TRUE  TRUE  FALSE FALSE FALSE FALSE TRUE  FALSE    57
#> 3 NSDP  TRUE  TRUE  FALSE FALSE FALSE TRUE  FALSE FALSE     7
#> # A tibble: 3 × 10
#>   dp    enr   dem   dia   dis   dth   enc   lab   pro   count
#>   <chr> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <dbl>
#> 1 NSDP  TRUE  TRUE  FALSE FALSE FALSE FALSE FALSE FALSE 24109
#> 2 NSDP  TRUE  TRUE  FALSE FALSE FALSE FALSE TRUE  FALSE    57
#> 3 NSDP  TRUE  TRUE  FALSE FALSE FALSE TRUE  FALSE FALSE     7
```

Reformat Diagnosis, Dispensing, Procedure, and Prescribing datasets to
use common variable names.

``` r
data_test <- tibble::tribble(
  ~dp, ~dx_codetype,    ~dx, ~specialty, ~count,
  "NSDP",         "09", "0010",        99L,     1L,
  "NSDP",         "09", "0019",         NA,     1L
)

sentinelTidyData::convert_codecat(data_test, codecat="dx")
#> # A tibble: 2 × 6
#>   dp    codetype codecat code  specialty count
#>   <chr> <chr>    <chr>   <chr>     <int> <int>
#> 1 NSDP  dx       09      0010         99     1
#> 2 NSDP  dx       09      0019         NA     1
#> # A tibble: 2 × 6
#>   dp    codetype codecat code  specialty count
#>   <chr> <chr>    <chr>   <chr>     <int> <int>
#> 1 NSDP  dx       09      0010         99     1
#> 2 NSDP  dx       09      0019         NA     1
```
