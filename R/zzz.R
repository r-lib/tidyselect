#' List of selection helpers
#'
#' This list contains all selection helpers exported in tidyselect. It
#' was useful when you wanted to embed the helpers in your API without
#' having to track addition of new helpers in tidyselect. However the
#' selection helpers are now always embedded in the DSL.
#'
#' @export
#' @keywords internal
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
  any_of = any_of,
  where = where
)
