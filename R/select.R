
select_pos <- function(.x,
                       expr,
                       .include = NULL,
                       .exclude = NULL,
                       .strict = TRUE,
                       name_spec = NULL) {
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
    .strict = .strict,
    name_spec = name_spec
  )
}

# Example of implementation, mainly used for unit tests
select <- function(.x, ..., .strict = TRUE) {
  pos <- select_pos(.x, c(!!!enquos(...)), .strict = .strict)
  set_names(.x[pos], names(pos))
}

# Caller must put vars in scope
select_impl <- function(.x,
                        expr,
                        .include = NULL,
                        .exclude = NULL,
                        .strict = TRUE,
                        name_spec = NULL,
                        uniquely_named = NULL) {
  expr <- enquo(expr)
  vars <- peek_vars()

  if (length(.include)) {
    expr <- quo(all_of(.include) | !!expr)
  }
  if (length(.exclude)) {
    expr <- quo(!!expr & !all_of(.exclude))
  }

  subclass_index_errors(
    vars_select_eval(
      vars,
      expr,
      .strict,
      data = .x,
      name_spec = name_spec,
      uniquely_named = uniquely_named
    )
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
#'
#' @section Renaming variables:
#'
#' When named inputs are provided in `...` or `c()`, the selection is
#' renamed. If the inputs are already named, the outer and inner names
#' are pasted together with a `...` separator. Otherwise the outer
#' names is propagated to the selected elements according to the
#' following rules:
#'
#' - With data frames, a numeric suffix is appended because columns
#'   must be uniquely named.
#'
#' - With normal vectors, the name is simply assigned to all selected
#'   inputs.
#'
#' Unnamed elements match any names:
#'
#' - `a | c(foo = a)` is equivalent to `c(foo = a)`.
#' - `a & c(foo = a)` is equivalent to `c(foo = a)`.
#' - `c(foo = a) & c(bar = a)` is equivalent to `c()`.
#' - `c(foo = a) | c(bar = a)` is equivalent to `c(foo = a, bar = a)`.
#'
#' Because unnamed elements match any named ones, it is possible to
#' select multiple elements and rename one of them:
#'
#' ```
#' select(iris, starts_with("Sepal"), foo = Sepal.Width)
#' ```
#'
#' @name tidyselect-syntax
NULL
