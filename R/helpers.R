#' Select helpers
#'
#' @description
#'
#' Tidyverse selections implement a dialect of R where operators make
#' it easy to select variables:
#'
#' - `:` for selecting a _range_ of consecutive variables.
#' - `!` for taking the complement of a set of variables.
#' - `&` and `|` for selecting the intersection or the union of two
#'   sets of variables.
#' - `c()` for combining selections.
#'
#' In addition, you can use selection helpers such as:
#' * [everything()]: Matches all variables.
#' * [last_col()]: Select last variable, possibly with an offset.
#'
#' These helpers select variables based on their names:
#' * [starts_with()]: Starts with a prefix.
#' * [ends_with()]: Ends with a suffix.
#' * [contains()]: Contains a literal string.
#' * [matches()]: Matches a regular expression.
#' * [num_range()]: Matches a numerical range like x01, x02, x03.
#'
#' These functions select variables from a character vector.
#' * [all_of()]: Matches variable names in a character vector. All
#'   names must be present, otherwise an out-of-bounds error is
#'   thrown.
#' * [any_of()]: Same as `all_of()`, except that no error is thrown
#'   for names that don't exist.
#'
#' @details
#' The order of selected columns is determined by the inputs.
#'
#' * `all_of(c("foo", "bar"))` selects `"foo"` first.
#'
#' * `c(starts_with("c"), starts_with("d"))` selects all columns
#'   starting with `"c"` first, then all columns starting with `"d"`.
#'
#' @name select_helpers
#' @examples
#' vars_select(nms, Petal.Length, Petal.Width)
#' vars_select(nms, everything())
#' vars_select(nms, last_col())
#' vars_select(nms, last_col(offset = 2))
#'
#' # With multiple matchers, the union of the matches is selected:
#' vars_select(nms, starts_with(c("Petal", "Sepal")))
#'
#' # `!` negates a selection:
#' vars_select(nms, !ends_with("Width"))
#'
#' # `&` and `|` take the intersection or the union of two selections:
#' vars_select(nms, starts_with("Petal") & ends_with("Width"))
#' vars_select(nms, starts_with("Petal") | ends_with("Width"))
#'
#' # The order of selected columns is determined from the inputs
#' vars_select(names(mtcars), starts_with("c"), starts_with("d"))
#' vars_select(names(mtcars), all_of(c("carb", "mpg")))
NULL


#' Superseded selection helpers
#'
#' `one_of()` is superseded in favour of the more precise [any_of()] and
#' [all_of()] selectors.
#'
#' @param ... One or more character vectors.
#' @param .vars A character vector of variable names. When called
#'   from inside selecting functions like [dplyr::select()] these are
#'   automatically set to the names of the table.
#'
#' @keywords internal
#' @export
one_of <- function(..., .vars = peek_vars(fn = "one_of")) {
  keep <- compact(list(...))

  bad_input <- detect_index(keep, ~ !vec_is_coercible(., chr()))
  if (bad_input) {
    type <- friendly_type_of(keep[[bad_input]])
    msg <- glue::glue("Input { bad_input } must be a vector of column names, not {type}.")
    abort(msg, "vctrs_error_incompatible_index_type")
  }

  keep <- vctrs::vec_c(!!!keep, .ptype = character())

  if (!all(keep %in% .vars)) {
    bad <- setdiff(keep, .vars)
    warn(glue("Unknown { plural(.vars) }: ", paste0("`", bad, "`", collapse = ", ")))
  }

  match_vars(keep, .vars)
}
