#' @rdname eval_select
#' @export
eval_rename <- function(expr,
                        data,
                        env = caller_env(),
                        ...,
                        strict = TRUE,
                        name_spec = NULL,
                        allow_predicates = TRUE,
                        error_call = caller_env()) {
  check_dots_empty()

  if (is.na(allow_predicates)) {
    allow_predicates <- tidyselect_data_supports_predicates(data)
  }
  data <- tidyselect_data_proxy(data)

  rename_impl(
    data,
    names(data),
    as_quosure(expr, env),
    strict = strict,
    name_spec = name_spec,
    allow_predicates = allow_predicates,
    error_call = error_call
  )
}

# Caller must put vars in scope
rename_impl <- function(x,
                        names,
                        sel,
                        strict = TRUE,
                        name_spec = NULL,
                        allow_predicates = TRUE,
                        error_call) {
  if (is_null(names)) {
    cli::cli_abort("Can't rename an unnamed vector.", call = error_call)
  }

  pos <- eval_select_impl(
    x,
    names,
    {{ sel }},
    strict = strict,
    name_spec = name_spec,
    type = "rename",
    allow_predicates = allow_predicates,
    error_call = error_call
  )

  # Check for unique names only if input is a data frame
  if (is.data.frame(x) || is_null(x)) {
    names[pos] <- names(pos)
    with_subscript_errors(
      vctrs::vec_as_names(
        names,
        repair = "check_unique",
        call = error_call
      )
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
