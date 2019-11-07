
vars_select_eval <- function(vars,
                             expr,
                             strict,
                             data = NULL,
                             name_spec = NULL,
                             uniquely_named = NULL) {
  wrapped <- quo_get_expr2(expr, expr)

  if (is_missing(wrapped)) {
    return(named(int()))
  }
  if (!is_symbolic(wrapped)) {
    return(as_indices_sel_impl(wrapped, vars = vars, strict = strict, data = data))
  }

  vars <- peek_vars()

  vars_split <- vctrs::vec_split(seq_along(vars), vars)

  # Mark data duplicates so we can fail instead of disambiguating them
  # when renaming
  uniquely_named <- uniquely_named %||% is.data.frame(data)
  if (uniquely_named) {
    vars_split$val <- map(vars_split$val, mark_data_dups)
  }

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

  if (is_null(name_spec)) {
    if (inherits(data, "data.frame")) {
      name_spec <- unique_name_spec
    } else {
      name_spec <- minimal_name_spec
    }
  }

  # Save metadata in mask
  internal <- list(
    vars = vars,
    data = data,
    strict = strict,
    name_spec = name_spec,
    uniquely_named = uniquely_named
  )
  data_mask$.__tidyselect__.$internal <- internal

  pos <- walk_data_tree(expr, data_mask, context_mask)

  # Ensure position vector is fully named
  nms <- names(pos) <- names2(pos)
  nms_missing <- nms == ""
  names(pos)[nms_missing] <- vars[pos[nms_missing]]

  # Duplicates are not allowed for data frames
  if (uniquely_named) {
    vctrs::vec_as_names(names(pos), repair = "check_unique")
  }

  pos
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
    expr <- quo_get_expr2(expr, expr)
  }

  out <- switch(expr_kind(expr),
    literal = expr,
    symbol = eval_sym(expr, data_mask, context_mask),
    `(` = walk_data_tree(expr[[2]], data_mask, context_mask, colon = colon),
    `!` = eval_bang(expr, data_mask, context_mask),
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
  data <- data_mask$.__tidyselect__.$internal$data

  as_indices_sel_impl(out, vars = vars, strict = strict, data)
}

as_indices_sel_impl <- function(x, vars, strict, data = NULL) {
  if (is.function(x)) {
    if (is_null(data)) {
      abort(c(
        "This tidyselect interface doesn't support predicates yet.",
        i = "Contact the package author and suggest using `select_pos()`."
      ))
    }
    predicate <- x
    x <- which(map_lgl(data, predicate))
  }

  as_indices_impl(x, vars, strict = strict)
}

