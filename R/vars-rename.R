
#' @export
#' @rdname vars_select
vars_rename <- function(.vars, ..., .strict = TRUE) {
  quos <- enquos(...)

  if (!.strict) {
    quos <- discard(quos, is_unknown_symbol, .vars)
  }

  inds <- vars_rename_eval(quos, .vars)
  inds <- map(inds, as_indices, .vars)

  check_missing(inds, quos)

  dups <- purrr::map_lgl(inds, is_data_dups)
  inds <- vctrs::vec_c(!!!inds, .name_spec = "{outer}")

  if (any(names2(inds) == "")) {
    abort("All arguments must be named")
  }

  rename_check(
    to = names(inds),
    vars = .vars[vec_index_invert(inds)],
    orig = .vars,
    incl = inds,
    dups = dups
  )

  # Ideally we'd just return `inds` instead of the full vector of
  # renamed vars
  out <- set_names(.vars, .vars)
  names(out)[inds] <- names(inds)
  out
}

is_unknown_symbol <- function(quo, vars) {
  expr <- get_expr(quo)

  if (!is_symbol(expr) && !is_string(expr)) {
    return(FALSE)
  }

  !as_string(expr) %in% vars
}

vars_rename_eval <- function(quos, vars) {
  is_symbolic <- map_lgl(quos, quo_is_symbolic)

  if (any(is_symbolic)) {
    scoped_vars(vars)

    # Mark data duplicates to differentiate them from overlapping selections
    vars_split <- vctrs::vec_split(seq_along(vars), vars)
    vars_split$val <- map(vars_split$val, mark_data_dups)
    data <- set_names(vars_split$val, vars_split$key)

    mask <- as_data_mask(data)
  } else {
    mask <- NULL
  }

  map(quos, expr_rename_eval, mask)
}

expr_rename_eval <- function(quo, mask) {
  # Only symbols have data in scope. All expressions are evaluated in
  # the context only.
  if (is_symbol_expr(quo)) {
    eval_tidy(quo, mask)
  } else if (quo_is_call(quo)) {
    eval_tidy(quo)
  } else {
    quo_get_expr(quo)
  }
}
is_symbol_expr <- function(quo) {
  expr <- get_expr(quo)
  is_symbol(expr) || is_data_pronoun(expr)
}
