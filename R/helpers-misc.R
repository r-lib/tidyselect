#' @export
#' @rdname select_helpers
everything <- function(vars = peek_vars(fn = "everything")) {
  seq_along(vars)
}

#' @export
#' @param offset Set it to `n` to select the nth var from the end.
#' @rdname select_helpers
last_col <- function(offset = 0L, vars = peek_vars(fn = "last_col")) {
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
