select_loc <- function(x,
                       sel,
                       ...,
                       include = NULL,
                       exclude = NULL,
                       strict = TRUE,
                       name_spec = NULL,
                       allow_rename = TRUE,
                       allow_empty = TRUE,
                       error_call = current_env()) {
  check_dots_empty()

  eval_select(
    enquo(sel),
    x,
    include = include,
    exclude = exclude,
    strict = strict,
    name_spec = name_spec,
    allow_rename = allow_rename,
    allow_empty = allow_empty,
    error_call = error_call
  )
}

rename_loc <- function(x,
                       sel,
                       ...,
                       strict = TRUE,
                       name_spec = NULL,
                       error_call = current_env()) {
  check_dots_empty()
  rename_impl(
    x,
    names(x),
    enquo(sel),
    strict = strict,
    name_spec = name_spec,
    error_call = error_call
  )
}

relocate_loc <- function(x,
                         sel,
                         ...,
                         before = NULL,
                         after = NULL,
                         strict = TRUE,
                         name_spec = NULL,
                         allow_rename = TRUE,
                         allow_empty = TRUE,
                         before_arg = "before",
                         after_arg = "after",
                         error_call = current_env()) {
  check_dots_empty()

  eval_relocate(
    expr = enquo(sel),
    data = x,
    before = enquo(before),
    after = enquo(after),
    strict = strict,
    name_spec = name_spec,
    allow_rename = allow_rename,
    allow_empty = allow_empty,
    before_arg = before_arg,
    after_arg = after_arg,
    error_call = error_call
  )
}

are_empty_name <- function(nms) {
  if (!is_character(nms)) {
    abort("Expected a character vector")
  }

  nms == "" | is.na(nms)
}

# https://github.com/r-lib/vctrs/issues/571
vec_is_coercible <- function(x, to, ..., x_arg = "x", to_arg = "to") {
  try_fetch(
    vctrs_error_incompatible_type = function(...) FALSE,
    {
      vctrs::vec_ptype2(x, to, ..., x_arg = x_arg, y_arg = to_arg)
      TRUE
    }
  )
}

flat_map_int <- function(.x, .fn, ...) {
  out <- map(unname(.x), .fn, ...)
  vctrs::vec_c(!!!out, .ptype = int())
}

loc_validate <- function(pos, vars, call = caller_env()) {
  check_missing(pos, call = call)
  check_negative(pos, call = call)

  pos <- vctrs::vec_as_subscript(
    pos,
    logical = "error",
    character = "error",
    call = call
  )
  pos <- vctrs::vec_as_location(
    pos,
    n = length(vars),
    call = call
  )

  named(sel_unique(pos))
}
check_missing <- function(x, call) {
  if (anyNA(x)) {
    abort("Selections can't have missing values.", call = call)
  }
}
check_negative <- function(x, call) {
  if (any(x < 0L)) {
    abort("Selections can't have negative values.", call = call)
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

named <- function(x) {
  set_names(x, names2(x))
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

mask_error_call <- function(data_mask) {
  data_mask$.__tidyselect__.$internal$error_call
}
