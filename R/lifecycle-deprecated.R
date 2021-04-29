#' Select or rename variables
#'
#' @description
#' `r lifecycle::badge("questioning")`
#'
#' Please use [eval_select()] and [eval_rename()] instead. See
#' `vignette("tidyselect")` to get started.
#'
#' @param .vars A character vector of existing column names.
#' @param ...,args Selection inputs. See the help for [selection
#'   helpers][language].
#' @param .include,.exclude Character vector of column names to always
#'   include/exclude.
#' @param .strict If `TRUE`, will throw an error if you attempt to select or
#'   rename a variable that doesn't exist.
#' @return A named character vector. Values are existing column names,
#'   names are new names.
#'
#' @seealso [vars_pull()]
#' @export
#' @keywords internal
vars_select <- function(.vars,
                        ...,
                        .include = character(),
                        .exclude = character(),
                        .strict = TRUE) {
  dots <- enquos(...)
  if (!length(dots)) {
    signal("", "tidyselect_empty_dots")
    return(empty_sel(.vars, .include, .exclude))
  }

  idx <- eval_select_impl(
    NULL,
    .vars,
    expr(c(!!!dots)),
    include = .include,
    exclude = .exclude,
    strict = .strict,
    name_spec = unique_name_spec,
    uniquely_named = TRUE
  )

  sel <- set_names(.vars[idx], names(idx))

  # Ensure all output are named, with `.vars` as default
  if (is_empty(sel)) {
    signal("", "tidyselect_empty")
    names(sel) <- chr()
  } else {
    unnamed <- names2(sel) == ""
    names(sel)[unnamed] <- sel[unnamed]
  }

  sel
}

empty_sel <- function(vars, include, exclude) {
  vars <- setdiff(include, exclude)
  set_names(vars, vars)
}

#' @export
#' @rdname vars_select
vars_rename <- function(.vars, ..., .strict = TRUE) {
  pos <- rename_impl(
    NULL,
    .vars,
    quo(c(...)),
    strict = .strict
  )

  .vars <- set_names(.vars)
  names(.vars)[pos] <- names(pos)

  .vars
}
