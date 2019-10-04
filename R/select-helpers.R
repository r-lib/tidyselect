#' Select helpers
#'
#' These functions allow you to select variables based on their names.
#' * `starts_with()`: Starts with a prefix.
#' * `ends_with()`: Ends with a suffix.
#' * `contains()`: Contains a literal string.
#' * `matches()`: Matches a regular expression.
#' * `num_range()`: Matches a numerical range like x01, x02, x03.
#' * `one_of()`: Matches variable names in a character vector.
#' * `everything()`: Matches all variables.
#' * `last_col()`: Select last variable, possibly with an offset.
#'
#' @param match A string.
#' @param ignore.case If `TRUE`, the default, ignores case when matching
#'   names.
#' @param perl Should Perl-compatible regexps be used?
#' @param vars,.vars A character vector of variable names. When called
#'   from inside selecting functions like [dplyr::select()] these are
#'   automatically set to the names of the table.
#' @name select_helpers
#' @return An integer vector giving the position of the matched variables.
#'
#' @details
#'
#' The order of selected columns is determined by the inputs.
#'
#' * `one_of(c("foo", "bar"))` selects `"foo"` first.
#'
#' * `c(starts_with("c"), starts_with("d"))` selects all columns
#'   starting with `"c"` first, then all columns starting with `"d"`.
#'
#' @examples
#' nms <- names(iris)
#' vars_select(nms, starts_with("Petal"))
#' vars_select(nms, ends_with("Width"))
#' vars_select(nms, contains("etal"))
#' vars_select(nms, matches(".t."))
#' vars_select(nms, Petal.Length, Petal.Width)
#' vars_select(nms, everything())
#' vars_select(nms, last_col())
#' vars_select(nms, last_col(offset = 2))
#'
#' vars <- c("Petal.Length", "Petal.Width")
#' vars_select(nms, one_of(vars))
#'
#' # The order of selected columns is determined from the inputs
#' vars_select(names(mtcars), starts_with("c"), starts_with("d"))
#' vars_select(names(mtcars), one_of(c("carb", "mpg")))
NULL

#' @export
#' @rdname select_helpers
starts_with <- function(match, ignore.case = TRUE, vars = peek_vars()) {
  stopifnot(is_string(match), !is.na(match), nchar(match) > 0)

  if (ignore.case) match <- tolower(match)
  n <- nchar(match)

  if (ignore.case) vars <- tolower(vars)
  which_vars(match, substr(vars, 1, n))
}

#' @export
#' @rdname select_helpers
ends_with <- function(match, ignore.case = TRUE, vars = peek_vars()) {
  stopifnot(is_string(match), !is.na(match), nchar(match) > 0)

  if (ignore.case) match <- tolower(match)
  n <- nchar(match)

  if (ignore.case) vars <- tolower(vars)
  length <- nchar(vars)

  which_vars(match, substr(vars, pmax(1, length - n + 1), length))
}

#' @export
#' @rdname select_helpers
contains <- function(match, ignore.case = TRUE, vars = peek_vars()) {
  stopifnot(is_string(match), nchar(match) > 0)

  if (ignore.case) {
    vars <- tolower(vars)
    match <- tolower(match)
  }
  grep_vars(match, vars, fixed = TRUE)
}

#' @export
#' @rdname select_helpers
matches <- function(match, ignore.case = TRUE, perl = FALSE, vars = peek_vars()) {
  stopifnot(is_string(match), nchar(match) > 0)

  grep_vars(match, vars, ignore.case = ignore.case, perl = perl)
}

#' @export
#' @rdname select_helpers
#' @param prefix A prefix that starts the numeric range.
#' @param range A sequence of integers, like `1:5`.
#' @param width Optionally, the "width" of the numeric range. For example,
#'   a range of 2 gives "01", a range of three "001", etc.
num_range <- function(prefix, range, width = NULL, vars = peek_vars()) {
  if (!is_null(width)) {
    range <- sprintf(paste0("%0", width, "d"), range)
  }
  match_vars(paste0(prefix, range), vars)
}

#' @export
#' @rdname select_helpers
#' @param ... One or more character vectors.
one_of <- function(..., .vars = peek_vars()) {
  keep <- compact(list(...))

  bad_input <- detect_index(keep, ~ !vec_is_coercible(., chr()))
  if (bad_input) {
    type <- friendly_type_of(keep[[bad_input]])
    msg <- glue::glue("Input { bad_input } must be a vector of column names, not {type}.")
    abort(msg, "tidyselect_error_incompatible_index_type")
  }

  keep <- vctrs::vec_c(!!!keep, .ptype = character())

  if (!all(keep %in% .vars)) {
    bad <- setdiff(keep, .vars)
    warn(glue("Unknown { plural(.vars) }: ", paste0("`", bad, "`", collapse = ", ")))
  }

  match_vars(keep, .vars)
}

#' @export
#' @rdname select_helpers
everything <- function(vars = peek_vars()) {
  seq_along(vars)
}


#' @export
#' @param offset Set it to `n` to select the nth var from the end.
#' @rdname select_helpers
last_col <- function(offset = 0L, vars = peek_vars()) {
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

match_vars <- function(needle, haystack) {
  if (vctrs::vec_duplicate_any(haystack)) {
    x <- map(needle, ~ which(. == haystack))
    x <- vctrs::vec_c(!!!x)
  } else {
    x <- match(needle, haystack)
    x[!is.na(x)]
  }
}

grep_vars <- function(needle, haystack, ...) {
  grep(needle, haystack, ...)
}

which_vars <- function(needle, haystack) {
  which(needle == haystack)
}


#' List of selection helpers
#'
#' This list contains all selection helpers exported in tidyselect. It
#' is useful when you want to embed the helpers in your API without
#' having to track addition of new helpers in tidyselect.
#'
#' @export
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
  last_col = last_col
)
