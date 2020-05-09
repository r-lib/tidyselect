#' Evaluate an expression with tidyselect semantics
#'
#' @description
#'
#' `eval_select()` and `eval_rename()` evaluate defused R code
#' (i.e. quoted expressions) according to the special rules of the
#' [tidyselect
#' syntax](https://tidyselect.r-lib.org/articles/syntax.html). They
#' power functions like `dplyr::select()`, `dplyr::rename()`, or
#' `tidyr::pivot_longer()`.
#'
#' See the [Get
#' started](https://tidyselect.r-lib.org/articles/tidyselect.html)
#' vignette to learn how to use `eval_select()` and `eval_rename()` in
#' your packages.
#'
#' @param expr Defused R code describing a selection according to the
#'   tidyselect syntax.
#' @param data A named list, data frame, or atomic vector.
#'   Technically, `data` can be any vector with `names()` and `"[["`
#'   implementations.
#' @param env The environment in which to evaluate `expr`. Discarded
#'   if `expr` is a [quosure][rlang::enquo].
#' @param include,exclude Character vector of column names to always
#'   include or exclude from the selection.
#' @param strict If `TRUE`, out-of-bounds errors are thrown if `expr`
#'   attempts to select or rename a variable that doesn't exist. If
#'   `FALSE`, failed selections or renamings are ignored.
#' @param name_spec A name specification describing how to combine or
#'   propagate names. This is used only in case nested `c()`
#'   expressions like `c(foo = c(bar = starts_with("foo")))`. See the
#'   `name_spec` argument of [vctrs::vec_c()] for a description of
#'   valid name specs.
#' @param allow_rename If `TRUE` (the default), the renaming syntax
#'   `c(foo = bar)` is allowed. If `FALSE`, it causes an error. This
#'   is useful to implement purely selective behaviour.
#' @inheritParams ellipsis::dots_empty
#'
#' @return A named vector of numeric locations, one for each of the
#'   selected elements.
#'
#'   The names are normally the same as in the input data, except when
#'   the user supplied named selections with `c()`. In the latter
#'   case, the names reflect the new names chosen by the user.
#'
#'   A given element may be selected multiple times under different
#'   names, in which case the vector might contain duplicate
#'   locations.
#'
#' @details
#'
#' The select and rename variants take the same types of inputs and
#' have the same type of return value. However `eval_rename()` has a
#' few extra constraints. It requires named inputs, and will fail if a
#' data frame column is renamed to another existing column name. See
#' the [selecting versus
#' renaming](https://tidyselect.r-lib.org/articles/syntax.html)
#' section in the syntax vignette for a description of the
#' differences.
#'
#' @seealso <https://tidyselect.r-lib.org/articles/syntax.html> or
#'   `vignette("syntax", package = "tidyselect")` for a technical
#'   description of the rules of evaluation.
#' @examples
#' library(rlang)
#'
#' # Interpret defused code as selection:
#' x <- expr(mpg:cyl)
#' eval_select(x, mtcars)
#'
#' # Interpret defused code as a renaming selection. All inputs must
#' # be named within `c()`:
#' try(eval_rename(expr(mpg), mtcars))
#' eval_rename(expr(c(foo = mpg)), mtcars)
#'
#'
#' # Within a function, use `enquo()` to defuse one argument:
#' my_function <- function(x, expr) {
#'   eval_select(enquo(expr), x)
#' }
#'
#' # If your function takes dots, evaluate a defused call to `c(...)`
#' # with `expr(c(...))`:
#' my_function <- function(.x, ...) {
#'   eval_select(expr(c(...)), .x)
#' }
#'
#' # If your function takes dots and a named argument, use `{{ }}`
#' # inside the defused expression to tunnel it inside the tidyselect DSL:
#' my_function <- function(.x, .expr, ...) {
#'   eval_select(expr(c({{ .expr }}, ...)), .x)
#' }
#'
#' # Note that the trick above works because `expr({{ arg }})` is the
#' # same as `enquo(arg)`.
#'
#'
#' # The evaluators return a named vector of locations. Here are
#' # examples of using these location vectors to implement `select()`
#' # and `rename()`:
#' select <- function(.x, ...) {
#'   pos <- eval_select(expr(c(...)), .x)
#'   set_names(.x[pos], names(pos))
#' }
#' rename <- function(.x, ...) {
#'   pos <- eval_rename(expr(c(...)), .x)
#'   names(.x)[pos] <- names(pos)
#'   .x
#' }
#'
#' select(mtcars, mpg:cyl)
#' rename(mtcars, foo = mpg)
#' @export
eval_select <- function(expr,
                        data,
                        env = caller_env(),
                        ...,
                        include = NULL,
                        exclude = NULL,
                        strict = TRUE,
                        name_spec = NULL,
                        allow_rename = TRUE) {
  ellipsis::check_dots_empty()
  eval_select_impl(
    data,
    names(data),
    as_quosure(expr, env),
    include = include,
    exclude = exclude,
    strict = strict,
    name_spec = name_spec,
    allow_rename = allow_rename
  )
}

# Caller must put vars in scope
eval_select_impl <- function(x,
                             names,
                             expr,
                             include = NULL,
                             exclude = NULL,
                             strict = TRUE,
                             name_spec = NULL,
                             uniquely_named = NULL,
                             allow_rename = TRUE,
                             type = "select") {
  if (!is_null(x)) {
    vctrs::vec_assert(x)
  }
  if (is_null(names)) {
    abort("Can't select within an unnamed vector.")
  }

  # Put vars in scope and peek validated vars
  local_vars(names)
  vars <- peek_vars()

  local_data(x)

  if (length(include)) {
    expr <- quo(all_of(include) | !!expr)
  }
  if (length(exclude)) {
    expr <- quo(!!expr & !any_of(exclude))
  }

  with_subscript_errors(
    vars_select_eval(
      vars,
      expr,
      strict,
      data = x,
      name_spec = name_spec,
      uniquely_named = uniquely_named,
      allow_rename = allow_rename,
      type = type
    ),
    type = type
  )
}

# Example implementation mainly used for unit tests
select <- function(.x, ..., .strict = TRUE) {
  pos <- eval_select(expr(c(...)), .x, strict = .strict)
  set_names(.x[pos], names(pos))
}
