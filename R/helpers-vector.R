#' @rdname select_helpers
#' @param x An index vector of names or locations.
#' @inheritParams ellipsis::dots_empty
#' @export
all_of <- function(x) {
  if (is.function(x)) {
    # Trigger bad type error
    vctrs::vec_as_location(x, 0L)
    abort("Internal error: `all_of()` should have failed sooner")
  }

  x
}

#' @rdname select_helpers
#' @export
any_of <- function(x,
                   ...,
                   vars = peek_vars(fn = "any_of")) {
  ellipsis::check_dots_empty()
  as_indices_impl(x, vars = vars, strict = FALSE)
}
