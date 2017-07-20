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
#' * `scoped_vars()` changes the current variables and sets up a
#'   function exit hook that automatically restores the previous
#'   variables once the current function returns.
#'
#' * `query_vars()` returns the currently registered variables.
#'
#' @param vars A character vector of variable names.
#' @param frame The frame environment where the exit hook for
#'   restoring the old variables should be registered.
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
#'
#'
#' # It is often more practical to use the scoped variant as it restores
#' # the state automatically when the function returns:
#' fn <- function(vars) {
#'   scoped_vars(vars)
#'   one_of("d")
#' }
#' fn(letters)
replace_vars <- function(vars) {
  stopifnot(is_character(vars) || is_null(vars))

  old <- vars_env$selected
  vars_env$selected <- vars

  invisible(old)
}
#' @rdname replace_vars
#' @export
scoped_vars <- function(vars, frame = caller_env()) {
  old <- replace_vars(vars)

  # Inline everything so the call will succeed in any environment
  expr <- lang(on.exit, lang(replace_vars, old), add = TRUE)
  eval_bare(expr, frame)

  invisible(old)
}
#' @rdname replace_vars
#' @export
query_vars <- function() {
  vars_env$selected %||% warn("Can't get tidyselect variables as none were registered")
}

vars_env <- new_environment()
