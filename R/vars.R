
replace_vars <- function(vars) {
  stopifnot(is_character(vars) || is_null(vars))

  old <- vars_env$selected
  vars_env$selected <- vars

  invisible(old)
}

#' @export
#' @rdname select_helpers
current_vars <- function() {
  vars_env$selected %||% warn("Can't get tidyselect variables as none were registered")
}

vars_env <- new_environment()
