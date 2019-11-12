
eval_select <- function(expr,
                        data,
                        env = caller_env(),
                        ...,
                        include = NULL,
                        exclude = NULL,
                        strict = TRUE,
                        name_spec = NULL) {
  ellipsis::check_dots_empty()
  eval_select_impl(
    data,
    names(data),
    as_quosure(expr, env),
    include = include,
    exclude = exclude,
    strict = strict,
    name_spec = name_spec
  )
}

# Caller must put vars in scope
eval_select_impl <- function(x,
                             names,
                             expr,
                             include = NULL,
                             exclude = NULL,
                             strict = TRUE,
                             name_spec = NULL,
                             uniquely_named = NULL,
                             type = "select") {
  if (!is_null(x)) {
    vctrs::vec_assert(x)
  }
  if (is_null(names)) {
    abort("Can't select within an unnamed vector.")
  }

  # Put vars in scope and peek validated vars
  scoped_vars(names)
  vars <- peek_vars()

  if (length(include)) {
    expr <- quo(all_of(include) | !!expr)
  }
  if (length(exclude)) {
    expr <- quo(!!expr & !all_of(exclude))
  }

  subclass_index_errors(
    vars_select_eval(
      vars,
      expr,
      strict,
      data = x,
      name_spec = name_spec,
      uniquely_named = uniquely_named,
      type = type
    ),
    type = type
  )
}

# Example implementation mainly used for unit tests
select <- function(.x, ..., .strict = TRUE) {
  pos <- eval_select(expr(c(...)), .x, strict = .strict)
  set_names(.x[pos], names(pos))
}