as_indices_impl <- function(x, vars, strict) {
  if (is_null(x)) {
    return(int())
  }

  if (!strict) {
    # Remove out-of-bounds elements if non-strict. First coerce to the
    # right type before changing the values.
    x <- vctrs::vec_coerce_index(x)
    x <- switch(typeof(x),
      character = set_intersect(x, c(vars, na_chr)),
      double = ,
      integer = x[x <= length(vars)],
      x
    )
  }

  out <- vctrs::vec_as_index(
    x,
    n = length(vars),
    names = vars,
    allow_types = c("position", "name"),
    convert_values = NULL
  )

  switch(typeof(out),
    character = set_names(out, names(x)),
    double = ,
    integer = out,
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

eval_bang <- function(expr, data_mask, context_mask) {
  x <- walk_data_tree(expr[[2]], data_mask, context_mask)

  vars <- data_mask$.__tidyselect__.$internal$vars
  set_diff(seq_along(vars), x)
}

eval_minus <- function(expr, data_mask, context_mask) {
  if (length(expr) == 2) {
    eval_bang(expr, data_mask, context_mask)
  } else {
    eval_context(expr, context_mask)
  }
}

eval_or <- function(expr, data_mask, context_mask) {
  x <- walk_operand(expr[[2]], data_mask, context_mask)
  y <- walk_operand(expr[[3]], data_mask, context_mask)

  sel_union(x, y)
}

eval_and <- function(expr, data_mask, context_mask) {
  x <- expr[[2]]
  y <- expr[[3]]

  if (is_symbol(x) && is_symbol(y)) {
    x_name <- as_string(x)
    y_name <- as_string(y)

    x <- eval_sym(x, data_mask, context_mask, strict = TRUE)
    y <- eval_sym(y, data_mask, context_mask, strict = TRUE)

    if (!is_function(x) && !is_function(y)) {
      abort(glue_c(
        "Can't take the intersection of two columns.",
        i = "`{x_name} & {y_name}` is always an empty selection."
      ))
    }
  }

  x <- walk_operand(x, data_mask, context_mask)
  y <- walk_operand(y, data_mask, context_mask)
  set_intersect(x, y)
}

walk_operand <- function(expr, data_mask, context_mask) {
  if (is_symbol(expr)) {
    expr <- eval_sym(expr, data_mask, context_mask, strict = TRUE)
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
  expr <- call_expand_dots(expr, context_mask$.__current__.)
  node <- node_cdr(expr)

  # If the first selector is exclusive (negative), start with all
  # columns. `-foo` is syntax for `everything() - foo`.
  if (is_negated(node_car(node))) {
    node <- new_node(quote(everything()), node)
    expr <- node_poke_cdr(expr, node)
  }

  # Reduce over reversed list to produce left-associative precedence
  node <- node_reverse(node)
  reduce_sels(node, data_mask, context_mask)
}

reduce_sels <- function(node, data_mask, context_mask) {
  tag <- node_tag(node)
  car <- node_car(node)
  cdr <- node_cdr(node)

  neg <- is_negated(car)
  if (neg) {
    car <- unnegate(car)
  }

  out <- walk_data_tree(car, data_mask, context_mask)

  if (!is_null(tag)) {
    internal <- data_mask$.__tidyselect__.$internal
    out <- combine_names(out, tag, internal$name_spec, internal$strict)
  }

  # Base case of the reduction
  if (is_null(cdr)) {
    return(out)
  }

  # The left operands are in the CDR because the pairlist has been reversed
  lhs <- reduce_sels(cdr, data_mask, context_mask)

  if (neg) {
    sel_diff(lhs, out)
  } else {
    sel_union(lhs, out)
  }
}

is_negated <- function(x) {
  x <- quo_get_expr2(x, x)
  is_call(x, "-", n = 1)
}
unnegate <- function(x) {
  expr <- quo_get_expr2(x, x)
  expr <- node_cadr(expr)
  quo_set_expr2(x, expr, expr)
}

combine_names <- function(x, tag, name_spec, uniquely_named) {
  if (uniquely_named && is_data_dups(x)) {
    bullets <- function(cnd, ...) {
      name <- as_string(tag)
      glue_c(x = "Can't rename duplicate variables to `{name}`.")
    }
    stop_names_must_be_unique(cnd_bullets = bullets)
  }

  vctrs::vec_c(!!tag := x, .name_spec = name_spec)
}
unique_name_spec <- function(outer, inner) {
  # For compatibily, we enumerate as "foo1", "foo2", rather than
  # "foo...1", "foo...2"
  sep <- if (is_character(inner)) "..." else ""
  paste(outer, inner, sep = sep)
}
minimal_name_spec <- function(outer, inner) {
  if (is_character(inner)) {
    paste(outer, inner, sep = "...")
  } else {
    outer
  }
}

eval_context <- function(expr, context_mask) {
  env <- context_mask$.__current__. %||% base_env()
  expr <- as_quosure(expr, env)
  eval_tidy(expr, context_mask)
}

eval_sym <- function(expr, data_mask, context_mask, strict = FALSE) {
  name <- as_string(expr)

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
    if (!is_function(value)) {
      if (strict) {
        browser()
        vctrs::vec_as_index(name, data_mask$.__tidyselect__.$internal$vars)
      } else {
        inform(glue_c(
          "Note: Using an external vector in selections is brittle.",
          i = "If the data contains `{name}` it will be selected instead.",
          i = "Use `all_of({name})` instead of `{name}` to silence this message."
        ))
      }
    }

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
