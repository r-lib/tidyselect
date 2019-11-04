
select_pos <- function(.x,
                       expr,
                       .include = NULL,
                       .exclude = NULL,
                       .strict = TRUE) {
  vctrs::vec_assert(.x)

  vars <- names(.x)
  if (is_null(vars)) {
    abort("Can't select within an unnamed vector.")
  }

  scoped_vars(vars)
  select_impl(.x,
    {{ expr }},
    .include = .include,
    .exclude = .exclude,
    .strict = .strict
  )
}

# Example of implementation, mainly used for unit tests
select <- function(.x, ..., .strict = TRUE) {
  idx <- select_pos(.x, c(!!!enquos(...)), .strict = .strict)
  set_names(.x[idx], names(idx))
}

select_impl <- function(.x,
                        expr,
                        .include = NULL,
                        .exclude = NULL,
                        .strict = TRUE) {
  expr <- enquo(expr)
  vars <- peek_vars()

  if (length(.include)) {
    expr <- list(quo(all_of(.include) | !!expr))
  }
  if (length(.exclude)) {
    expr <- list(quo(c(!!!dots, -.exclude)))
  }

  inds <- subclass_index_errors(
    vars_select_eval(vars, expr, .strict, data = .x)
  )

  inds_combine(vars, inds)
}
