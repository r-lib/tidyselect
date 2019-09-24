
is_negated <- function(x) {
  is_call(x, "-", n = 1)
}

sym_dollar <- quote(`$`)
sym_brackets2 <- quote(`[[`)
is_data_pronoun <- function(expr) {
  is_call(expr, list(sym_dollar, sym_brackets2)) &&
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

quo_as_list <- function(quo) {
  as.list(quo_get_expr(quo))
}

is_character <- function(x, n = NULL) {
  if (typeof(x) != "character") return(FALSE)

  if (!is_null(n)) {
    if (is_scalar_integerish(n) && length(x) != n) return(FALSE)
    else if (is_function(n) && !n(length(x))) return(FALSE)
  }

  TRUE
}

are_empty_name <- function(nms) {
  if (!is_character(nms)) {
    abort("Expected a character vector")
  }

  nms == "" | is.na(nms)
}

# Compatibility with R < 3.2
isNamespaceLoaded <- function(name) {
  name %in% loadedNamespaces()
}

collapse_labels <- function(x) {
  bullets <- map_chr(x, ~ paste0("* ", as_label(.)))
  paste_line(!!!bullets)
}
paste_line <- function (...) {
  paste(chr(...), collapse = "\n")
}

maybe_unwrap_quosure <- function(x) {
  if (is_quosure(x)) {
    quo_get_expr(x)
  } else {
    x
  }
}

# https://github.com/r-lib/vctrs/issues/571
vec_is_coercible <- function(x, to, ..., x_arg = "x", to_arg = "to") {
  tryCatch(
    vctrs_error_incompatible_type = function(...) FALSE,
    {
      vctrs::vec_ptype2(x, to, ..., x_arg = x_arg, y_arg = to_arg)
      TRUE
    }
  )
}

last <- function(x) {
  x[[length(x)]]
}

# Until lifecycle supports deprecating features other than functions
# and arguments. This doesn't feature the subtle soft-deprecation
# rules of the lifecycle package but it would be hard to support these
# anyway because tidyselect is meant to be wrapped.
deprecate_warn <- function(msg) {
  verbosity <- peek_option("lifecycle_verbosity") %||% "warn"
  signaller <- switch(verbosity,
    warning = warn,
    error = abort,
    quiet = function(...) NULL,
    maybe_warn
  )
  signaller(msg, "lifecycle_warning_deprecated")
}

deprecation_env <- env()
maybe_warn <- function(msg, class) {
  if (is_null(deprecation_env[[msg]])) {
    deprecation_env[[msg]] <- TRUE
    warn(msg, class)
  }
}
