#' Replace or get current variables
#'
#' @description
#'
#' Variables are made available to [select helpers][select_helpers] by
#' registering them in a special placeholder.
#'
#' * `replace_vars()` changes the contents of the placeholder with a
#'   new set of variables.
#'
#' * `query_vars()` returns the currently registered variables.
#'
#' @param vars A character vector of variable names.
#' @return For `replace_vars()` and `reset_vars()`, the old variables
#'   invisibly. For `query_vars()`, the variables currently
#'   registered.
#' @export
#' @examples
#' replace_vars(letters)
#' query_vars()
#'
#' # Now that the variables are registered, the helpers can figure out
#' # the positions of elements within the variable vector:
#' one_of(c("d", "z"))
#'
#' # In a function be sure to restore the previous variables. An exit
#' # hook is the best way to do it:
#' fn <- function(vars) {
#'   old <- replace_vars(vars)
#'   on.exit(replace_vars(old))
#'
#'   one_of("d")
#' }
#' fn(letters)
#' fn(letters[3:5])
#'
#' # The previous variables are still registered after fn() was
#' # called:
#' query_vars()
replace_vars <- function(vars) {
  stopifnot(is_character(vars) || is_null(vars))

  old <- vars_env$selected
  vars_env$selected <- vars

  invisible(old)
}
#' @export
#' @rdname replace_vars
query_vars <- function() {
  vars_env$selected %||% warn("Can't get tidyselect variables as none were registered")
}

vars_env <- new_environment()
