#' Select variable
#'
#' This function powers [dplyr::pull()] and various functions of the
#' tidyr package. It is similar to [vars_select()] but returns only
#' one column name and has slightly different semantics: it allows
#' negative numbers to select columns from the end.
#'
#' @inheritParams vars_select
#' @inheritParams rlang::args_error_context
#' @param var A variable specified as:
#'   * a literal variable name
#'   * a positive integer, giving the position counting from the left
#'   * a negative integer, giving the position counting from the right.
#'
#'   The default returns the last column (on the assumption that's the
#'   column you've created most recently).
#'
#'   This argument is taken by expression and supports
#'   [quasiquotation][rlang::quasiquotation] (you can unquote column
#'   names and column locations).
#' @return The selected column name as an unnamed string.
#' @seealso [dplyr::pull()], [vars_select()]
#' @export
#' @keywords internal
#' @examples
#' # It takes its argument by expression:
#' vars_pull(letters, c)
#'
#' # Negative numbers select from the end:
#' vars_pull(letters, -3)
#'
#' # You can unquote variables:
#' var <- 10
#' vars_pull(letters, !!var)
vars_pull <- function(vars, var = -1, error_call = caller_env(), error_arg = "var") {
  expr <- enquo(var)
  if (quo_is_missing(expr)) {
    expr <- -1
  }

  n <- length(vars)

  loc <- with_chained_errors(
    eval_tidy(expr, set_names(seq_along(vars), vars)),
    action = "pull",
    call = error_call,
    eval_expr = expr
  )
  loc <- pull_as_location2(loc, n, vars, error_arg = error_arg, error_call = error_call)

  if (loc < 0L) {
    loc <- n + 1L + loc
  }

  vars[[loc]]
}

pull_as_location2 <- function(i, n, names, error_call = caller_env(), error_arg = "var") {
  with_subscript_errors(type = "pull", {
    i <- vctrs::vec_as_subscript2(i,
      logical = "error",
      arg = error_arg,
      call = error_call
    )

    if (length(i) != 1) {
      cli::cli_abort(
        "{.arg {error_arg}} must select exactly one column.",
        call = error_call
      )
    }

    if (is.numeric(i)) {
      vctrs::num_as_location2(
        i,
        n = n,
        negative = "ignore",
        arg = error_arg,
        call = error_call
      )
    } else {
      vctrs::vec_as_location2(
        i,
        n = n,
        names = names,
        arg = error_arg,
        call = error_call,
      )
    }
  })
}
