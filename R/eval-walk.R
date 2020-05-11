
vars_select_eval <- function(vars,
                             expr,
                             strict,
                             data = NULL,
                             name_spec = NULL,
                             uniquely_named = NULL,
                             allow_rename = TRUE,
                             type = "select") {
  wrapped <- quo_get_expr2(expr, expr)

  if (is_missing(wrapped)) {
    return(named(int()))
  }

  uniquely_named <- uniquely_named %||% is.data.frame(data)

  if (!is_symbolic(wrapped)) {
    pos <- as_indices_sel_impl(wrapped, vars = vars, strict = strict, data = data)
    pos <- loc_validate(pos, vars)
    pos <- ensure_named(pos, vars, uniquely_named, allow_rename)
    return(pos)
  }

  vars <- peek_vars()

  vars_split <- vctrs::vec_split(seq_along(vars), vars)

  # Mark data duplicates so we can fail instead of disambiguating them
  # when renaming
  if (uniquely_named) {
    vars_split$val <- map(vars_split$val, mark_data_dups)
  }

  # We are intentionally lenient towards partially named inputs
  vars_split <- vctrs::vec_slice(vars_split, !are_empty_name(vars_split$key))

  top <- env()
  bottom <- env(top, !!!set_names(vars_split$val, vars_split$key))
  data_mask <- new_data_mask(bottom, top)
  data_mask$.data <- as_data_pronoun(data_mask)

  context_mask <- new_data_mask(env(!!!vars_select_helpers))

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
  pos <- loc_validate(pos, vars)

  if (type == "rename" && !is_named(pos)) {
    abort("All renaming inputs must be named.")
  }

  ensure_named(pos, vars, uniquely_named, allow_rename)
}

ensure_named <- function(pos, vars, uniquely_named, allow_rename) {
  if (!allow_rename) {
    if (is_named(pos)) {
      abort("Can't rename variables in this context.")
    }
    return(set_names(pos, NULL))
  }

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
    `*` = stop_bad_arith_op("*"),
    `/` = eval_slash(expr, data_mask, context_mask),
    `^` = stop_bad_arith_op("^"),
    `~` = stop_formula(expr),
    .data = eval(expr, data_mask),
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
        i = "Contact the package author and suggest using `eval_select()`."
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

  x <- vctrs::vec_as_subscript(x, logical = "error")

  if (!strict) {
    # Remove out-of-bounds elements if non-strict. We do this eagerly
    # because names vectors must be converted to locations here.
    x <- switch(typeof(x),
      character = set_intersect(x, c(vars, na_chr)),
      double = ,
      integer = x[x <= length(vars)],
      x
    )
  }

  switch(typeof(x),
    character = chr_as_locations(x, vars),
    double = ,
    integer = x,
    abort("Internal error: Unexpected type in `as_indices()`.")
  )
}

chr_as_locations <- function(x, vars) {
  out <- vctrs::vec_as_location(x, n = length(vars), names = vars)
  set_names(out, names(x))
}

as_indices <- function(x, vars, strict = TRUE) {
  inds <- with_subscript_errors(as_indices_impl(x, vars, strict))
  vctrs::vec_as_location(inds, length(vars), vars, convert_values = NULL)
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

  if (fn %in% c("$", "[[") && identical(node_cadr(expr), quote(.data))) {
    validate_dot_data(expr)
    return(".data")
  }

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
    `~` = ,
    `c` = fn,
    "call"
  )
}

eval_colon <- function(expr, data_mask, context_mask) {
  if (is_negated_colon(expr)) {
    # Compatibility syntax for `-1:-2`. We interpret it as `-(1:2)`.
    out <- eval_colon(unnegate_colon(expr), data_mask, context_mask)
    vars <- data_mask$.__tidyselect__.$internal$vars
    sel_complement(out, vars)
  } else {
    x <- walk_data_tree(expr[[2]], data_mask, context_mask, colon = TRUE)
    y <- walk_data_tree(expr[[3]], data_mask, context_mask, colon = TRUE)
    x:y
  }
}

eval_minus <- function(expr, data_mask, context_mask) {
  if (length(expr) == 2) {
    eval_bang(expr, data_mask, context_mask)
  } else {
    eval_context(expr, context_mask)
  }
}

eval_slash <- function(expr, data_mask, context_mask) {
  lhs <- walk_data_tree(expr[[2]], data_mask, context_mask)
  rhs <- walk_data_tree(expr[[3]], data_mask, context_mask)
  vars <- data_mask$.__tidyselect__.$internal$vars

  sel_diff(lhs, rhs, vars)
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

  env <- context_mask$.__current__.
  value <- env_get(env, name, default = missing_arg(), inherit = TRUE)

  # Cause OOB error
  if (is_missing(value)) {
    return(name)
  }

  # Predicate functions must now be wrapped in `where()`. We'll
  # support functions starting with `is` for compatibility for
  # compatibility.
  if (is_function(value)) {
    if (!grepl("^is", name)) {
      return(name)
    }

    if (!is_string(verbosity(), "quiet")) {
      msg <- paste_line(c(
        "Predicate functions must be wrapped in `where()`.",
        "",
        "  # Bad",
        glue::glue("  data %>% select({name})"),
        "",
        "  # Good",
        glue::glue("  data %>% select(where({name}))"),
        ""
      ))
      bullet <- format_error_bullets(c(i = "Please update your code."))

      warn_once(paste_line(msg, bullet))
    }

    return(value)
  }

  # Cause OOB error
  if (strict) {
    return(name)
  }

  verbosity <- verbosity()

  if (!is_string(verbosity, "quiet") && env_needs_advice(env)) {
    # Please keep in sync with faq.R.
    msg <- glue_c(
      "Note: Using an external vector in selections is ambiguous.",
      i = "Use `all_of({name})` instead of `{name}` to silence this message.",
      i = "See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>."
    )
    id <- paste0("strict_lookup_", name)

    if (is_string(verbosity, "verbose")) {
      inform(msg)
    } else {
      inform_once(msg, id)
    }
  }

  value
}

validate_dot_data <- function(expr) {
  if (is_call(expr, "$") && !is_symbol(expr[[3]])) {
    abort("The RHS of `.data$rhs` must be a symbol.")
  }
  if (is_call(expr, "[[") && is_symbolic(expr[[3]])) {
    abort("The subscript of `.data[[subscript]]` must be a constant.")
  }
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
