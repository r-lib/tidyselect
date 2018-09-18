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
#' @param ...,args Expressions to compute
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
#' @param .strict If `FALSE`, errors about unknown columns are ignored.
#' @seealso [vars_pull()]
#' @export
#' @keywords internal
#' @return A named character vector. Values are existing column names,
#'   names are new names.
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

  if (!.strict) {
    quos <- ignore_unknown_symbols(.vars, quos)
  }

  ind_list <- vars_select_eval(.vars, quos)

  # This takes care of NULL inputs and of ignored errors when
  # `.strict` is FALSE
  is_empty <- map_lgl(ind_list, is_null)
  ind_list <- discard(ind_list, is_empty)
  quos <- discard(quos, is_empty)

  if (is_empty(ind_list)) {
    .vars <- setdiff(.include, .exclude)
    return(set_names(.vars, .vars))
  }

  # if the first selector is exclusive (negative), start with all columns
  first <- quo_get_expr(quos[[1]])
  initial_case <- if (is_negated(first)) list(seq_along(.vars)) else integer(0)

  ind_list <- c(initial_case, ind_list)
  names(ind_list) <- c(names2(initial_case), names2(quos))

  # Match strings to variable positions
  ind_list <- map_if(ind_list, is_character, match_var, table = .vars)

  is_integerish <- map_lgl(ind_list, is_integerish)
  if (any(!is_integerish)) {
    bad <- quos[!is_integerish]
    first <- ind_list[!is_integerish][[1]]
    first_type <- friendly_type(type_of(first))
    bad_calls(bad,
      "must evaluate to { singular(.vars) } positions or names, \\
       not { first_type }"
    )
  }

  incl <- inds_combine(.vars, ind_list)

  # Include/.exclude specified variables
  sel <- set_names(.vars[incl], names(incl))
  sel <- c(setdiff2(.include, sel), sel)
  sel <- setdiff2(sel, .exclude)

  # Ensure all output .vars named
  if (is_empty(sel)) {
    signal("", "tidyselect_empty", .mufflable = FALSE)
    names(sel) <- sel
  } else {
    unnamed <- names2(sel) == ""
    names(sel)[unnamed] <- sel[unnamed]
  }

  sel
}

ignore_unknown_symbols <- function(vars, quos) {
  quos <- discard(quos, is_ignored, vars)
  quos <- map_if(quos, is_concat_lang, lang_ignore_unknown_symbols, vars)
  quos
}
lang_ignore_unknown_symbols <- function(quo, vars) {
  expr <- get_expr(quo)

  args <- call_args(expr)
  args <- discard(args, is_unknown_symbol, vars)
  expr <- call2(node_car(expr), !!! args)

  set_expr(quo, expr)
}

is_ignored <- function(quo, vars) {
  is_unknown_symbol(quo, vars) || is_ignored_minus_call(quo, vars)
}
is_ignored_minus_call <- function(quo, vars) {
  expr <- get_expr(quo)

  if (!is_call(expr, quote(`-`), 1L)) {
    return(FALSE)
  }

  is_unknown_symbol(node_cadr(expr), vars)
}
is_unknown_symbol <- function(quo, vars) {
  expr <- get_expr(quo)

  if (!is_symbol(expr) && !is_string(expr)) {
    return(FALSE)
  }

  !as_string(expr) %in% vars
}
is_concat_lang <- function(quo) {
  quo_is_call(quo, quote(`c`))
}

vars_select_eval <- function(vars, quos) {
  scoped_vars(vars)

  # Peek validated variables
  vars <- peek_vars()

  # Overscope `c`, `:` and `-` with versions that handle strings
  data_helpers_env <- env(`:` = vars_colon, `-` = vars_minus, `c` = vars_c)

  # Symbols and calls to `:` and `c()` are evaluated with data in scope
  is_helper <- map_lgl(quos, quo_is_helper)
  are_name <- are_name(vars)
  data <- set_names(as.list(seq_along(vars)), vars)[!are_name]
  data_env <- env(data_helpers_env, !!!data)

  mask <- new_data_mask(data_env, data_helpers_env)
  mask$.data <- as_data_pronoun(data)

  ind_list <- map_if(quos, !is_helper, eval_tidy, mask)

  # All other calls are evaluated in the context only
  # They are always evaluated strictly
  ind_list <- map_if(ind_list, is_helper, eval_tidy)

  # Handle unquoted character vectors
  ind_list <- map_if(ind_list, is_character, match_strings, names = TRUE)

  ind_list
}

vars_colon <- function(x, y) {
  if (is_string(x)) {
    x <- match_strings(x)
  }
  if (is_string(y)) {
    y <- match_strings(y)
  }

  x:y
}
vars_minus <- function(x, y) {
  if (!missing(y)) {
    return(x - y)
  }

  if (is_character(x)) {
    x <- match_strings(x)
  }

  -x
}
vars_c <- function(...) {
  dots <- map_if(list(...), is_character, match_strings)
  do.call(`c`, dots)
}
match_strings <- function(x, names = FALSE) {
  vars <- peek_vars()
  out <- match(x, vars)

  if (any(are_na(out))) {
    unknown <- x[are_na(out)]
    bad_unknown_vars(vars, unknown)
  }

  if (names) {
    set_names(out, names(x))
  } else {
    out
  }
}

extract_expr <- function(expr) {
  expr <- get_expr(expr)
  while(is_call(expr, paren_sym)) {
    expr <- get_expr(expr[[2]])
  }
  expr
}

quo_is_helper <- function(quo) {
  expr <- extract_expr(quo)

  if (!is_call(expr)) {
    return(FALSE)
  }

  if (is_data_pronoun(expr)) {
    return(FALSE)
  }

  if (is_call(expr, minus_sym, n = 1)) {
    operand <- extract_expr(expr[[2]])
    return(quo_is_helper(operand))
  }

  if (is_call(expr, list(colon_sym, c_sym))) {
    return(FALSE)
  }

  TRUE
}
match_var <- function(chr, table) {
  pos <- match(chr, table)
  if (any(are_na(pos))) {
    chr <- glue::glue_collapse(chr[are_na(pos)], ", ")
    abort(glue(
      "Strings must match { singular(table) } names. \\
       Unknown { plural(table) }: { chr }"
    ))
  }
  pos
}

setdiff2 <- function(x, y) {
  x[match(x, y, 0L) == 0L]
}
