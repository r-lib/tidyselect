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
                             error_arg = NULL,
                             error_call) {
  wrapped <- quo_get_expr2(expr, expr)

  if (is_missing(wrapped)) {
    pos <- named(int())
    check_empty(pos, allow_empty, error_arg, call = error_call)
    return(pos)
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
    error_arg = error_arg,
    call = error_call
  )
}

ensure_named <- function(pos,
                         vars,
                         uniquely_named = FALSE,
                         allow_rename = TRUE,
                         allow_empty = TRUE,
                         error_arg = NULL,
                         call = caller_env()) {
  check_empty(pos, allow_empty, error_arg, call = call)

  if (!allow_rename && any(names2(pos) != "")) {
    if (is.null(error_arg)) {
      i <- NULL
    } else {
      i <- cli::format_inline("In argument: {.arg {error_arg}}.")
    }
    abort(
      c(
        "Can't rename variables in this context.",
        i = i
      ),
      class = "tidyselect_error_cannot_rename",
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

check_empty <- function(x, allow_empty = TRUE, error_arg = NULL, call = caller_env()) {
  if (!allow_empty && length(x) == 0) {
    if (is.null(error_arg)) {
      msg <- "Must select at least one item."
    } else {
      msg <- cli::format_inline("{.arg {error_arg}} must select at least one column.")
    }
    cli::cli_abort(
      "{msg}",
      call = call,
      class = "tidyselect_error_empty_selection"
    )
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
    expr_kind(expr, context_mask, error_call),
    literal = eval_literal(expr, data_mask, context_mask),
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
    call = error_call,
    arg = as_label(expr)
  )
}

as_indices_sel_impl <- function(x,
                                vars,
                                strict,
                                data = NULL,
                                allow_predicates = TRUE,
                                call,
                                arg = NULL) {
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

  as_indices_impl(x, vars, call = call, arg = arg, strict = strict)
}

check_predicate_output <- function(x, call) {
  if (!is_bool(x)) {
    cli::cli_abort(
      "Predicate must return `TRUE` or `FALSE`, not {obj_type_friendly(x)}.",
      call = call
    )
  }
}

as_indices_impl <- function(x, vars, strict, call = caller_env(), arg = NULL) {
  if (is_null(x)) {
    return(int())
  }

  x <- vctrs::vec_as_subscript(
    x,
    logical = "error",
    call = call,
    arg = arg
  )

  if (!strict) {
    # Remove out-of-bounds elements if non-strict. We do this eagerly
    # because names vectors must be converted to locations here.
    x <- switch(typeof(x),
      character = vctrs::vec_set_intersect(x, c(vars, na_chr)),
      double = ,
      integer = x[x <= length(vars)],
      x
    )
  }

  switch(
    typeof(x),
    character = chr_as_locations(x, vars, call = call, arg = arg),
    double = ,
    integer = x,
    cli::cli_abort("Unexpected type.", .internal = TRUE)
  )
}

chr_as_locations <- function(x, vars, call = caller_env(), arg = NULL) {
  out <- vctrs::vec_as_location(
    x,
    n = length(vars),
    names = vars,
    call = call,
    arg = arg
  )
  set_names(out, names(x))
}

expr_kind <- function(expr, context_mask, error_call) {
  switch(
    typeof(expr),
    symbol = "symbol",
    language = call_kind(expr, context_mask, error_call),
    "literal"
  )
}
call_kind <- function(expr, context_mask, error_call) {
  head <- node_car(expr)
  if (!is_symbol(head)) {
    return("call")
  }

  env <- context_mask$.__current__.
  fn <- as_string(head)

  if (fn %in% c("$", "[[") && identical(expr[[2]], quote(.data))) {
    check_dot_data(expr, env = env, error_call = error_call)
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

eval_literal <- function(expr, data_mask, context_mask) {
  internal <- data_mask$.__tidyselect__.$internal

  if (internal$uniquely_named && is_character(expr)) {
    # Since tidyselect allows repairing data frames with duplicate names by
    # renaming or selecting positions, we can't check the input for duplicates.
    # Instead, we check the output. But in case of character literals, checking
    # the output doesn't work because we use `vctrs::vec_as_location()` to
    # transform the strings to locations and it ignores duplicate names. So we
    # instead check the input here, since it's not possible to repair duplicate
    # names by matching them by name. This avoids an inconsistency with the
    # symbolic path (#346).
    vctrs::vec_as_names(
      internal$vars,
      repair = "check_unique",
      call = internal$error_call
    )
 }

  expr
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
      # TODO: Remove unnecessary `default` specification after
      # https://github.com/r-lib/rlang/issues/1582
      value <- env_get(cur, name, default = NULL)
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

    # Formally deprecated in 1.2.0
    lifecycle::deprecate_soft("1.1.0",
      what = I("Use of bare predicate functions"),
      with = I("`where()` to wrap predicate functions"),
      user_env = env
    )

    return(value)
  }

  # Cause OOB error
  if (strict) {
    return(name)
  }

  # Formally deprecated in 1.2.0
  lifecycle::deprecate_soft("1.1.0",
    I("Using an external vector in selections"),
    I("`all_of()` or `any_of()`"),
    details = "See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.",
    user_env = env
  )

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
