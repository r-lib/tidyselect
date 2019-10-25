
select_pos <- function(.x,
                       ...,
                       .include = NULL,
                       .exclude = NULL,
                       .strict = TRUE) {
  vctrs::vec_assert(.x)

  vars <- names(.x)
  if (is_null(vars)) {
    abort("Can't select within an unnamed vector.")
  }

  scoped_vars(vars)
  select_impl(
    .x,
    ...,
    .include = .include,
    .exclude = .exclude,
    .strict = .strict
  )
}

# Example of implementation, mainly used for unit tests
select <- function(.x, ..., .strict = TRUE) {
  idx <- select_pos(.x, ..., .strict = .strict)
  set_names(.x[idx], names(idx))
}

select_impl <- function(.x = NULL,
                        ...,
                        .include = NULL,
                        .exclude = NULL,
                        .strict = TRUE) {
  dots <- enquos(...)
  vars <- peek_vars()

  # If the first selector is exclusive (negative), start with all
  # columns. We need to check for symbolic `-` here because if the
  # selection is empty, `inds_combine()` cannot detect a negative
  # indice in first position.
  if (length(dots) && is_negated(dots[[1]])) {
    dots <- list(expr(c(everything(), !!!dots)))
  }

  if (length(.include)) {
    dots <- list(expr(all_of(!!.include) | c(!!!dots)))
  }
  if (length(.exclude)) {
    dots <- list(expr(c(!!!dots, -!!.exclude)))
  }

  inds <- subclass_index_errors(
    vars_select_eval(vars, dots, .strict, data = .x)
  )

  inds_combine(vars, inds)
}

is_negated <- function(x) {
  repeat {
    x <- quo_get_expr2(x, x)

    if (!is_call(x, "c")) {
      break
    }
    x <- node_cadr(x)
  }

  is_call(x, "-", n = 1)
}
