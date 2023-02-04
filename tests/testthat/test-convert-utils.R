data_test <- tibble::tribble(
  ~dp, ~dx_codetype,    ~dx, ~specialty, ~count,
  "NSDP",         "09", "0010",        99L,     1L,
  "NSDP",         "09", "0019",         NA,     1L
)

expected_outcome <- tibble::tribble(
  ~dp, ~codetype, ~codecat,  ~code, ~specialty, ~count,
  "NSDP",      "dx",     "09", "0010",        99L,     1L,
  "NSDP",      "dx",     "09", "0019",         NA,     1L
)

test_that("convert_codecat function returns the expected outcome", {
  result <- convert_codecat(data_test, codecat="dx")
  expect_equal(result, expected_outcome)
})
