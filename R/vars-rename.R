#' @export
#' @rdname vars_select
#' @param .strict If `TRUE`, will throw an error if you attempt to rename a
#'   variable that doesn't exist.
vars_rename <- function(.vars, ..., .strict = TRUE) {
  quos <- quos(...)

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

  select <- set_names(.vars, .vars)
  renamed_idx <- match(old_vars, .vars)
  names(select)[renamed_idx] <- new_vars

  select
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
  switch_type(expr,
    integer = ,
    double =
      if (!is_integerish(expr)) {
        abort(glue("{ Singular(vars) } positions must be round numbers"))
      } else if (length(expr) != 1) {
        abort(glue("{ Singular(vars) } positions must be scalar"))
      } else {
        return(vars[[expr]])
      },
    string =
      return(expr)
  )

  actual_type <- friendly_type(type_of(expr))
  named_call <- ll(!! name := expr)
  bad_named_calls(named_call,
    "must be a { singular(vars) } name or position, not {actual_type}"
  )
}
