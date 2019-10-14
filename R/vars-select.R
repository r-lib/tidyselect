#' Select or rename variables
#'
#' These functions power [dplyr::select()] and [dplyr::rename()]. They
#' enable dplyr selecting or renaming semantics in your own functions.
#'
#' @section Customising error messages:
#'
#' For consistency with dplyr, error messages refer to "columns" by
#' default. This assumes that the variables being selected come from a
#' data frame. If this is not appropriate for your DSL, you can add an
#' attribute `type` to the `.vars` vector to specify alternative
#' names. This must be a character vector of length 2 whose first
#' component is the singular form and the second is the plural. For
#' example, `c("variable", "variables")`.
#'
#' @param .vars A character vector of existing column names.
#' @param ...,args Selection inputs. See the help for [selection
#'   helpers][select_helpers].
#'
#'   If you supply named inputs, the selected variables are renamed.
#'
#'   These arguments are automatically [quoted][rlang::quo] and
#'   [evaluated][rlang::eval_tidy] in a context where elements of
#'   `vars` are objects representing their positions within
#'   `vars`. They support [unquoting][rlang::quasiquotation] and
#'   splicing. See `vignette("programming")` for an introduction to
#'   these concepts.
#'
#'   Note that except for `:`, `-` and `c()`, all complex expressions
#'   are evaluated outside that context. This is to prevent accidental
#'   matching to `vars` elements when you refer to variables from the
#'   calling context.
#' @param .include,.exclude Character vector of column names to always
#'   include/exclude.
#' @param .strict If `TRUE`, will throw an error if you attempt to select or
#'   rename a variable that doesn't exist.
#'
#' @return A named character vector. Values are existing column names,
#'   names are new names.
#'
#' @section Conditions:
#'
#' `vars_select()` signals the following warning.
#'
#' * `tidyselect_warning_duplicate_renaming`: Supplying named inputs
#'   in `...` causes the variables to be renamed. For technical
#'   reasons there can only be one target name. If the same variable
#'   is renamed to different names, tidyselect issues this warning.
#'
#' `vars_select()` signals the following conditions.
#'
#' * `tidyselect_error_rename_to_same`: Renaming multiple variables to
#'   the same name is an error.
#'
#' * `tidyselect_error_rename_to_existing`: Renaming a variable to an
#'   existing name is an error.
#'
#' @seealso [vars_pull()]
#' @export
#' @keywords internal
#' @examples
#' # Keep variables
#' vars_select(names(iris), everything())
#' vars_select(names(iris), starts_with("Petal"))
#' vars_select(names(iris), ends_with("Width"))
#' vars_select(names(iris), contains("etal"))
#' vars_select(names(iris), matches(".t."))
#' vars_select(names(iris), Petal.Length, Petal.Width)
#' vars_select(names(iris), one_of("Petal.Length", "Petal.Width"))
#'
#' df <- as.data.frame(matrix(runif(100), nrow = 10))
#' df <- df[c(3, 4, 7, 1, 9, 8, 5, 2, 6, 10)]
#' vars_select(names(df), num_range("V", 4:6))
#'
#' # Drop variables
#' vars_select(names(iris), -starts_with("Petal"))
#' vars_select(names(iris), -ends_with("Width"))
#' vars_select(names(iris), -contains("etal"))
#' vars_select(names(iris), -matches(".t."))
#' vars_select(names(iris), -Petal.Length, -Petal.Width)
#'
#' # Rename variables
#' vars_select(names(iris), petal_length = Petal.Length)
#' vars_select(names(iris), petal = starts_with("Petal"))
#'
#' # Rename variables preserving all existing
#' vars_rename(names(iris), petal_length = Petal.Length)
#'
#' # You can unquote symbols or quosures
#' vars_select(names(iris), !! quote(Petal.Length))
#'
#' # And unquote-splice lists of symbols or quosures
#' vars_select(names(iris), !!! list(quo(Petal.Length), quote(Petal.Width)))
#'
#'
#' # If you want to avoid ambiguity about where to find objects you
#' # have two solutions provided by the tidy eval framework. If you
#' # want to refer to local objects, you can explicitly unquote
#' # them. They must contain variable positions (integers) or variable
#' # names (strings):
#' Species <- 2
#' vars_select(names(iris), Species)     # Picks up `Species` from the data frame
#' vars_select(names(iris), !! Species)  # Picks up the local object referring to column 2
#'
#' # If you want to make sure that a variable is picked up from the
#' # data, you can use the `.data` pronoun:
#' vars_select(names(iris), .data$Species)
#'
#'
#' # If you're writing a wrapper around vars_select(), pass the dots
#' # via splicing to avoid matching dotted arguments to vars_select()
#' # named arguments (`vars`, `include` and `exclude`):
#' wrapper <- function(...) {
#'   vars_select(names(mtcars), !!! quos(...))
#' }
#'
#' # This won't partial-match on `vars`:
#' wrapper(var = cyl)
#'
#' # This won't match on `include`:
#' wrapper(include = cyl)
#'
#'
#' # If your wrapper takes named arguments, you need to capture then
#' # unquote to pass them to vars_select(). See the vignette on
#' # programming with dplyr for more on this:
#' wrapper <- function(var1, var2) {
#'   vars_select(names(mtcars), !! enquo(var1), !! enquo(var2))
#' }
#' wrapper(starts_with("d"), starts_with("c"))
vars_select <- function(.vars, ...,
                        .include = character(),
                        .exclude = character(),
                        .strict = TRUE) {
  quos <- quos(...)

  if (!length(quos)) {
    signal("", "tidyselect_empty_dots")
    return(empty_sel(.vars, .include, .exclude))
  }

  if (!.strict) {
    quos <- ignore_unknown_symbols(.vars, quos)
  }

  ind_list <- vars_select_eval(.vars, quos)
  check_missing(ind_list, quos)

  # This takes care of NULL inputs and of ignored errors when
  # `.strict` is FALSE
  is_empty <- map_lgl(ind_list, is_null)
  ind_list <- discard(ind_list, is_empty)
  quos <- discard(quos, is_empty)

  if (is_empty(ind_list)) {
    signal("", "tidyselect_empty")
    return(empty_sel(.vars, .include, .exclude))
  }

  # If the first selector is exclusive (negative), start with all
  # columns. We need to check for symbolic `-` here because if the
  # selection is empty, `inds_combine()` cannot detect a negative
  # indice in first position.
  if (is_negated(quo_get_expr(quos[[1]]))) {
    ind_list <- c(list(seq_along(.vars)), ind_list)
  }

  check_integerish(ind_list, quos, .vars)

  incl <- inds_combine(.vars, ind_list)

  # Returned names must be unique
  sel <- set_names(.vars[incl], names(incl))

  # Include/.exclude specified variables
  if (length(.include)) {
    sel <- c(setdiff2(.include, sel), sel)
  }
  if (length(.exclude)) {
    sel <- setdiff2(sel, .exclude)
  }

  # Ensure all output .vars named
  if (is_empty(sel)) {
    signal("", "tidyselect_empty")
    names(sel) <- sel
  } else {
    unnamed <- names2(sel) == ""
    names(sel)[unnamed] <- sel[unnamed]
  }

  sel
}

