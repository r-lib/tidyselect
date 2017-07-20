
set_current_vars <- function(vars) {
  stopifnot(is_character(vars) || is_null(vars))

  old <- cur_vars_env$selected
  cur_vars_env$selected <- vars

  invisible(old)
}

#' @export
#' @rdname select_helpers
current_vars <- function() {
  cur_vars_env$selected %||% warn("Variable context not set")
}

cur_vars_env <- new_environment()
