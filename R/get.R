#' Load SAS data files into R
#'
#' @description Safely load SAS7BDAT data files into R, either the entire folder
#'   specified by `source` or a specified vector of files `file`. The loaded
#'   data is returned as a list of [data.frames()]. This function uses
#'   [purrr::safely()] to ensure it always succeeds. It returns a list with
#'   components `result` and `error`. Results should be accessed with
#'   `purrr::transpose(.x)[["error"]]`
#'
#' @param source A character string specifying the directory where the SAS data
#'   files are located.
#' @param file A character string specifying the name of the SAS data file to be
#'   loaded. If `NULL`, all `*.sas7bdat` files in the `source` directory are
#'   loaded.
#' @return A list of [data.frames()].
#' @importFrom purrr map safely
#' @importFrom rlang set_names is_null
#' @importFrom haven read_sas
#' @importFrom fs dir_ls path
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
