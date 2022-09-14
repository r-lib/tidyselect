#' tidyselect methods for custom types
#'
#' @description
#' * `tidyselect_data_proxy()` returns a data frame.
#' * `tidyselect_data_has_predicates()` returns `TRUE` or `FALSE`
#'
#' If your doesn't support predicate functions, return a 0-row data frame
#' from `tidyselect_data_proxy()` and `FALSE` from
#' `tidyselect_data_has_predicates()`.
#'
#' @param x A data-frame like object passed to [eval_select()],
#'   [eval_rename()], and friends.
#' @export
tidyselect_data_proxy <- function(x) {
  UseMethod("tidyselect_data_proxy")
}
#' @export
tidyselect_data_proxy.default <- function(x) {
  x
}


#' @rdname tidyselect_data_proxy
#' @export
tidyselect_data_has_predicates <- function(x) {
  UseMethod("tidyselect_data_has_predicates")
}
#' @export
tidyselect_data_has_predicates.default <- function(x) {
  TRUE
}
