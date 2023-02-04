#' Load data from a SAS file
#'
#' @param source The source folder of the file
#' @param file The name of the file
#' @return A data frame read from the SAS file
#' @export
#'
load_data <- function(source, file=NULL) {

  if (rlang::is_null(file)) {
    file <- fs::dir_ls(source, type = "file", glob = "*.sas7bdat") %>%
      get_file_names()
  }

  .x <- fs::path(source, file, ext = "sas7bdat") %>%
    rlang::set_names(., get_file_names) %>%
    purrr::map(purrr::safely(haven::read_sas))

  safely_errors(.x)
  return(.x)
}

get_file_names <- function(.x) {
  .x %>%
    fs::path_file() %>%
    fs::path_ext_remove()
}
