#' @export
#' @rdname vars_select
vars_rename <- function(.vars, ..., .strict = TRUE) {
  quos <- enquos(...)

  unquoted_chrs <- map_lgl(quos, quo_is_character, n = function(n) n > 1)
  quos <- purrr::lmap_if(quos, unquoted_chrs, function(x) quo_as_list(x[[1]]))

  if (any(names2(quos) == "")) {
    abort("All arguments must be named")
  }
  if (!.strict) {
    quos <- discard(quos, is_unknown_symbol, .vars)
  }

  new_vars <- names(quos)
  old_vars <- vars_rename_eval(quos, .vars)
  check_missing(old_vars, quos)

  known <- old_vars %in% .vars

  if (!all(known)) {
    if (.strict) {
      unknown <- old_vars[!known]
      bad_unknown_vars(.vars, unknown)
    } else {
      old_vars <- old_vars[known]
      new_vars <- new_vars[known]
    }
  }

  # Remove existing variables
  if (length(old_vars)) {
    dups_idx <- match(names(old_vars), .vars, nomatch = 0L)
    if (!vec_index_is_empty(dups_idx)) {
      .vars <- .vars[-dups_idx]
    }
  }

  select <- set_names(.vars, .vars)
  renamed_idx <- match(old_vars, .vars)
  names(select)[renamed_idx] <- new_vars

  select
}

quo_is_character <- function(quo, n = NULL) {
  expr <- quo_get_expr(quo)

  if (!is_character(expr)) {
    return(FALSE)
  }

  length(expr) > 1 || !is_null(names(expr))
}

vars_rename_eval <- function(quos, vars) {
  scoped_vars(vars)

  # Only symbols have data in scope
  is_symbol <- map_lgl(quos, is_symbol_expr)
  data <- set_names(as.list(seq_along(vars)), vars)
  mask <- as_data_mask(data)
  renamed <- map_if(quos, is_symbol, eval_tidy, mask)

  # All expressions are evaluated in the context only
  renamed <- map_if(renamed, !is_symbol, eval_tidy)

  renamed <- map2_chr(renamed, names(quos), validate_renamed_var, vars)
  renamed
}
is_symbol_expr <- function(quo) {
  expr <- get_expr(quo)
  is_symbol(expr) || is_data_pronoun(expr)
}

validate_renamed_var <- function(expr, name, vars) {
  if (is_string(expr)) {
    return(expr)
  }

  # We deal with missing values later
  if (anyNA(expr)) {
    return(NA)
  }

  if (!typeof(expr) %in% c("integer", "double")) {
    actual_type <- friendly_type_of(expr)
    named_call <- ll(!! name := expr)
    bad_named_calls(named_call,
      "must be a { singular(vars) } name or position, not {actual_type}"
    )
  }

  if (!is_integerish(expr)) {
    abort(glue("{ Singular(vars) } positions must be round numbers"))
  }
  if (length(expr) != 1) {
    abort(glue("{ Singular(vars) } positions must be scalar"))
  }
  vars[[expr]]
}
