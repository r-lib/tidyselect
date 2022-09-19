vars_select_eval <- function(vars,
                             expr,
                             strict,
                             data = NULL,
                             name_spec = NULL,
                             uniquely_named = NULL,
                             allow_rename = TRUE,
                             allow_empty = TRUE,
                             allow_predicates = TRUE,
                             type = "select",
                             error_call) {
  wrapped <- quo_get_expr2(expr, expr)

  if (is_missing(wrapped)) {
    pos <- named(int())
    check_empty(pos, allow_empty, call = error_call)
    return(pos)
  }

  uniquely_named <- uniquely_named %||% is.data.frame(data)

  if (!is_symbolic(wrapped)) {
    pos <- as_indices_sel_impl(
      wrapped,
      vars = vars,
      strict = strict,
      data = data,
      allow_predicates = allow_predicates,
      call = error_call
    )
    pos <- loc_validate(pos, vars)
    pos <- ensure_named(
      pos,
      vars,
      uniquely_named = uniquely_named,
      allow_rename = allow_rename,
      allow_empty = allow_empty,
      call = error_call
    )
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
    uniquely_named = uniquely_named,
    allow_predicates = allow_predicates,
    error_call = error_call
  )
  data_mask$.__tidyselect__.$internal <- internal

  pos <- walk_data_tree(expr, data_mask, context_mask)
  pos <- loc_validate(pos, vars, call = error_call)

  if (type == "rename" && !is_named(pos)) {
    cli::cli_abort("All renaming inputs must be named.", call = error_call)
  }

  ensure_named(
    pos,
    vars,
    uniquely_named = uniquely_named,
    allow_rename = allow_rename,
    allow_empty = allow_empty,
    call = error_call
  )
}

ensure_named <- function(pos,
                         vars,
                         uniquely_named = FALSE,
                         allow_rename = TRUE,
                         allow_empty = TRUE,
                         call = caller_env()) {
  check_empty(pos, allow_empty, call = call)

  if (!allow_rename && any(names2(pos) != "")) {
    cli::cli_abort(
      "Can't rename variables in this context.",
      class = "tidyselect:::error_disallowed_rename",
      call = call
    )
  }

  nms <- names(pos) <- names2(pos)
  nms_missing <- nms == ""
  names(pos)[nms_missing] <- vars[pos[nms_missing]]

  # Duplicates are not allowed for data frames
  if (uniquely_named) {
    vctrs::vec_as_names(names(pos), repair = "check_unique", call = call)
  }

  pos
}

check_empty <- function(x, allow_empty = TRUE, call = caller_env()) {
  if (!allow_empty && length(x) == 0) {
    cli::cli_abort("Must select at least one item.", call = call)
  }
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
    local_bindings(.__current__. = quo_get_env(expr), .env = context_mask)
    expr <- quo_get_expr2(expr, expr)
  }

  error_call <- data_mask$.__tidyselect__.$internal$error_call

  out <- switch(
    expr_kind(expr, error_call),
    literal = expr,
    symbol = eval_sym(expr, data_mask, context_mask),
    `(` = walk_data_tree(expr[[2]], data_mask, context_mask, colon = colon),
    `!` = eval_bang(expr, data_mask, context_mask),
    `-` = eval_minus(expr, data_mask, context_mask, error_call),
    `:` = eval_colon(expr, data_mask, context_mask),
    `|` = eval_or(expr, data_mask, context_mask),
    `&` = eval_and(expr, data_mask, context_mask),
    `c` = eval_c(expr, data_mask, context_mask),
    `||` = stop_bad_bool_op("||", "|", call = error_call),
    `&&` = stop_bad_bool_op("&&", "&", call = error_call),
    `*` = stop_bad_arith_op("*", call = error_call),
    `/` = eval_slash(expr, data_mask, context_mask),
    `^` = stop_bad_arith_op("^", call = error_call),
    `~` = stop_formula(expr, call = error_call),
    .data = eval(expr, data_mask),
    eval_context(expr, context_mask, call = error_call)
  )

  vars <- data_mask$.__tidyselect__.$internal$vars
  strict <- data_mask$.__tidyselect__.$internal$strict
  data <- data_mask$.__tidyselect__.$internal$data
  allow_predicates <- data_mask$.__tidyselect__.$internal$allow_predicates

  as_indices_sel_impl(
    out,
    vars = vars,
    strict = strict,
    data = data,
    allow_predicates = allow_predicates,
    call = error_call
  )
}

as_indices_sel_impl <- function(x, vars, strict, data = NULL, allow_predicates = TRUE, call) {
  if (is.function(x)) {
    if (!allow_predicates) {
      cli::cli_abort(
        "This tidyselect interface doesn't support predicates.",
        call = call,
        class = "tidyselect_error_predicates_unsupported"
      )
    }
    if (is_null(data)) {
      cli::cli_abort(
        c(
          "This tidyselect interface doesn't support predicates yet.",
          i = "Contact the package author and suggest using {.code eval_select()}."
        ),
        call = call
      )
    }
    predicate <- x

    xs <- map(data, predicate)
    for (i in seq_along(xs)) {
      check_predicate_output(xs[[i]], call = call)
    }

    x <- which(as.logical(xs))
  }

  as_indices_impl(x, vars, call = call, strict = strict)
}

