
is_negated <- function(x) {
  is_lang(x, "-", n = 1)
}

sym_dollar <- quote(`$`)
sym_brackets2 <- quote(`[[`)
is_data_pronoun <- function(expr) {
  is_lang(expr, list(sym_dollar, sym_brackets2)) &&
    identical(node_cadr(expr), quote(.data))
}

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
Singular <- function(vars) {
  capitalise_first(singular(vars))
}
Plural <- function(vars) {
  capitalise_first(plural(vars))
}

vars_pluralise <- function(vars) {
  pluralise(vars, singular(vars), plural(vars))
}
vars_pluralise_len <- function(vars, x) {
  pluralise_len(x, singular(vars), plural(vars))
}

capitalise_first <- function(chr) {
  gsub("(^[[:alpha:]])", "\\U\\1", chr, perl = TRUE)
}

paren_sym <- quote(`(`)
minus_sym <- quote(`-`)
colon_sym <- quote(`:`)
c_sym <- quote(`c`)
