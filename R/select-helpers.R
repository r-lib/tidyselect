#' Select helpers
#'
#' These functions allow you to select variables based on their names.
#' * [starts_with()]: Starts with a prefix.
#' * [ends_with()]: Ends with a suffix.
#' * [contains()]: Contains a literal string.
#' * [matches()]: Matches a regular expression.
#' * [num_range()]: Matches a numerical range like x01, x02, x03.
#' * `all_of()`: Matches variable names in a character vector. All
#'   names must be present, otherwise an out-of-bounds error is
#'   thrown.
#' * `any_of()`: Same as `all_of()`, except that no error is thrown
#'   for names that don't exist.
#' * `everything()`: Matches all variables.
#' * `last_col()`: Select last variable, possibly with an offset.
#'
#' In selection context you can also use these operators:
#'
#' - `":"` for selecting a range of consecutive variables.
#' - `"c"` for selecting the union of sets of variables.
#'
#' The boolean operators were more recently overloaded to operate on
#' selections:
#'
#' - `"!"` for taking the complement of a set of variables.
#' - `"&"` and `"|"` for selecting the intersection or the union of two
#'   sets of variables.
#'
#' @param perl Should Perl-compatible regexps be used?
#' @param vars A character vector of variable names. When called
#'   from inside selecting functions like [dplyr::select()] these are
#'   automatically set to the names of the table.
#' @return An integer vector giving the position of the matched variables.
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
#' # `all_of()` selects the variables in a character vector:
#' vars <- c("Petal.Length", "Petal.Width")
#' vars_select(nms, all_of(vars))
#'
#' # Whereas `all_of()` is strict, `any_of()` allows missing
#' # variables.
#' try(vars_select(nms, all_of(c("Species", "Genres"))))
#' vars_select(nms, any_of(c("Species", "Genres")))
#'
#' # The lax variant is especially useful to make sure a variable is
#' # selected out:
#' vars_select(nms, -any_of(c("Species", "Genres")))
#'
#' # The order of selected columns is determined from the inputs
#' vars_select(names(mtcars), starts_with("c"), starts_with("d"))
#' vars_select(names(mtcars), all_of(c("carb", "mpg")))
NULL

#' @rdname select_helpers
#' @param x An index vector of names or locations.
#' @inheritParams ellipsis::dots_empty
#' @export
all_of <- function(x) {
  if (is.function(x)) {
    # Trigger bad type error
    vctrs::vec_as_location(x, 0L)
    abort("Internal error: `all_of()` should have failed sooner")
  }

  x
}

#' @rdname select_helpers
#' @export
any_of <- function(x,
                   ...,
                   vars = peek_vars(fn = "any_of")) {
  ellipsis::check_dots_empty()
  as_indices_impl(x, vars = vars, strict = FALSE)
}

#' @export
#' @rdname select_helpers
everything <- function(vars = peek_vars(fn = "everything")) {
  seq_along(vars)
}


#' @export
#' @param offset Set it to `n` to select the nth var from the end.
#' @rdname select_helpers
last_col <- function(offset = 0L, vars = peek_vars(fn = "last_col")) {
  stopifnot(is_integerish(offset))
  n <- length(vars)

  if (offset && n <= offset) {
    abort(glue("`offset` must be smaller than the number of { plural(vars) }"))
  } else if (n == 0) {
    abort(glue("Can't select last { singular(vars) } when input is empty"))
  } else {
    n - as.integer(offset)
  }
}

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
