
vars_select_eval <- function(vars, quos, strict) {
  is_symbolic <- map_lgl(quos, quo_is_symbolic)

  if (any(is_symbolic)) {
    scoped_vars(vars)

    # Peek validated variables
    vars <- peek_vars()

    vars_split <- vctrs::vec_split(seq_along(vars), vars)

    # Mark data duplicates to differentiate them from overlapping selections
    vars_split$val <- map(vars_split$val, mark_data_dups)

    # We are intentionally lenient towards partially named inputs
    vars_split <- vctrs::vec_slice(vars_split, !are_empty_name(vars_split$key))

    top <- env()
    bottom <- env(top, !!!set_names(vars_split$val, vars_split$key))
    data_mask <- new_data_mask(bottom, top)
    data_mask$.data <- as_data_pronoun(data_mask)

    # Add `.data` pronoun in the context mask even though it doesn't
    # contain data. This way the pronoun can be used in any parts of the
    # expression.
    context_mask <- new_data_mask(env(!!!vars_select_helpers))
    context_mask$.data <- data_mask$.data

    # Save metadata in masks
    data_mask$.__tidyselect__.$internal$vars <- vars
    data_mask$.__tidyselect__.$internal$strict <- strict
  }

  map_if(
    quos,
    is_symbolic,
    ~ walk_data_tree(., data_mask, context_mask),
    .else = ~ as_indices_impl(quo_get_expr(.), vars = vars, strict = strict)
  )
}

# `walk_data_tree()` is a recursive interpreter that implements a
# clear separation between data expressions (calls to `-`, `:`, `c`,
# and `(`) and context expressions (selection helpers and any other
# calls). It recursively traverses the AST across data expressions.
# The leaves of the data expression tree are either symbols (evaluated
# with `eval_sym()`) or context expressions (evaluated with
# `eval_context()`).

walk_data_tree <- function(expr, data_mask, context_mask, colon = FALSE) {
  # Unwrap quosures to make it easier to inspect expressions. We save
  # a reference to the current quosure environment in the context
  # mask, so we can evaluate the expression in the correct context
  # later on.
  if (is_quosure(expr)) {
    scoped_bindings(.__current__. = quo_get_env(expr), .env = context_mask)
    expr <- quo_get_expr(expr)
  }

  out <- switch(expr_kind(expr),
    literal = expr,
    symbol = eval_sym(as_string(expr), data_mask, context_mask, colon = colon),
    `(` = walk_data_tree(expr[[2]], data_mask, context_mask, colon = colon),
    `!` = ,
    `-` = eval_minus(expr, data_mask, context_mask),
    `:` = eval_colon(expr, data_mask, context_mask),
    `|` = eval_or(expr, data_mask, context_mask),
    `&` = eval_and(expr, data_mask, context_mask),
    `c` = eval_c(expr, data_mask, context_mask),
    `||` = stop_bad_bool_op("||", "|"),
    `&&` = stop_bad_bool_op("&&", "&"),
    `+` = stop_bad_arith_op("+"),
    `*` = stop_bad_arith_op("*"),
    `/` = stop_bad_arith_op("/"),
    `^` = stop_bad_arith_op("^"),
    eval_context(expr, context_mask)
  )

  vars <- data_mask$.__tidyselect__.$internal$vars
  strict <- data_mask$.__tidyselect__.$internal$strict
  out <- as_indices_impl(out, vars = vars, strict = strict)

  vctrs::vec_as_index(out, length(vars), vars, convert_values = NULL)
}

as_indices_impl <- function(x, vars, strict) {
  if (is_null(x)) {
    return(int())
  }

  x <- vctrs::vec_coerce_index(x, allow_types = c("position", "name"))

  if (!strict) {
    # Remove out-of-bounds elements if non-strict
    x <- switch(typeof(x),
      character = intersect(x, vars),
      double = ,
      integer = x[x <= length(vars)]
    )
  }

  switch(typeof(x),
    character = set_names(vctrs::vec_as_index(x, length(vars), vars), names(x)),
    double = ,
    integer = x,
    abort("Internal error: Unexpected type in `as_indices()`.")
  )
}

as_indices <- function(x, vars, strict = TRUE) {
  inds <- subclass_index_errors(as_indices_impl(x, vars, strict))
  vctrs::vec_as_index(inds, length(vars), vars, convert_values = NULL)
}

