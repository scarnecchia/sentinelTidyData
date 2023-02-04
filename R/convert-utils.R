#' Converts and renames QA data `[code]` and `[code]_codetype` columns to `code`
#' and `codecat` in a data frame
#'
#' @param data a data frame
#' @param codecat a character vector of codecat values (default:
#'   c("Rx","rx","RX","PX","Px","px","DX","Dx","dx"))
#' @return a data frame with renamed `codecat` column
#' @export
#'
convert_codecat <-
  function(data,
           codecat = c("Rx", "rx", "RX", "PX", "Px", "px", "DX", "Dx", "dx")) {

    rlang::arg_match(codecat)
    .code <- tolower(codecat)
    .codecat <- paste0(.code, "_codetype")

    data %>%
      dplyr::rename(code = dplyr::all_of(.code),
                    codecat =  dplyr::all_of(.codecat)) %>%
      dplyr::mutate(codetype = .code, .before = codecat)

  }

#' Subset a list based on search term
#'
#' @param .x A list
#' @param search_term The search term to use for subsetting the list
#' @return A subset of the input list, containing only elements whose names
#'   contain the search term
#' @export
#'
subset_list <- function(.x, search_term) {
  .x[stringr::str_which(names(.x), search_term)]
}

#' Subset a list based on tabid term
#'
#' @param .x A list
#' @param tabid The three letter tabid used to subset the list
#' @return A subset of the input list, containing only elements whose names
#'   start with the search term
#' @export
#'
subset_tabid <- function(.x, tabid) {
  .tabid <- tolower(tabid)
  .tabid <- paste0("^", .tabid)
  .x[stringr::str_which(names(.x), .tabid)]
}

