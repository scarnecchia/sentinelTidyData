data_test <- tibble::tribble(
  ~dp, ~enr, ~dem, ~dia, ~dis, ~dth, ~enc, ~lab, ~pro, ~count,
  "NSDP",   1L,   1L,   0L,   0L,   0L,   0L,   0L,   0L,  24109,
  "NSDP",   1L,   1L,   0L,   0L,   0L,   0L,   1L,   0L,     57,
  "NSDP",   1L,   1L,   0L,   0L,   0L,   1L,   0L,   0L,      7,
  "NSDP",   1L,   1L,   0L,   0L,   0L,   1L,   0L,   1L,     25,
  "NSDP",   1L,   1L,   0L,   1L,   0L,   0L,   0L,   0L,   3421,
  "NSDP",   1L,   1L,   0L,   1L,   0L,   0L,   1L,   0L,     32,
  "NSDP",   1L,   1L,   0L,   1L,   0L,   1L,   0L,   0L,      4,
  "NSDP",   1L,   1L,   0L,   1L,   0L,   1L,   0L,   1L,      7,
  "NSDP",   1L,   1L,   1L,   0L,   0L,   1L,   0L,   0L,     23,
  "NSDP",   1L,   1L,   1L,   0L,   0L,   1L,   0L,   1L,  36160,
  "NSDP",   1L,   1L,   1L,   0L,   0L,   1L,   1L,   0L,      2,
  "NSDP",   1L,   1L,   1L,   0L,   0L,   1L,   1L,   1L,   1848,
  "NSDP",   1L,   1L,   1L,   0L,   1L,   1L,   0L,   1L,     51,
  "NSDP",   1L,   1L,   1L,   0L,   1L,   1L,   1L,   1L,      6,
  "NSDP",   1L,   1L,   1L,   1L,   0L,   1L,   0L,   0L,      3,
  "NSDP",   1L,   1L,   1L,   1L,   0L,   1L,   0L,   1L,  77310,
  "NSDP",   1L,   1L,   1L,   1L,   0L,   1L,   1L,   1L,   9717,
  "NSDP",   1L,   1L,   1L,   1L,   1L,   1L,   0L,   1L,    118,
  "NSDP",   1L,   1L,   1L,   1L,   1L,   1L,   1L,   1L,     11
)

expected_outcome <- tibble::tribble(
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

test_that("tidy_match function returns the expected outcome", {
  result <- tidy_match(data_test)
  expect_equal(result, expected_outcome)
})
