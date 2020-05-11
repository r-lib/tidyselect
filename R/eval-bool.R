
eval_bang <- function(expr, data_mask, context_mask) {
  x <- walk_data_tree(expr[[2]], data_mask, context_mask)

  vars <- data_mask$.__tidyselect__.$internal$vars
  sel_complement(x, vars)
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

  sel_intersect(x, y)
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

stop_formula <- function(expr) {
  f <- as_label(expr)

  abort(glue_line(c(
    "Formula shorthand must be wrapped in `where()`.",
    "",
    "  # Bad",
    "  data %>% select({f})",
    "",
    "  # Good",
    "  data %>% select(where({f}))"
  )))
}