check_predicate_output <- function(x, call) {
  if (!is_bool(x)) {
    cli::cli_abort(
      "Predicate must return `TRUE` or `FALSE`, not {obj_type_friendly(x)}.",
      call = call
    )
  }
}

as_indices_impl <- function(x, vars, strict, call = caller_env()) {
  if (is_null(x)) {
    return(int())
  }

  x <- vctrs::vec_as_subscript(x, logical = "error", call = call)

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

  switch(
    typeof(x),
    character = chr_as_locations(x, vars, call = call),
    double = ,
    integer = x,
    cli::cli_abort("Unexpected type.", .internal = TRUE)
  )
}

chr_as_locations <- function(x, vars, call = caller_env()) {
  out <- vctrs::vec_as_location(
    x,
    n = length(vars),
    names = vars,
    call = call
  )
  set_names(out, names(x))
}

as_indices <- function(x, vars, strict = TRUE, call) {
  inds <- with_subscript_errors(as_indices_impl(x, vars, strict, call))
  vctrs::vec_as_location(inds, length(vars), vars, convert_values = NULL)
}

expr_kind <- function(expr, error_call) {
  switch(
    typeof(expr),
    symbol = "symbol",
    language = call_kind(expr, error_call),
    "literal"
  )
}
call_kind <- function(expr, error_call) {
  head <- node_car(expr)
  if (!is_symbol(head)) {
    return("call")
  }

  fn <- as_string(head)

  if (fn %in% c("$", "[[") && identical(expr[[2]], quote(.data))) {
    validate_dot_data(expr, error_call)

    what <- I("Use of .data in tidyselect expressions")
    if (fn == "$") {
      var <- as_string(expr[[3]])
      str <- encodeString(var, quote = '"')

      lifecycle::deprecate_warn("1.2.0", what,
        details = glue("Please use `{str}` instead of `data${var}`")
      )
    } else if (fn == "[[") {
      var <- expr_deparse(expr[[3]])
      lifecycle::deprecate_soft("1.2.0", what,
        details = glue("Please use `all_of({var}) (or `any_of({var}) instead of `.data[[{var}]]`")
      )
    }

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
    error_call <- mask_error_call(data_mask)
    sel_complement(out, vars, error_call = error_call)
  } else {
    x <- walk_data_tree(expr[[2]], data_mask, context_mask, colon = TRUE)
    y <- walk_data_tree(expr[[3]], data_mask, context_mask, colon = TRUE)
    x:y
  }
}

eval_minus <- function(expr, data_mask, context_mask, call = call) {
  if (length(expr) == 2) {
    eval_bang(expr, data_mask, context_mask)
  } else {
    eval_context(expr, context_mask, call = call)
  }
}

eval_slash <- function(expr, data_mask, context_mask) {
  lhs <- walk_data_tree(expr[[2]], data_mask, context_mask)
  rhs <- walk_data_tree(expr[[3]], data_mask, context_mask)

  vars <- data_mask$.__tidyselect__.$internal$vars
  error_call <- mask_error_call(data_mask)

  sel_diff(lhs, rhs, vars, error_call = error_call)
}

eval_context <- function(expr, context_mask, call) {
  env <- context_mask$.__current__. %||% base_env()
  with_chained_errors(
    eval_tidy(as_quosure(expr, env), context_mask),
    call = call,
    eval_expr = expr
  )
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
      cli::cli_warn(
        c(
          "Predicate functions must be wrapped in `where()`.",
          "",
          " " = "  # Bad",
          " " = "  data %>% select({name})",
          " " = "",
          " " = "  # Good",
          " " = "  data %>% select(where({name}))",
          "",
          i = "Please update your code."
        ),
        .frequency = "regularly",
        .frequency_id = paste0("tidyselect::predicate_warn_", name)
      )
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
    msg <- c(
      "Note: Using an external vector in selections is ambiguous.",
      i = "Use `all_of({name})` instead of `{name}` to silence this message.",
      i = "See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>."
    )
    id <- paste0("tidyselect::strict_lookup_", name)

    if (is_string(verbosity, "verbose")) {
      cli::cli_inform(msg)
    } else {
      cli::cli_inform(msg, .frequency = "regularly", .frequency_id = id)
    }
  }

  value
}

validate_dot_data <- function(expr, call) {
  if (is_call(expr, "$") && !is_symbol(expr[[3]])) {
    cli::cli_abort(
      "The RHS of {.code .data$rhs} must be a symbol.",
      call = call
    )
  }
  if (is_call(expr, "[[") && is_symbolic(expr[[3]])) {
    cli::cli_abort(
      "The subscript of {.code .data[[subscript]]} must be a constant.",
      call = call
    )
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
