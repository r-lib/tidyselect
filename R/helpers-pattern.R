#' Select variables that match a pattern
#'
#' @description
#'
#' These [selection helpers][language] match variables according
#' to a given pattern.
#'
#' * [starts_with()]: Starts with an exact prefix.
#' * [ends_with()]: Ends with an exact suffix.
#' * [contains()]: Contains a literal string.
#' * [matches()]: Matches a regular expression.
#' * [num_range()]: Matches a numerical range like x01, x02, x03.
#'
#' @param match A character vector. If length > 1, the union of the
#'   matches is taken.
#'
#'   For `starts_with()`, `ends_with()`, and `contains()` this is an exact
#'   match. For `matches()` this is a regular expression, and can be a
#'   stringr pattern.
#' @param ignore.case If `TRUE`, the default, ignores case when matching
#'   names.
#' @param vars A character vector of variable names. If not supplied,
#'   the variables are taken from the current selection context (as
#'   established by functions like `select()` or `pivot_longer()`).
#'
#' @section Examples:
#'
#' ```{r, child = "man/rmd/setup.Rmd"}
#' ```
#'
#' Selection helpers can be used in functions like `dplyr::select()`
#' or `tidyr::pivot_longer()`. Let's first attach the tidyverse:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' library(tidyverse)
#'
#' # For better printing
#' iris <- as_tibble(iris)
#' ```
#'
#' `starts_with()` selects all variables matching a prefix and
#' `ends_with()` matches a suffix:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(starts_with("Sepal"))
#'
#' iris %>% select(ends_with("Width"))
#' ```
#'
#' You can supply multiple prefixes or suffixes. Note how the order of
#' variables depends on the order of the suffixes and prefixes:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(starts_with(c("Petal", "Sepal")))
#'
#' iris %>% select(ends_with(c("Width", "Length")))
#' ```
#'
#' `contains()` selects columns whose names contain a word:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(contains("al"))
#' ```
#'
#' `starts_with()`, `ends_with()`, and `contains()` do not use regular expressions. To select with a
#' regexp use `matches()`:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' # [pt] is matched literally:
#' iris %>% select(contains("[pt]al"))
#'
#' # [pt] is interpreted as a regular expression
#' iris %>% select(matches("[pt]al"))
#' ```
#'
#' `starts_with()` selects all variables starting with a prefix. To
#' select a range, use `num_range()`. Compare:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' billboard %>% select(starts_with("wk"))
#'
#' billboard %>% select(num_range("wk", 10:15))
#' ```
#'
#' @seealso `r rd_helpers_seealso()`
#' @export
starts_with <- function(match,
                        ignore.case = TRUE,
                        vars = NULL) {
  check_match(match)
  vars <- vars %||% peek_vars(fn = "starts_with")

  if (ignore.case) {
    vars <- tolower(vars)
    match <- tolower(match)
  }

  flat_map_int(match, starts_with_impl, vars)
}
starts_with_impl <- function(x, vars) {
  n <- nchar(x)
  which_vars(x, substr(vars, 1, n))
}

#' @rdname starts_with
#' @export
ends_with <- function(match,
                      ignore.case = TRUE,
                      vars = NULL) {
  check_match(match)
  vars <- vars %||% peek_vars(fn = "ends_with")

  if (ignore.case) {
    vars <- tolower(vars)
    match <- tolower(match)
  }

  length <- nchar(vars)
  flat_map_int(match, ends_with_impl, vars, length)
}
ends_with_impl <- function(x, vars, length) {
  n <- nchar(x)
  which_vars(x, substr(vars, pmax(1, length - n + 1), length))
}

#' @rdname starts_with
#' @export
contains <- function(match,
                     ignore.case = TRUE,
                     vars = NULL) {
  check_match(match)
  vars <- vars %||% peek_vars(fn = "contains")

  if (ignore.case) {
    vars <- tolower(vars)
    match <- tolower(match)
  }

  flat_map_int(match, grep_vars, vars, fixed = TRUE)
}

#' @rdname starts_with
#' @param perl Should Perl-compatible regexps be used?
#' @export
matches <- function(match,
                    ignore.case = TRUE,
                    perl = TRUE,
                    vars = NULL) {
  check_match(match)
  vars <- vars %||% peek_vars(fn = "matches")

  if (inherits(match, "pattern") || inherits(match, "stringr_pattern")) {
    check_installed("stringr")
    if (!missing(ignore.case)) {
      cli::cli_abort("{.arg ignore.case} not supported when {.arg match} is a {.pkg stringr} pattern.")
    }
    if (!missing(perl)) {
      cli::cli_abort("{.arg perl} not supported when {.arg match} is a {.pkg stringr} pattern.")
    }

    # no [ or [[ methods for pattern objects
    if (length(match) > 1) {
      cli::cli_abort("{.pkg stringr} patterns must be length 1.")
    }

    stringr::str_which(vars, match)
  } else {
    flat_map_int(match, grep_vars, vars, ignore.case = ignore.case, perl = perl)
  }
}

#' @rdname starts_with
#' @param prefix,suffix A prefix/suffix added before/after the numeric range.
#' @param range A sequence of integers, like `1:5`.
#' @param width Optionally, the "width" of the numeric range. For example,
#'   a range of 2 gives "01", a range of three "001", etc.
#' @inheritParams rlang::args_dots_empty
#' @param cross Whether to take the cartesian product of `prefix`, `range`, and `suffix`.
#'   If `FALSE`, the default, these arguments are recycled using [tidyverse rules][vctrs::vector_recycling_rules].
#' @export
num_range <- function(prefix,
                      range,
                      suffix = "",
                      width = NULL,
                      ...,
                      cross = FALSE,
                      vars = NULL) {
  check_dots_empty()
  check_bool(cross)
  check_number_whole(width, allow_null = TRUE)

  vars <- vars %||% peek_vars(fn = "num_range")

  if (cross) {
    args <- vctrs::vec_expand_grid(prefix = prefix, range = range, suffix = suffix, .error_call = current_env())
  } else {
    args <- vctrs::vec_recycle_common(prefix = prefix, range = range, suffix = suffix)
  }
  prefix <- args$prefix
  range <- args$range
  suffix <- args$suffix

  if (!is_null(width)) {
    range <- sprintf(paste0("%0", width, "d"), range)
  }

  match_vars(paste0(prefix, range, suffix), vars)
}

check_match <- function(match) {
  if (!is_character(match) || !all(nzchar(match))) {
    cli::cli_abort("{.arg match} must be a character vector of non empty strings.")
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
