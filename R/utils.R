select_loc <- function(x,
                       sel,
                       ...,
                       include = NULL,
                       exclude = NULL,
                       strict = TRUE,
                       name_spec = NULL,
                       allow_rename = TRUE,
                       allow_empty = TRUE,
                       allow_predicates = TRUE,
                       error_arg = NULL,
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
    allow_predicates = allow_predicates,
    error_arg = error_arg,
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
                         error_arg = NULL,
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
    error_arg = error_arg,
    error_call = error_call
  )
}

any_valid_names <- function(nms) {
  if (is_null(nms)) {
    FALSE
  } else {
    !all(are_empty_name(nms))
  }
}

are_empty_name <- function(nms) {
  check_character(nms)

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
  check_call(call)

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

mask_error_call <- function(data_mask) {
  data_mask$.__tidyselect__.$internal$error_call
}

paste_lines <- function(...) paste(c(...), collapse = "\n")