ind_coerce <- function(ind) {
  if (vec_is_coercible(ind, int())) {
    return(vctrs::vec_cast(ind, int()))
  }

  if (vec_is_coercible(ind, chr())) {
    return(vctrs::vec_cast(ind, chr()))
  }

  type <- friendly_type_of(ind)
  abort(
    "Must select with column names or positions, not {type}.",
    "tidyselect_error_incompatible_index_type"
  )
}

check_missing <- function(x, exprs) {
  any_missing <- anyNA(x, recursive = TRUE)
  if (any_missing) {
    is_missing <- map_lgl(x, anyNA)
    bad <- collapse_labels(exprs[is_missing])
    abort(glue(
      "Selections can't have missing values. We detected missing elements in:
       { bad }"
    ))
  }
}

check_integerish <- function(x, exprs, vars) {
  if (!every(x, is_integerish)) {
    is_integerish <- map_lgl(x, is_integerish)
    bad <- exprs[!is_integerish]
    first <- x[!is_integerish][[1]]
    first_type <- friendly_type_of(first)
    bad_calls(bad,
      "must evaluate to { singular(vars) } positions or names, \\
       not { first_type }"
    )
  }
}

inds_combine <- function(vars, inds) {
  walk(inds, ind_check)
  first_negative <- length(inds) && length(inds[[1]]) && inds[[1]][[1]] < 0

  # Don't suffix existing duplicate with a sequential suffix
  dups <- purrr::map_lgl(inds, is_data_dups)
  spec <- function(outer, inner) {
    if (dups[[outer[[1]]]]) {
      outer
    } else {
      paste0(outer, inner)
    }
  }

  inds <- vctrs::vec_c(!!!inds, .ptype = integer(), .name_spec = spec)
  inds <- inds[inds != 0]

  if (first_negative) {
    incl <- seq_along(vars)
  } else {
    incl <- inds[inds > 0]
    incl <- inds_unique(incl, vars)
  }

  # Remove variables to be excluded (setdiff loses names)
  excl <- abs(inds[inds < 0])
  incl <- incl[is.na(match(incl, excl))]

  bad_idx <- incl > length(vars)
  if (any(bad_idx)) {
    where <- incl[which(bad_idx)]
    where <- glue::glue_collapse(where, sep = ", ", last = " and ")
    abort(glue::glue(
      "Can't select column because the data frame is too small.
       These indices are too large: { where }"
    ))
  }

  names(incl) <- names2(incl)
  unrenamed <- names(incl) == ""
  unrenamed_vars <- vars[incl[unrenamed]]

  rename_check(
    to = names(incl)[!unrenamed],
    vars = unrenamed_vars,
    orig = vars,
    incl = incl,
    dups = dups
  )

  names(incl)[unrenamed] <- unrenamed_vars
  incl
}

