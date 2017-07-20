
is_negated <- function(x) {
  is_lang(x, "-", n = 1)
}

sym_dollar <- quote(`$`)
sym_brackets2 <- quote(`[[`)
is_data_pronoun <- function(expr) {
  is_lang(expr, list(sym_dollar, sym_brackets2)) &&
    identical(node_cadr(expr), quote(.data))
}

commas <- function(...) paste0(..., collapse = ", ")

singular <- function(vars) {
  nm <- attr(vars, "type") %||% c("column", "columns")
  if (!is_character(nm, 2)) {
    abort("The `type` attribute must be a character vector of length 2")
  }
  nm[[1]]
}
plural <- function(vars) {
  nm <- attr(vars, "type") %||% c("column", "columns")
  if (!is_character(nm, 2)) {
    abort("The `type` attribute must be a character vector of length 2")
  }
  nm[[2]]
}

paren_sym <- quote(`(`)
minus_sym <- quote(`-`)
colon_sym <- quote(`:`)
c_sym <- quote(`c`)
