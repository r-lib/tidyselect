
select_pos <- function(.x, ..., .strict = TRUE) {
  vars <- names(.x)
  if (is_null(vars)) {
    abort("Can't select within an unnamed vector.")
  }

  scoped_vars(vars)
  select_impl(.x, ..., .strict = .strict)
}

# Example of implementation, mainly used for unit tests
vec_select <- function(.x, ..., .strict = TRUE) {
  if (is.data.frame(.x)) {
    abort("`.x` can't be a data frame.")
  }
  idx <- select_pos(.x, ..., .strict = .strict)
  set_names(vctrs::vec_slice(.x, idx), names(idx))
}

select_impl <- function(.x = NULL,
                        ...,
                        .strict = TRUE) {
  dots <- enquos(...)
  vars <- peek_vars()

  ind_list <- subclass_index_errors(
    vars_select_eval(vars, dots, .strict, data = .x)
  )

  # If the first selector is exclusive (negative), start with all
  # columns. We need to check for symbolic `-` here because if the
  # selection is empty, `inds_combine()` cannot detect a negative
  # indice in first position.
  if (is_negated(quo_get_expr(dots[[1]]))) {
    ind_list <- c(list(seq_along(vars)), ind_list)
  }

  inds_combine(vars, ind_list)
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