expr_kind <- function(expr) {
  switch(typeof(expr),
    symbol = "symbol",
    language = call_kind(expr),
    "literal"
  )
}
call_kind <- function(expr) {
  head <- node_car(expr)
  if (!is_symbol(head)) {
    return("call")
  }

  fn <- as_string(head)
  switch(fn,
    `(` = ,
    `-` = ,
    `:` = ,
    `|` = ,
    `&` = ,
    `||` = ,
    `&&` = ,
    `!` = ,
    `+` = ,
    `*` = ,
    `/` = ,
    `^` = ,
    `c` = fn,
    "call"
  )
}

eval_colon <- function(expr, data_mask, context_mask) {
  x <- walk_data_tree(expr[[2]], data_mask, context_mask, colon = TRUE)
  y <- walk_data_tree(expr[[3]], data_mask, context_mask, colon = TRUE)

  x:y
}

eval_minus <- function(expr, data_mask, context_mask) {
  if (length(expr) != 2) {
    return(eval_context(expr, context_mask))
  }

  x <- walk_data_tree(expr[[2]], data_mask, context_mask)
  -x
}

eval_or <- function(expr, data_mask, context_mask) {
  x <- walk_non_symbol(expr[[2]], data_mask, context_mask)
  y <- walk_non_symbol(expr[[3]], data_mask, context_mask)
  c(x, y)
}

eval_and <- function(expr, data_mask, context_mask) {
  x <- walk_non_symbol(expr[[2]], data_mask, context_mask)
  y <- walk_non_symbol(expr[[3]], data_mask, context_mask)
  set_intersect(x, y)
}

walk_non_symbol <- function(expr, data_mask, context_mask) {
  if (is_symbol(expr)) {
    abort(glue_c(
      "Can't use boolean operators with bare variables.",
      x = "`{expr}` is a bare variable.",
      i = "Do you need `all_of({expr})`?"
    ))
  }
  walk_data_tree(expr, data_mask, context_mask)
}

stop_bad_bool_op <- function(bad, ok) {
  abort(glue_c(
    "Can't use scalar `{bad}` in selections.",
    i = "Do you need `{ok}` instead?"
  ))
}

stop_bad_arith_op <- function(op) {
  abort(glue_c(
    "Can't use arithmetic operator `{op}` in selection context."
  ))
}

eval_c <- function(expr, data_mask, context_mask) {
  expr <- duplicate(expr, shallow = TRUE)

  node <- node_cdr(expr)
  while (!is_null(node)) {
    arg <- eval_c_arg(node_car(node), data_mask, context_mask)

    node_poke_car(node, arg)
    node <- node_cdr(node)
  }

  eval(expr, base_env())
}

eval_c_arg <- function(expr, data_mask, context_mask) {
  if (is_quosure(expr)) {
    scoped_bindings(.__current__. = quo_get_env(expr), .env = context_mask)
    expr <- quo_get_expr(expr)
  }

  if (is_symbol(expr, "...")) {
    # Capture arguments in dots as quosures
    dots_mask <- env(context_mask$.__current__., enquos = enquos)
    dots <- eval_bare(quote(enquos(...)), dots_mask)
    call <- call2(quote(c), !!!dots)

    # Evaluate dots separately by recursing into `c()`. The result is
    # automatically spliced by the upstack `c()`.
    eval_c(call, data_mask, context_mask)
  } else {
    walk_data_tree(expr, data_mask, context_mask)
  }
}

eval_context <- function(expr, context_mask) {
  expr <- as_quosure(expr, context_mask$.__current__.)
  eval_tidy(expr, context_mask)
}

eval_sym <- function(name, data_mask, context_mask, colon = FALSE) {
  top <- data_mask$.top_env
  cur <- data_mask
  value <- missing_arg()
  while (!is_reference(cur, top)) {
    if (env_has(cur, name)) {
      value <- env_get(cur, name)
      break
    }
    cur <- env_parent(cur)
  }

  if (!missing(value)) {
    return(value)
  }

  value <- env_get(
    context_mask$.__current__.,
    name,
    default = missing_arg(),
    inherit = TRUE
  )

  if (!is_missing(value)) {
    inform(glue_c(
      "Note: Using an external vector in selections is brittle.",
      i = "If the data contains `{name}` it will be selected instead.",
      i = "Use `all_of({name})` instead of just `{name}` to silence this message."
    ))
    return(value)
  }

  # Let caller issue OOB error
  name
}

mark_data_dups <- function(x) {
  if (length(x) > 1L) {
    structure(x, tidyselect_data_dups = TRUE)
  } else {
    x
  }
}
is_data_dups <- function(x) {
  is_true(attr(x, "tidyselect_data_dups"))
}
