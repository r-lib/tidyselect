
eval_c <- function(expr, data_mask, context_mask) {
  expr <- call_expand_dots(expr, context_mask$.__current__.)
  expr <- node_compact_missing(expr)
  node <- node_cdr(expr)

  # If the first selector is exclusive (negative), start with all
  # columns. `-foo` is syntax for `everything() - foo`.
  if (c_arg_kind(node_car(node)) %in% c("diff", "diff_colon")) {
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

  kind <- c_arg_kind(car)
  car <- switch(kind,
    diff = unnegate(car),
    diff_colon = unnegate_colon(car),
    car
  )

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

  if (kind == "union") {
    sel_union(lhs, out)
  } else {
    vars <- data_mask$.__tidyselect__.$internal$vars
    sel_diff(lhs, out, vars)
  }
}

c_arg_kind <- function(x) {
  expr <- quo_get_expr2(x, x)

  if (is_negated(x)) {
    "diff"
  } else if (is_negated_colon(x)) {
    "diff_colon"
  } else {
    "union"
  }
}

unnegate <- function(x) {
  expr <- quo_get_expr2(x, x)
  expr <- node_cadr(expr)

  if (is_quosure(expr)) {
    expr
  } else if (is_quosure(x)) {
    quo_set_expr(x, expr)
  } else {
    expr
  }
}
unnegate_colon <- function(x) {
  expr <- quo_get_expr2(x, x)

  expr[[2]] <- unnegate(expr[[2]])
  expr[[3]] <- unnegate(expr[[3]])

  quo_set_expr2(x, expr, expr)
}

is_negated <- function(x) {
  expr <- quo_get_expr2(x, x)
  is_call(expr, "-", n = 1)
}
is_negated_colon <- function(x) {
  expr <- quo_get_expr2(x, x)
  is_call(expr, ":") && is_negated(expr[[2]]) && is_negated(expr[[3]])
}

combine_names <- function(x, tag, name_spec, uniquely_named) {
  if (uniquely_named && is_data_dups(x)) {
    bullets <- function(cnd, ...) {
      name <- as_string(tag)
      glue_bullet(x = "Can't rename duplicate variables to `{name}`.")
    }
    stop_names_must_be_unique(body = bullets)
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
