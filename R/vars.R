peeker <- function(what) {
  function(..., fn = NULL) {
    if (!missing(...)) {
      check_dots_empty()
    }

    x <- vars_env[[what]]

    if (is_null(x)) {
      if (is_null(fn)) {
        fn <- "Selection helpers"
      } else {
        fn <- glue::glue("`{fn}()`")
      }

      # Please keep in sync with faq.R.
      cli::cli_abort(
        c(
          "{fn} must be used within a *selecting* function.",
          i = "See {peek_vars_link()} for details."
        ),
        call = NULL
      )
    }

    x
  }
}

peek_vars_link <- function() {
  if (is_interactive() && cli::ansi_has_hyperlink_support()) {
    topic <- "tidyselect::faq-selection-context"
    cli::style_hyperlink(paste0("?", topic), "ide:help", params = c(package = "tidyselect", topic = "faq-selection-context"))
  } else {
    "<https://tidyselect.r-lib.org/reference/faq-selection-context.html>"
  }
}

#' Peek at variables in the selection context
#'
#' @description
#'
#' * `peek_vars()` returns the vector of names of the variables
#'   currently available for selection.
#'
#' * `peek_data()` returns the whole input vector (only available with
#'   [eval_select()]).
#'
#' Read the [Get
#' started](https://tidyselect.r-lib.org/articles/tidyselect.html) for
#' examples of how to create selection helpers with `peek_vars()`.
#'
#' The variable names in a selection context are registered
#' automatically by [eval_select()] and [eval_rename()] for the
#' duration of the evaluation. `peek_vars()` is the glue that connects
#' [selection helpers][language] to the current selection
#' context.
#'
#' @inheritParams rlang::args_dots_empty
#' @param fn The name of the function to use in error messages when
#'   the helper is used in the wrong context. If not supplied, a
#'   generic error message is used instead.
#'
#' @export
peek_vars <- peeker("selected")
#' @rdname peek_vars
#' @export
peek_data <- peeker("data")

#' Replace or get current variables
#'
#' @description
#'
#' Variables are made available to [select helpers][language] by
#' registering them in a special placeholder.
#'
#' * `scoped_vars()` changes the current variables and sets up a
#'   function exit hook that automatically restores the previous
#'   variables once the current function returns.
#'
#' * `with_vars()` takes an expression to be evaluated in a variable
#'   context.
#'
#' * `poke_vars()` changes the contents of the placeholder with a new
#'   set of variables. It returns the previous variables invisibly and
#'   it is your responsibility to restore them after you are
#'   done. This is for expert use only.
#'
#' * `peek_vars()` returns the variables currently registered.
#'
#' * `has_vars()` returns `TRUE` if a variable context has been set,
#'   `FALSE` otherwise.
#'
#' @param vars A character vector of variable names.
#' @return For `poke_vars()` and `scoped_vars()`, the old variables
#'   invisibly. For `peek_vars()`, the variables currently
#'   registered.
#'
#' @seealso peek_vars
#'
#' @export
#' @keywords internal
#' @examples
#' poke_vars(letters)
#' peek_vars()
#'
#' # Now that the variables are registered, the helpers can figure out
#' # the locations of elements within the variable vector:
#' all_of(c("d", "z"))
#'
#' # In a function be sure to restore the previous variables. An exit
#' # hook is the best way to do it:
#' fn <- function(vars) {
#'   old <- poke_vars(vars)
#'   on.exit(poke_vars(old))
#'
#'   all_of("d")
#' }
#' fn(letters)
#' fn(letters[3:5])
#'
#' # The previous variables are still registered after fn() was
#' # called:
#' peek_vars()
#'
#'
#' # It is recommended to use the scoped variant as it restores the
#' # state automatically when the function returns:
#' fn <- function(vars) {
#'   scoped_vars(vars)
#'   starts_with("r")
#' }
#' fn(c("red", "blue", "rose"))
#'
#' # The with_vars() helper makes it easy to pass an expression that
#' # should be evaluated in a variable context. Thanks to lazy
#' # evaluation, you can just pass the expression argument from your
#' # wrapper to with_vars():
#' fn <- function(expr) {
#'   vars <- c("red", "blue", "rose")
#'   with_vars(vars, expr)
#' }
#' fn(starts_with("r"))
poke_vars <- function(vars) {
  if (!is_null(vars)) {
    vars <- vars_validate(vars)
  }

  old <- vars_env$selected
  vars_env$selected <- vars

  invisible(old)
}
poke_data <- function(data) {
  old <- vars_env$data
  vars_env$data <- data
  invisible(old)
}

#' @rdname poke_vars
#' @param frame The frame environment where the exit hook for
#'   restoring the old variables should be registered.
#' @export
scoped_vars <- function(vars, frame = caller_env()) {
  old <- poke_vars(vars)
  withr::defer(poke_vars(old), envir = frame)
  invisible(old)
}
local_vars <- scoped_vars

local_data <- function(data, frame = caller_env()) {
  old <- poke_data(data)
  withr::defer(poke_data(old), envir = frame)
  invisible(old)
}

#' @rdname poke_vars
#' @param expr An expression to be evaluated within the variable
#'   context.
#' @export
with_vars <- function(vars, expr) {
  local_vars(vars)
  expr
}

#' @rdname poke_vars
has_vars <- function() {
  !is_null(vars_env$selected)
}

vars_validate <- function(vars) {
  if (!is_character(vars)) {
    abort("`vars` must be a character vector")
  }

  # Named `vars` makes it harder to implement select helpers
  unname(vars)
}

vars_env <- new_environment()
