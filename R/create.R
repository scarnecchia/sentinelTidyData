#' Get counts of utilizing and non-utilizing PatIDs.
#'
#' Creates a table displaying the counts of PatIDs found in both the DEM and ENR
#' tables and returns TRUE if those PatIDs are found in any of the DIA, DIS,
#' DTH, ENC, PRO or only one of the DEM & ENR tables.
#'
#'
#' @param data Data frame containing the variables `dem`, `enr`, and `count`.
#' @param utilization.tables Character vector of utilization tables to be used
#'   in the calculation of `utilizing`.
#' @param cols Columns to group by in the calculation of utilization summary.
#'
#' @return A [tibble::tibble()]
#'
#' @examples
#' create_utilization(data = mydata, utilization.tables = c("DIA", "DIS", "DTH", "ENC", "PRO"))
#' create_utilization(data = mydata, utilization.tables = c("DIA", "DIS", "DTH", "ENC", "PRO"), cols = c("dp","jurisdiction"))
#'
#' @export
create_utilization <-
  function(data,
           utilization.tables = NULL,
           cols = NULL) {
    if (is.null(utilization.tables)) {
      utilization.tables <- c("DIA", "DIS", "DTH", "ENC", "PRO")
    }

    .vars <- tolower(utilization.tables)

    stopifnot("Dataframe does not contain columns `dem`, `enr`, or `count`." = {
      rlang::has_name(data, "dem")
      rlang::has_name(data, "enr")
      rlang::has_name(data, "count")
    })

    stopifnot("Dataframe columns `dem` and `enr` must be of type logical" = {
      rlang::is_logical(data[['dem']])
      rlang::is_logical(data[['enr']])
    })

    data %>%
      dplyr::rowwise() %>%
      dplyr::mutate(util_tab = dplyr::if_any(dplyr::contains(.vars), isTRUE)) %>%
      dplyr::mutate(enrolled = dplyr::if_all(c(dem, enr), isTRUE)) %>%
      dplyr::mutate(utilizing = dplyr::if_all(c(util_tab, enrolled), isTRUE)) %>%
      dplyr::ungroup() %>% {
        if (is.null(cols)) {
          dplyr::group_by(., utilizing)
        } else {
          dplyr::group_by(., dplyr::pick({{ cols }}), utilizing)
        }
      } %>%
      dplyr::summarise(count = sum(count)) %>%
      dplyr::ungroup() %>%
      tibble::as_tibble()
  }


#' Get counts of orphaned and unorphaned EncounterIDs.
#'
#' @description Creates a table displaying the counts of EncounterIDs found the ENC table,
#' and returns TRUE if those EncounterIDs have a match in any or both of the DIA
#' and PRO tables, and FALSE if they do not.
#'
#' @param data Data frame containing the variables `enc`, and `count`.
#' @param linked.tables Character vector of tables to be used
#'   in the calculation of `matched`.
#' @param cols Columns to group by in the calculation of utilization summary.
#'
#' @return A [tibble::tibble()]
#'
#' @export
create_orphan_enc <- function(data,
                               linked.tables = NULL,
                               cols = NULL) {

  if (is.null(linked.tables)) {
    linked.tables <- c("DIA", "PRO")
  }
  .vars <- tolower(linked.tables)

  stopifnot("Dataframe does not contain columns `enc` or `count`." = {
    rlang::has_name(data, "enc")
    rlang::has_name(data, "count")
  })

  stopifnot("Dataframe column `enc` must be of type logical" = {
    rlang::is_logical(data[['enc']])
  })

  data %>%
    dplyr::rowwise() %>%
    dplyr::mutate(util_tab = dplyr::if_any(dplyr::contains(.vars), isTRUE)) %>%
    dplyr::mutate(matched = dplyr::if_all(c(util_tab, enc), isTRUE)) %>%
    dplyr::ungroup() %>% {
      if (is.null(cols)) {
        dplyr::group_by(., matched)
      } else {
        dplyr::group_by(., dplyr::pick({{ cols }}), matched)
      }
    } %>%
    dplyr::summarise(count = sum(count)) %>%
    dplyr::ungroup() %>%
    tibble::as_tibble()
}



