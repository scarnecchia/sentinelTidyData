#' Detect and print errors returned by an invocation of [purrr::safely()]
#'
#' @param .x A list containing the results of an invocation of [purrr::safely()]
#' @export
safely_errors <- function(.x) {

  .check <- purrr::transpose(.x)[["error"]]
  .check <- purrr::simplify(.check)

  if (isTRUE(length(.check) > 1)) {
    message("Errors detected, please review:")
    .error <- purrr::transpose(.x)[["error"]]
    purrr::map(.error, message, appendLF = TRUE)

    message(paste("Depending on the error", names(.x),"may contain valid outputs. Please review."))

  } else {
    message("No errors detected")
  }
}
