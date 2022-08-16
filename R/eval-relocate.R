#' Evaluate an expression to relocate variables
#'
#' @description
#' `eval_relocate()` is a variant of [eval_select()] that moves a selection to
#' a new location. Either `before` or `after` can be provided to specify where
#' to move the selection to. This powers `dplyr::relocate()`.
#'
#' @inheritParams eval_select
#'
#' @param before,after Defused R code describing a selection according to the
#'   tidyselect syntax. The selection represents the destination of the
#'   selection provided through `expr`. Supplying neither of these will move the
#'   selection to the left-hand side. Supplying both of these is an error.
#'
#' @param before_arg,after_arg Argument names for `before` and `after`. These
#'   are used in error messages.
#'
#' @return
#' A named vector of numeric locations with length equal to `length(data)`.
#' Each position in `data` will be represented exactly once.
#'
#' The names are normally the same as in the input data, except when the user
#' supplied named selections with `c()`. In the latter case, the names reflect
#' the new names chosen by the user.
#'
#' @export
#' @examples
#' library(rlang)
#'
#' # Interpret defused code as a request to relocate
#' x <- expr(c(mpg, disp))
#' after <- expr(wt)
#' eval_relocate(x, mtcars, after = after)
#'
#' # Supplying neither `before` nor `after` will move the selection to the
#' # left-hand side
#' eval_relocate(x, mtcars)
#'
#' # Within a function, use `enquo()` to defuse a single argument.
#' # Note that `before` and `after` must also be defused with `enquo()`.
#' my_relocator <- function(x, expr, before = NULL, after = NULL) {
#'   eval_relocate(enquo(expr), x, before = enquo(before), after = enquo(after))
#' }
#'
#' my_relocator(mtcars, vs, before = hp)
#'
#' # Here is an example of using `eval_relocate()` to implement `relocate()`.
#' # Note that the dots are passed on as a defused call to `c(...)`.
#' relocate <- function(.x, ..., .before = NULL, .after = NULL) {
#'   pos <- eval_relocate(
#'     expr(c(...)),
#'     .x,
#'     before = enquo(.before),
#'     after = enquo(.after)
#'   )
#'   set_names(.x[pos], names(pos))
#' }
#'
#' relocate(mtcars, vs, .before = hp)
#' relocate(mtcars, starts_with("d"), .after = last_col())
eval_relocate <- function(expr,
                          data,
                          ...,
                          before = NULL,
                          after = NULL,
                          strict = TRUE,
                          name_spec = NULL,
                          allow_rename = TRUE,
                          allow_empty = TRUE,
                          before_arg = "before",
                          after_arg = "after",
                          env = caller_env(),
                          error_call = caller_env()) {
  check_dots_empty()

  sel <- eval_select(
    expr = expr,
    data = data,
    env = env,
    strict = strict,
    name_spec = name_spec,
    allow_rename = allow_rename,
    allow_empty = allow_empty,
    error_call = error_call
  )

  # Enforce the invariant that relocating can't change the number of columns by
  # retaining only the last instance of a column that is renamed multiple times
  # TODO: https://github.com/r-lib/vctrs/issues/1442
  # `sel <- vctrs::vec_unique(sel, which = "last")`
  loc_last <- which(!duplicated(sel, fromLast = TRUE))
  sel <- vctrs::vec_slice(sel, loc_last)

  n <- length(data)

  before <- as_quosure(before, env = env)
  after <- as_quosure(after, env = env)

  has_before <- !quo_is_null(before)
  has_after <- !quo_is_null(after)

  if (has_before && has_after) {
    cli::cli_abort(
      "Can't supply both `{before_arg}` and `{after_arg}`.",
      call = error_call
    )
  }

  if (has_before) {
    where <- eval_select(
      expr = before,
      data = data,
      env = env,
      error_call = error_call,
      allow_rename = FALSE
    )
    where <- unname(where)

    if (length(where) == 0L) {
      # Empty `before` selection pushes `sel` to the front
      where <- 1L
    } else {
      where <- min(where)
    }
  } else if (has_after) {
    where <- eval_select(
      expr = after,
      data = data,
      env = env,
      error_call = error_call,
      allow_rename = FALSE
    )
    where <- unname(where)

    if (length(where) == 0L) {
      # Empty `after` selection pushes `sel` to the back
      where <- n
    } else {
      where <- max(where)
    }

    where <- where + 1L
  } else {
    # Defaults to `before = everything()` if neither
    # `before` nor `after` are supplied
    where <- 1L
  }

  lhs <- seq2(1L, where - 1L)
  rhs <- seq2(where, n)

  lhs <- setdiff(lhs, sel)
  rhs <- setdiff(rhs, sel)

  names <- names(data)

  names(lhs) <- names[lhs]
  names(rhs) <- names[rhs]

  sel <- vctrs::vec_c(lhs, sel, rhs)

  sel
}
