
#' @export
#' @rdname vars_select
vars_rename <- function(.vars, ..., .strict = TRUE) {
  quos <- enquos(...)

  if (!.strict) {
    quos <- discard(quos, is_unknown_symbol, .vars)
  }

  inds <- vars_rename_eval(quos, .vars)
  inds <- map(inds, as_indices, .vars)

  check_missing(inds)

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

rename_check <- function(to, vars, orig, incl, dups) {
  # We check that variables are renamed to a unique name but we also
  # want to allow renaming existing duplicates. We remove those from
  # the checking set here.
  if (any(dups)) {
    to <- to[!to %in% names(dups)[dups]]
  }

  if (vctrs::vec_duplicate_any(to)) {
    dups <- vctrs::vec_duplicate_detect(to)
    dups <- vctrs::vec_unique(to[dups])

    probs <- map_chr(dups, function(dup) {
      cols <- orig[incl[names(incl) == dup]]
      cols <- glue::backtick(cols)
      cols <- glue::glue_collapse(cols, sep = ", ", last = " and ")
      glue::glue("* Columns {cols} are being renamed to `{dup}`.")
    })
    msg <- paste_line(
      "Must use unique names when renaming columns.",
      !!!probs
    )

    abort(msg, "tidyselect_error_rename_to_same")
  }

  if (any(vctrs::vec_in(to, vars))) {
    dups <- vars[match(to, vars, 0L)]

    probs <- map_chr(dups, function(dup) {
      col <- orig[[incl[[dup]]]]
      glue::glue("* Column `{col}` is being renamed to existing column `{dup}`.")
    })
    msg <- paste_line(
      "Must use unique name when renaming columns.",
      !!!probs
    )

    abort(msg, "tidyselect_error_rename_to_existing")
  }
}
