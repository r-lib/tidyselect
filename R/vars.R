#' Replace or get current variables
#'
#' @description
#'
#' Variables are made available to [select helpers][select_helpers] by
#' registering them in a special placeholder.
#'
#' * `poke_vars()` changes the contents of the placeholder with a
#'   new set of variables.
#'
#' * `scoped_vars()` changes the current variables and sets up a
#'   function exit hook that automatically restores the previous
#'   variables once the current function returns.
#'
#' * `peek_vars()` returns the currently registered variables.
#'
#' @param vars A character vector of variable names.
#' @param frame The frame environment where the exit hook for
#'   restoring the old variables should be registered.
#' @return For `poke_vars()` and `scoped_vars()`, the old variables
#'   invisibly. For `peek_vars()`, the variables currently
#'   registered.
#' @export
#' @examples
#' poke_vars(letters)
#' peek_vars()
#'
#' # Now that the variables are registered, the helpers can figure out
#' # the positions of elements within the variable vector:
#' one_of(c("d", "z"))
#'
#' # In a function be sure to restore the previous variables. An exit
#' # hook is the best way to do it:
#' fn <- function(vars) {
#'   old <- poke_vars(vars)
#'   on.exit(poke_vars(old))
#'
#'   one_of("d")
#' }
#' fn(letters)
#' fn(letters[3:5])
#'
#' # The previous variables are still registered after fn() was
#' # called:
#' peek_vars()
#'
#'
#' # It is often more practical to use the scoped variant as it restores
#' # the state automatically when the function returns:
#' fn <- function(vars) {
#'   scoped_vars(vars)
#'   one_of("d")
#' }
#' fn(letters)
poke_vars <- function(vars) {
  stopifnot(is_character(vars) || is_null(vars))

  old <- vars_env$selected
  vars_env$selected <- vars

  invisible(old)
}
#' @rdname poke_vars
#' @export
scoped_vars <- function(vars, frame = caller_env()) {
  old <- poke_vars(vars)

  # Inline everything so the call will succeed in any environment
  expr <- lang(on.exit, lang(poke_vars, old), add = TRUE)
  eval_bare(expr, frame)

  invisible(old)
}
#' @rdname poke_vars
#' @export
peek_vars <- function() {
  vars_env$selected %||% warn("No tidyselect variables were registered")
}

vars_env <- new_environment()
