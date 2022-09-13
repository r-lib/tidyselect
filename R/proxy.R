#' tidyselect methods for custom types
#'
#' * `tidyselect_data_proxy()` should return a 0-row data frame.
#' * `tidyselect_data_supports_predicates()` should return `FALSE` if
#'    `tidyselect_data_proxy()` doesn't return actual types.
#'
#' @param x A data-frame like object passed to `[eval_select()]`,
#'   `eval_rename()`, and friends.
#' @export
tidyselect_data_proxy <- function(x) {
  UseMethod("tidyselect_data_proxy")
}
#' @export
tidyselect_data_proxy.default <- function(x) x


#' @rdname tidyselect_data_proxy
#' @export
tidyselect_data_supports_predicates <- function(x) {
  UseMethod("tidyselect_data_supports_predicates")
}
#' @export
tidyselect_data_supports_predicates.default <- function(x) {
  TRUE
}
