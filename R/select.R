
select_pos <- function(.x,
                       expr,
                       .include = NULL,
                       .exclude = NULL,
                       .strict = TRUE) {
  vctrs::vec_assert(.x)

  vars <- names(.x)
  if (is_null(vars)) {
    abort("Can't select within an unnamed vector.")
  }

  scoped_vars(vars)
  select_impl(.x,
    {{ expr }},
    .include = .include,
    .exclude = .exclude,
    .strict = .strict
  )
}

# Example of implementation, mainly used for unit tests
select <- function(.x, ..., .strict = TRUE) {
  idx <- select_pos(.x, c(!!!enquos(...)), .strict = .strict)
  set_names(.x[idx], names(idx))
}

select_impl <- function(.x,
                        expr,
                        .include = NULL,
                        .exclude = NULL,
                        .strict = TRUE) {
  expr <- enquo(expr)
  vars <- peek_vars()

  if (length(.include)) {
    expr <- quo(all_of(.include) | !!expr)
  }
  if (length(.exclude)) {
    expr <- quo(!!expr & !all_of(.exclude))
  }

  subclass_index_errors(
    vars_select_eval(vars, expr, .strict, data = .x)
  )
}

#' The syntax and semantics of tidyselect
#'
#' This is a technical description of the tidyselect interface.
#'
#' @section Dots, `c()`, and unary `-`:
#'
#' tidyselect functions can take dots like `dplyr::select()`, or a
#' named argument like `tidyr::pivot_longer()`. In the latter case,
#' the dots syntax is accessible via `c()`. In fact `...` syntax is
#' implemented through `c(...)` and is thus completely equivalent.
#'
#' ```
#' # There is no semantical differences between these two expressions
#' dplyr::select(mtcars, mpg, disp:am)
#' dplyr::select(mtcars, c(mpg, disp:am))
#' ```
#'
#' Dots and `c()` are syntax for:
#'
#' - Set union
#' - Set difference or complement, in combination with unary `-`
#' - Renaming variables
#'
#' Non-negative inputs are recursively joined with `union()`. The
#' precedence is left-associative, just like with boolean operators.
#' These expressions are all syntax for _set union_:
#'
#' ```
#' iris %>% select(starts_with("Sepal"), ends_with("Width"), Species)
#' iris %>% select(starts_with("Sepal") | ends_with("Width") | Species)
#' iris %>% select(union(union(starts_with("Sepal"), ends_with("Width")), 5L))
#' ```
#'
#' Unary `-` is normally syntax for _set difference_:
#'
#' ```
#' iris %>% select(starts_with("Sepal"), -ends_with("Width"), -Sepal.Length)
#' iris %>% select(setdiff(setdiff(starts_with("Sepal"), ends_with("Width")), 1L))
#' ```
#'
#' If the first `...` or `c()` input is negative, an implicit
#' `everything()` is appended. In this case, unary `-` is syntax for
#' _set complement_.
#'
#' ```
#' iris %>% select(-starts_with("Sepal"))
#' iris %>% select(everything(), -starts_with("Sepal"))
#' iris %>% select(!starts_with("Sepal"))
#' ```
#'
#' If unary `-` is used outside `...` or `c()`, it also stands for set
#' complement.
#'
#' @name tidyselect-syntax
NULL
