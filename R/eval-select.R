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
#' @inheritParams rlang::args_error_context
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
#' @param allow_empty If `TRUE` (the default), it is ok for `expr` to result
#'   in an empty selection. If `FALSE`, will error if `expr` yields an empty
#'   selection.
#' @param allow_predicates If `TRUE` (the default), it is ok for `expr` to
#'   use predicates (i.e. in `where()`). If `FALSE`, will error if `expr` uses a
#'   predicate. Will automatically be set to `FALSE` if `data` does not
#'   support predicates (as determined by [tidyselect_data_has_predicates()]).
#' @param error_arg Argument names for `expr`. These
#'   are used in error messages. (You can use `"..."` if `expr = c(...)`).
#' @inheritParams rlang::args_dots_empty
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
#' # Supply `error_arg` to improve the error message in case of
#' # unexpected empty selection:
#' select_not_empty <- function(x, cols) {
#'   eval_select(expr = enquo(cols), data = x, allow_empty = FALSE, error_arg = "cols")
#' }
#' try(select_not_empty(mtcars, cols = starts_with("vs2")))
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
                        allow_rename = TRUE,
                        allow_empty = TRUE,
                        allow_predicates = TRUE,
                        error_arg  = NULL,
                        error_call = caller_env()) {
  check_dots_empty()

  allow_predicates <- allow_predicates && tidyselect_data_has_predicates(data)
  data <- tidyselect_data_proxy(data)

  eval_select_impl(
    data,
    names(data),
    as_quosure(expr, env),
    include = include,
    exclude = exclude,
    strict = strict,
    name_spec = name_spec,
    allow_rename = allow_rename,
    allow_empty = allow_empty,
    allow_predicates = allow_predicates,
    error_arg = error_arg,
    error_call = error_call
  )
}

eval_select_impl <- function(x,
                             names,
                             expr,
                             include = NULL,
                             exclude = NULL,
                             strict = TRUE,
                             name_spec = NULL,
                             uniquely_named = NULL,
                             allow_rename = TRUE,
                             allow_empty = TRUE,
                             allow_predicates = TRUE,
                             type = "select",
                             error_arg = NULL,
                             error_call = caller_env()) {
  if (!is_null(x)) {
    vctrs::vec_assert(x)
  }
  if (is_null(names)) {
    cli::cli_abort("Can't select within an unnamed vector.", call = error_call)
  }

  # Put vars in scope and peek validated vars
  local_vars(names)
  vars <- peek_vars()

  local_data(x)

  with_subscript_errors(
    out <- vars_select_eval(
      vars,
      expr,
      strict = strict,
      data = x,
      name_spec = name_spec,
      uniquely_named = uniquely_named,
      allow_rename = allow_rename,
      allow_empty = allow_empty,
      allow_predicates = allow_predicates,
      type = type,
      error_arg = error_arg,
      error_call = error_call
    ),
    type = type
  )

  if (length(include) > 0) {
    if (!is.character(include)) {
      cli::cli_abort("{.arg include} must be a character vector.", call = error_call)
    }

    missing <- setdiff(include, names)
    if (length(missing) > 0) {
      cli::cli_abort(c(
        "{.arg include} must only include variables found in {.arg data}.",
        i = "Unknown variables: {.and {missing}}"
      ), call = error_call)
    }

    to_include <- vctrs::vec_match(include, names)
    names(to_include) <- names[to_include]

    out <- c(to_include[!to_include %in% out], out)
  }

  if (length(exclude) > 0) {
    if (!is.character(exclude)) {
      cli::cli_abort("{.arg exclude} must be a character vector.", call = error_call)
    }

    to_exclude <- vctrs::vec_match(intersect(exclude, names), names)
    out <- out[!out %in% to_exclude]
  }

  out
}

# Example implementation mainly used for unit tests
select <- function(.x,
                   ...,
                   .strict = TRUE,
                   error_call = caller_env()) {
  pos <- eval_select(
    expr(c(...)),
    .x,
    strict = .strict,
    error_call = error_call
  )
  set_names(.x[pos], names(pos))
}
