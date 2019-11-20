
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
    vars <- data_mask$.__tidyselect__.$internal$vars
    sel_diff(lhs, out, vars)
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
