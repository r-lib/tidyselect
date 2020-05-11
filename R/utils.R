
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

str_compact <- function(x) {
  x[x != ""]
}

vec_index_invert <- function(x) {
  if (vec_index_is_empty(x)) {
    TRUE
  } else {
    -x
  }
}
vec_index_is_empty <- function(x) {
  !length(x) || all(x == 0L)
}

vec_is_subtype <- function(x, super, ..., x_arg = "x", super_arg = "super") {
  tryCatch(
    vctrs_error_incompatible_type = function(...) FALSE,
    {
      common <- vctrs::vec_ptype2(x, super, ..., x_arg = x_arg, y_arg = super_arg)
      vctrs::vec_is(common, super)
    }
  )
}

glue_c <- function(..., env = caller_env()) {
  map_chr(chr(...), glue::glue, .envir = env)
}
glue_line <- function(..., env = caller_env()) {
  paste(glue_c(..., env = env), collapse = "\n")
}
glue_bullet <- function(..., .env = caller_env()) {
  format_error_bullets(glue_c(..., env = .env))
}

flat_map_int <- function(.x, .fn, ...) {
  out <- map(.x, .fn, ...)
  vctrs::vec_c(!!!out, .ptype = int())
}

loc_validate <- function(pos, vars) {
  check_missing(pos)
  check_negative(pos)

  pos <- vctrs::vec_as_subscript(pos, logical = "error", character = "error")
  pos <- vctrs::vec_as_location(pos, n = length(vars))

  named(sel_unique(pos))
}
check_missing <- function(x) {
  if (anyNA(x)) {
    abort("Selections can't have missing values.")
  }
}
check_negative <- function(x) {
  if (any(x < 0L)) {
    abort("Selections can't have negative values.")
  }
}

quo_get_expr2 <- function(x, default) {
  if (is_quosure(x)) {
    quo_get_expr(x)
  } else {
    default
  }
}
quo_set_expr2 <- function(x, value, default) {
  if (is_quosure(x)) {
    quo_set_expr(x, value)
  } else {
    default
  }
}

# Always returns a fresh non-shared call
call_expand_dots <- function(call, env) {
  if (!is_call(call)) {
    abort("`call` must be a call.")
  }

  call <- duplicate(call, shallow = TRUE)

  prev <- call
  node <- node_cdr(call)

  while (!is_null(node)) {
    if (is_symbol(node_car(node), "...")) {
      # Capture dots in a pairlist of quosures
      dots_mask <- env(env, enquos = enquos)
      dots <- eval_bare(quote(enquos(...)), dots_mask)
      dots <- as.pairlist(dots)

      # Splice the dots in the call
      if (!is_null(dots)) {
        node_poke_tail(dots, node_cdr(node))
      }
      node_poke_cdr(prev, dots)

      break
    }

    prev <- node
    node <- node_cdr(node)
  }

  call
}

node_compact_missing <- function(node) {
  first <- new_node(NULL, node)
  prev <- first

  while (!is_null(node)) {
    car <- node_car(node)
    cdr <- node_cdr(node)

    if (is_missing(car) || (is_quosure(car) && quo_is_missing(car))) {
      node_poke_cdr(prev, cdr)
    } else {
      prev <- node
    }

    node <- cdr
  }

  node_cdr(first)
}

node_tail <- function(node) {
  rest <- node_cdr(node)

  while (!is_null(rest)) {
    node <- rest
    rest <- node_cdr(node)
  }

  node
}

node_poke_tail <- function(node, new) {
  node_poke_cdr(node_tail(node), new)
}

node_reverse <- function(node) {
  if (is_null(node)) {
    return(NULL)
  }

  prev <- NULL
  rest <- NULL
  tail <- node

  while (!is_null(tail)) {
    rest <- node_cdr(tail)

    if (is_reference(rest, node)) {
      abort("Can't reverse cyclic pairlist.")
    }

    node_poke_cdr(tail, prev)
    prev <- tail
    tail <- rest
  }

  prev
}

named <- function(x) {
  set_names(x, names2(x))
}

signal_env <- env()

signal_once <- function(signal, msg, id) {
  stopifnot(is_string(id))

  if (env_has(signal_env, id)) {
    return(invisible(NULL))
  }
  signal_env[[id]] <- TRUE

  issue <- msg[[1]]
  bullets <- msg[-1]

  msg <- issue
  if (length(bullets)) {
    bullets <- format_error_bullets(bullets)
    msg <- paste_line(msg, bullets)
  }

  signal(paste_line(
    msg, silver("This message is displayed once per session.")
  ))
}
inform_once <- function(msg, id = msg) {
  signal_once(inform, msg, id)
}
warn_once <- function(msg, id = msg) {
  signal_once(warn, msg, id)
}

verbosity <- function(default = "default") {
  opt <- peek_option("tidyselect_verbosity") %||% default

  if (!is_string(opt, c("default", "quiet", "verbose"))) {
    options(tidyselect_verbosity = NULL)
    warn(c(
      "`tidyselect_verbosity` must be `\"quiet\"` or `\"verbose\"`.",
      i = "Resetting to NULL."
    ))

    opt <- default
  }

  opt
}

env_needs_advice <- function(env) {
  if (is_reference(topenv(env), global_env())) {
    return(TRUE)
  }

  if (from_tests(env)) {
    return(TRUE)
  }

  FALSE
}
from_tests <- function(env) {
  testthat_pkg <- Sys.getenv("TESTTHAT_PKG")

  nzchar(testthat_pkg) &&
    identical(Sys.getenv("NOT_CRAN"), "true") &&
    env_name(topenv(env)) == env_name(ns_env(testthat_pkg))
}

has_crayon <- function() {
  is_installed("crayon") && crayon::has_color()
}
silver <- function(x) if (has_crayon()) crayon::silver(x) else x

glue_line <- function(..., env = parent.frame()) {
  out <- map_chr(chr(...), glue::glue, .envir = env)
  paste(out, collapse = "\n")
}
