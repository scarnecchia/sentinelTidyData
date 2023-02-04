#' Convert table variables in match datasets to logicals
#'
#' Tidy the columns of data frame in such a way that the values in dp and count
#' columns are recoded to be logical, i.e. 0 becomes FALSE and 1 becomes TRUE.
#'
#' @param data a data frame
#' @return a tidied data frame
#'
#' @export
tidy_match <- function(data) {
  data %>%
    dplyr::mutate(dplyr::across(!dp & !count, ~ dplyr::recode(.x, '0' = FALSE, '1' = TRUE)))
}
