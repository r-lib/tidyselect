#' @rdname eval_select
#' @export
eval_rename <- function(expr,
                        data,
                        env = caller_env(),
                        ...,
                        strict = TRUE,
                        name_spec = NULL) {
  ellipsis::check_dots_empty()
  rename_impl(
    data,
    names(data),
    as_quosure(expr, env),
    strict = strict,
    name_spec = name_spec
  )
}

# Caller must put vars in scope
rename_impl <- function(x,
                        names,
                        sel,
                        strict = TRUE,
                        name_spec = NULL) {
  if (is_null(names)) {
    abort("Can't rename an unnamed vector.")
  }

  pos <- eval_select_impl(
    x,
    names,
    {{ sel }},
    strict = strict,
    name_spec = name_spec,
    type = "rename"
  )

  # Check for unique names only if input is a data frame
  if (is.data.frame(x) || is_null(x)) {
    names[pos] <- names(pos)
    with_subscript_errors(
      vctrs::vec_as_names(names, repair = "check_unique")
    )
  }

  pos
}

# Example implementation mainly used for unit tests
rename <- function(.x, ..., .strict = TRUE) {
  pos <- eval_rename(expr(c(...)), .x, strict = .strict)
  names(.x)[pos] <- names(pos)
  .x
}
