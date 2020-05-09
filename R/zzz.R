#' List of selection helpers
#'
#' This list contains all selection helpers exported in tidyselect. It
#' was useful when you wanted to embed the helpers in your API without
#' having to track addition of new helpers in tidyselect. However the
#' selection helpers are now always embedded in the DSL.
#'
#' @export
#' @keywords internal
#' @examples
#' # You can easily embed the helpers by burying them in the scopes of
#' # input quosures. For this example we need an environment where
#' # tidyselect is not attached:
#' local(envir = baseenv(), {
#'   vars <- c("foo", "bar", "baz")
#'   helpers <- tidyselect::vars_select_helpers
#'
#'   my_select <- function(...) {
#'     quos <- rlang::quos(...)
#'     quos <- lapply(quos, rlang::env_bury, !!! helpers)
#'
#'     tidyselect::vars_select(vars, !!! quos)
#'   }
#'
#'   # The user can now call my_select() with helpers without having
#'   # to attach tidyselect:
#'   my_select(starts_with("b"))
#' })
vars_select_helpers <- list(
  starts_with = starts_with,
  ends_with = ends_with,
  contains = contains,
  matches = matches,
  num_range = num_range,
  one_of = one_of,
  everything = everything,
  last_col = last_col,
  all_of = all_of,
  any_of = any_of
)
