#' Test `create_utilization()` function
data_test <- tibble::tribble(
  ~dp, ~enr, ~dem,  ~dia,  ~dis,  ~dth,  ~enc,  ~lab,  ~pro, ~count,
  "NSDP", TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,  24109,
  "NSDP", TRUE, TRUE, FALSE, FALSE, FALSE, FALSE,  TRUE, FALSE,     57,
  "NSDP", TRUE, TRUE, FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE,      7,
  "NSDP", TRUE, TRUE, FALSE, FALSE, FALSE,  TRUE, FALSE,  TRUE,     25,
  "NSDP", TRUE, TRUE, FALSE,  TRUE, FALSE, FALSE, FALSE, FALSE,   3421,
  "NSDP", TRUE, TRUE, FALSE,  TRUE, FALSE, FALSE,  TRUE, FALSE,     32,
  "NSDP", TRUE, TRUE, FALSE,  TRUE, FALSE,  TRUE, FALSE, FALSE,      4,
  "NSDP", TRUE, TRUE, FALSE,  TRUE, FALSE,  TRUE, FALSE,  TRUE,      7,
  "NSDP", TRUE, TRUE,  TRUE, FALSE, FALSE,  TRUE, FALSE, FALSE,     23,
  "NSDP", TRUE, TRUE,  TRUE, FALSE, FALSE,  TRUE, FALSE,  TRUE,  36160,
  "NSDP", TRUE, TRUE,  TRUE, FALSE, FALSE,  TRUE,  TRUE, FALSE,      2,
  "NSDP", TRUE, TRUE,  TRUE, FALSE, FALSE,  TRUE,  TRUE,  TRUE,   1848,
  "NSDP", TRUE, TRUE,  TRUE, FALSE,  TRUE,  TRUE, FALSE,  TRUE,     51,
  "NSDP", TRUE, TRUE,  TRUE, FALSE,  TRUE,  TRUE,  TRUE,  TRUE,      6,
  "NSDP", TRUE, TRUE,  TRUE,  TRUE, FALSE,  TRUE, FALSE, FALSE,      3,
  "NSDP", TRUE, TRUE,  TRUE,  TRUE, FALSE,  TRUE, FALSE,  TRUE,  77310,
  "NSDP", TRUE, TRUE,  TRUE,  TRUE, FALSE,  TRUE,  TRUE,  TRUE,   9717,
  "NSDP", TRUE, TRUE,  TRUE,  TRUE,  TRUE,  TRUE, FALSE,  TRUE,    118,
  "NSDP", TRUE, TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,     11
)

expected_outcome <- tibble::tribble(
  ~utilizing, ~count,
  FALSE,  24166,
  TRUE, 128745
)

test_that("create_utilization function returns the expected outcome", {
  result <- create_utilization(data_test)
  expect_equal(result, expected_outcome)
})

expected_outcome <- tibble::tribble(
  ~dp, ~utilizing, ~count,
  "NSDP",      FALSE,  24166,
  "NSDP",       TRUE, 128745
)

test_that("create_utilization function returns the expected outcome when passed a grouping variable", {
  result <- create_utilization(data_test, cols = "dp")
  expect_equal(result, expected_outcome)
})

#' Test `create_orphan_enc()` function
data_test <- tibble::tribble(
  ~dp, ~enc,  ~dia,  ~pro,  ~count,
  "NSDP", TRUE, FALSE, FALSE,    8019,
  "NSDP", TRUE, FALSE,  TRUE,    3008,
  "NSDP", TRUE,  TRUE, FALSE,   12194,
  "NSDP", TRUE,  TRUE,  TRUE, 3515721
)

expected_outcome <- tibble::tribble(
  ~matched,  ~count,
  FALSE,    8019,
  TRUE, 3530923
)

test_that("`create_orphan_enc` function returns the expected outcome", {
  result <- create_orphan_enc(data_test)
  expect_equal(result, expected_outcome)
})

expected_outcome <- tibble::tribble(
  ~dp, ~matched,  ~count,
  "NSDP",    FALSE,    8019,
  "NSDP",     TRUE, 3530923
)

test_that("`create_orphan_enc` function returns the expected outcome when passed a grouping variable", {
  result <- create_orphan_enc(data_test, cols = "dp")
  expect_equal(result, expected_outcome)
})