inds_unique <- function(x, vars) {
  # Remove duplicates but keep last name of duplicates
  split <- vctrs::vec_split(x, x)
  out <- split$key

  # Keep last name of duplicates
  if (length(out) < length(x)) {
    names(out) <- map_chr(split$val, ind_last_name, vars = vars)
  }

  out
}

ind_last_name <- function(x, vars) {
  names <- str_compact(names(x))

  if (length(names) == 0) {
    return("")
  }
  if (length(names) == 1) {
    return(names)
  }

  if (!all(vctrs::vec_duplicate_detect(names))) {
    dups <- encodeString(names, quote = "`")
    var <- encodeString(vars[[x[[1]]]], quote = "`")
    kept <- last(dups)
    dups <- glue::glue_collapse(dups, ", ", last = " and ")
    msg <- glue::glue(
      "Must rename variables to a single choice: {var} is being renamed to {dups}.
       Renaming {var} to {kept} instead."
    )
    warn(msg, "tidyselect_warning_duplicate_renaming", var = x)
  }

  last(names)
}

ind_check <- function(x) {
  if (!length(x)) {
    return(NULL)
  }

  positive <- x > 0

  if (any(positive != positive[[1]])) {
    abort("Each argument must yield either positive or negative integers.")
  }
}

rename_check <- function(to, vars, orig, incl, dups) {
  # We check that variables are renamed to a unique name but we also
  # want to allow renaming existing duplicates. We remove those from
  # the checking set here.
  if (any(dups)) {
    to <- to[!to %in% names(dups)[dups]]
  }

  if (vctrs::vec_duplicate_any(to)) {
    dups <- vctrs::vec_duplicate_detect(to)
    dups <- vctrs::vec_unique(to[dups])

    probs <- map_chr(dups, function(dup) {
      cols <- orig[incl[names(incl) == dup]]
      cols <- glue::backtick(cols)
      cols <- glue::glue_collapse(cols, sep = ", ", last = " and ")
      glue::glue("* Columns {cols} are being renamed to `{dup}`.")
    })
    msg <- paste_line(
      "Must use unique names when renaming columns.",
      !!!probs
    )

    abort(msg, "tidyselect_error_rename_to_same")
  }

  if (any(vctrs::vec_in(to, vars))) {
    dups <- vars[match(to, vars, 0L)]

    probs <- map_chr(dups, function(dup) {
      col <- orig[[incl[[dup]]]]
      glue::glue("* Column `{col}` is being renamed to existing column `{dup}`.")
    })
    msg <- paste_line(
      "Must use unique name when renaming columns.",
      !!!probs
    )

    abort(msg, "tidyselect_error_rename_to_existing")
  }
}

