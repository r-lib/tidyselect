#' @export
#' @rdname vars_select
#' @param .strict If `TRUE`, will throw an error if you attempt to rename a
#'   variable that doesn't exist.
vars_rename <- function(.vars, ..., .strict = TRUE) {
  exprs <- exprs(...)
  if (any(names2(exprs) == "")) {
    abort("All arguments must be named")
  }

  old_vars <- map2(exprs, names(exprs), switch_rename)
  new_vars <- names(exprs)

  unknown_vars <- setdiff(old_vars, .vars)
  if (.strict && length(unknown_vars) > 0) {
    bad_args(unknown_vars, "contains unknown variables")
  }

  select <- set_names(.vars, .vars)
  names(select)[match(old_vars, .vars)] <- new_vars

  select
}

# FIXME: that's not a tidy implementation yet because we need to
# handle non-existing symbols silently when `strict = FALSE`
switch_rename <- function(expr, name) {
  switch_type(expr,
    string = ,
    symbol =
      return(as_string(expr)),
    language =
      if (is_data_pronoun(expr)) {
        args <- node_cdr(expr)
        return(switch_rename(node_cadr(args)))
      } else {
        abort("Expressions are currently not supported in `rename()`")
      }
  )

  actual_type <- friendly_type(type_of(expr))
  named_call <- ll(!! name := expr)
  bad_named_calls(named_call, "must be a symbol or a string, not {actual_type}")
}
