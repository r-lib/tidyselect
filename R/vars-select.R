#' Select variables
#'
#' These functions power [dplyr::select()] and [dplyr::rename()].
#'
#' For historic reasons, the `vars` and `include` arguments are not
#' prefixed with `.`. This means that any argument starting with `v`
#' might partial-match on `vars` if it is not explicitly named. Also
#' `...` cannot accept arguments named `exclude` or `include`. You can
#' enquose and splice the dots to work around these limitations (see
#' examples).
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
#' # You can unquote names or formulas (or lists of)
#' vars_select(names(iris), !!! list(quo(Petal.Length)))
#' vars_select(names(iris), !! quote(Petal.Length))
#'
#' # The .data pronoun is available:
#' vars_select(names(mtcars), .data$cyl)
#' vars_select(names(mtcars), .data$mpg : .data$disp)
#'
#' # However it isn't available within calls since those are evaluated
#' # outside of the data context. This would fail if run:
#' # vars_select(names(mtcars), identical(.data$cyl))
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
vars_select <- function(.vars, ..., .include = character(), .exclude = character()) {
  quos <- quos(...)

  if (is_empty(quos)) {
    .vars <- setdiff(.include, .exclude)
    return(set_names(.vars, .vars))
  }

  # Set current_vars so available to select_helpers
  old <- set_current_vars(.vars)
  on.exit(set_current_vars(old), add = TRUE)

  # The symbol overscope. Subsetting operators allow to subset the
  # .data pronoun.
  syms_overscope_top <- child_env(NULL,
    `$` = base::`$`,
    `[[` = base::`[[`,
    `-` = base::`-`,
    `:` = base::`:`,
    c = base::c
  )
  # Map variable names to their positions: this keeps integer semantics
  syms_overscope_data <- set_names(as.list(seq_along(.vars)), .vars)
  syms_overscope <- as_env(syms_overscope_data, syms_overscope_top)
  syms_overscope <- child_env(syms_overscope, .data = syms_overscope_data)
  syms_overscope <- new_overscope(syms_overscope, syms_overscope_top)

  # if the first selector is exclusive (negative), start with all columns
  first <- f_rhs(quos[[1]])
  initial_case <- if (is_negated(first)) list(seq_along(.vars)) else integer(0)

  # Evaluate symbols in an environment where columns are bound, but
  # not calls (select helpers are scoped in the calling environment).
  is_helper <- map_lgl(quos, quo_is_helper)
  quos <- map_if(quos, !is_helper, set_env, empty_env())
  ind_list <- map_if(quos, is_helper, eval_tidy)
  ind_list <- map_if(ind_list, !is_helper, overscope_eval_next, overscope = syms_overscope)

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
      "must resolve to integer column positions, not {first_type}"
    )
  }

  incl <- inds_combine(.vars, ind_list)

  # Include/.exclude specified variables
  sel <- set_names(.vars[incl], names(incl))
  sel <- c(setdiff2(.include, sel), sel)
  sel <- setdiff2(sel, .exclude)

  # Ensure all output .vars named
  if (is_empty(sel)) {
    names(sel) <- sel
  } else {
    unnamed <- names2(sel) == ""
    names(sel)[unnamed] <- sel[unnamed]
  }

  sel
}

quo_is_helper <- function(quo) {
  expr <- f_rhs(quo)

  if (!is_lang(expr)) {
    return(FALSE)
  }

  if (is_data_pronoun(expr)) {
    return(FALSE)
  }

  if (is_lang(expr, quote(`-`), n = 1)) {
    return(!is_symbol(get_expr(expr[[2]])))
  }

  if (is_lang(expr, list(quote(`:`), quote(c)))) {
    return(FALSE)
  }

  TRUE
}
match_var <- function(chr, table) {
  pos <- match(chr, table)
  if (any(are_na(pos))) {
    chr <- glue::collapse(chr[are_na(pos)], ", ")
    abort(glue("Strings must match column names. Unkown columns: {chr}"))
  }
  pos
}

setdiff2 <- function(x, y) {
  x[match(x, y, 0L) == 0L]
}

#' @export
#' @rdname vars_select
#' @param .strict If `TRUE`, will throw an error if you attempt to rename a
#'   variable that doesn't exist.
vars_rename <- function(.vars, ..., .strict = TRUE) {
  exprs <- exprs(...)
  if (any(names2(exprs) == "")) {
    abort("All arguments must be named")
  }

  old_vars <- map2(exprs, names(exprs), switch_rename)
  new_vars <- names(exprs)

  unknown_vars <- setdiff(old_vars, .vars)
  if (.strict && length(unknown_vars) > 0) {
    bad_args(unknown_vars, "contains unknown variables")
  }

  select <- set_names(.vars, .vars)
  names(select)[match(old_vars, .vars)] <- new_vars

  select
}

# FIXME: that's not a tidy implementation yet because we need to
# handle non-existing symbols silently when `strict = FALSE`
switch_rename <- function(expr, name) {
  switch_type(expr,
    string = ,
    symbol =
      return(as_string(expr)),
    language =
      if (is_data_pronoun(expr)) {
        args <- node_cdr(expr)
        return(switch_rename(node_cadr(args)))
      } else {
        abort("Expressions are currently not supported in `rename()`")
      }
  )

  actual_type <- friendly_type(type_of(expr))
  named_call <- ll(!! name := expr)
  bad_named_calls(named_call, "must be a symbol or a string, not {actual_type}")
}