empty_sel <- function(vars, include, exclude) {
  vars <- setdiff(include, exclude)
  set_names(vars, vars)
}

ignore_unknown_symbols <- function(vars, quos) {
  quos <- discard(quos, is_ignored, vars)
  quos <- map_if(quos, quo_is_concat_call, call_ignore_unknown_symbols, vars)
  quos
}
call_ignore_unknown_symbols <- function(quo, vars) {
  expr <- quo_get_expr(quo)

  args <- call_args(expr)
  args <- discard(args, is_unknown_symbol, vars)
  expr <- call2(node_car(expr), !!! args)

  quo_set_expr(quo, expr)
}

is_ignored <- function(quo, vars) {
  is_unknown_symbol(quo, vars) || is_ignored_minus_call(quo, vars)
}
is_ignored_minus_call <- function(quo, vars) {
  expr <- maybe_unwrap_quosure(quo)

  if (!is_call(expr, quote(`-`), 1L)) {
    return(FALSE)
  }

  is_unknown_symbol(node_cadr(expr), vars)
}
is_unknown_symbol <- function(quo, vars) {
  expr <- maybe_unwrap_quosure(quo)

  if (!is_symbol(expr) && !is_string(expr)) {
    return(FALSE)
  }

  !as_string(expr) %in% vars
}
quo_is_concat_call <- function(quo) {
  quo_is_call(quo, quote(`c`))
}

vars_select_eval <- function(vars, quos) {
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
    data_mask$.vars <- vars

    # Add `.data` pronoun in the context mask even though it doesn't
    # contain data. This way the pronoun can be used in any parts of the
    # expression.
    context_mask <- new_data_mask(env())
    context_mask$.data <- data_mask$.data
  }

  map_if(
    quos,
    is_symbolic,
    ~ walk_data_tree(., data_mask, context_mask),
    .else = ~ as_indices(quo_get_expr(.), vars = vars)
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
    `-` = eval_minus(expr, data_mask, context_mask),
    `:` = eval_colon(expr, data_mask, context_mask),
    `c` = eval_c(expr, data_mask, context_mask),
    eval_context(expr, context_mask)
  )

  as_indices(out, vars = data_mask$.vars)
}

as_indices <- function(x, vars) {
  if (is.object(x)) {
    x <- ind_coerce(x)
  }
  if (is_character(x)) {
    match_strings(x, vars = vars)
  } else {
    x
  }
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
    return(value)
  }

  abort(glue::glue("object '{name}' not found"))
}

# This feature is in the "regret" lifecycle stage
match_strings <- function(x, vars = peek_vars()) {
  if (!is_character(x)) {
    return(x)
  }

  out <- match(x, vars)

  if (any(are_na(out) & !is.na(x))) {
    unknown <- x[are_na(out)]
    bad_unknown_vars(vars, unknown)
  }

  set_names(out, names(x))
}

setdiff2 <- function(x, y) {
  x[match(x, y, 0L) == 0L]
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
