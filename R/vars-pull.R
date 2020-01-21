#' Select variable
#'
#' This function powers [dplyr::pull()] and various functions of the
#' tidyr package. It is similar to [vars_select()] but returns only
#' one column name and has slightly different semantics: it allows
#' negative numbers to select columns from the end.
#'
#' @inheritParams vars_select
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
#' vars_pull(letters, !! var)
vars_pull <- function(vars, var = -1) {
  n <- length(vars)

  instrument_base_errors(
    loc <- eval_tidy(enquo(var), set_names(seq_along(vars), vars))
  )
  loc <- pull_as_location2(loc, n, vars)

  if (loc < 0L) {
    loc <- n + 1L + loc
  }

  vars[[loc]]
}

pull_as_location2 <- function(i, n, names) {
  with_subscript_errors(type = "pull", {
    i <- vctrs::vec_as_subscript2(i, arg = "var", logical = "error")

    if (is.numeric(i)) {
      vctrs::num_as_location2(
        i,
        n = n,
        negative = "ignore",
        arg = "var"
      )
    } else {
      vctrs::vec_as_location2(
        i,
        n = n,
        names = names,
        arg = "var"
      )
    }
  })
}
