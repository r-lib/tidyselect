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
#'   names and column positions).
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
  var_expr <- enquo(var)
  var_env <- set_names(seq_along(vars), vars)
  var <- eval_tidy(var_expr, var_env)
  n <- length(vars)

  # Fall degenerate values like `Inf` through integerish branch
  if (is_double(var, 1) && !is.finite(var)) {
    var <- na_int
  }

  if (is_string(var)) {
    pos <- match_var(var, vars)
  } else if (is_integerish(var, 1)) {
    if (is_na(var) || abs(var) > n || var == 0L) {
      what <- as_label(var_expr)
      abort(glue(
        "`{what}` must be a value between {-n} and {n} (excluding zero), not {var}"
      ))
    }
    if (var < 0) {
      pos <- var + n + 1
    } else {
      pos <- var
    }
  } else {
    type <- friendly_type_of(var)
    what <- as_label(var_expr)
    abort(glue(
      "`{what}` must evaluate to a single number or a { singular(vars) } name, not {type}"
    ))
  }

  vars[[pos]]
}
