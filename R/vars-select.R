#' Select or rename variables
#'
#' These functions power [dplyr::select()] and [dplyr::rename()]. They
#' enable dplyr selecting or renaming semantics in your own functions.
#'
#' @section Context of evaluation:
#'
#' Quoting verbs usually support references to both objects from the
#' data frame and objects from the calling context. Selecting verbs
#' behave a bit differently.
#'
#' * Bare names are evaluated in the data frame only. You cannot refer
#'   to local objects unless you explicitly unquote them with `!!`.
#'
#' * Calls to helper functions are evaluated in the calling context
#'   only. You can safely and directly refer to local objects.
#'
#'
#' @section Customising error messages:
#'
#' For consistency with dplyr, error messages refer to "columns" by
#' default. This assumes that the variables being selected come from a
#' data frame. If this is not appropriate for your DSL, you can add an
#' attribute `vars_type` to the `.vars` vector to specify alternative
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
#' # When selecting with bare symbols, you can only refer to data
#' # objects. This avoids ambiguity. If you want to refer to local
#' # objects, you can explicitly unquote them. They must contain
#' # variable positions (integers) or variable names (strings):
#' Species <- 2
#' vars_select(names(iris), Species)     # Picks up `Species` from the data frame
#' vars_select(names(iris), !! Species)  # Picks up the local object referring to column 2
#'
#' # On the other hand, function calls behave the opposite way. They
#' # are evaluated in the local context only and cannot refer to data
#' # frame objects. This makes it easy to refer to local variables:
#' x <- "Petal"
#' vars_select(names(iris), starts_with(x))  # Picks up the local variable `x`
#'
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

  # Register vars to make them available to select helpers
  scoped_vars(.vars)

  # if the first selector is exclusive (negative), start with all columns
  first <- f_rhs(quos[[1]])
  initial_case <- if (is_negated(first)) list(seq_along(.vars)) else integer(0)

  # Evaluate symbols in an environment where columns are bound, but
  # not calls (select helpers are scoped in the calling environment).
  is_helper <- map_lgl(quos, quo_is_helper)
  ind_list <- map_if(quos, is_helper, eval_tidy)

  data <- set_names(as.list(seq_along(.vars)), .vars)
  ind_list <- map_if(ind_list, !is_helper, eval_tidy, data)

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
    cnd_signal("tidyselect_empty", .mufflable = FALSE)
    names(sel) <- sel
  } else {
    unnamed <- names2(sel) == ""
    names(sel)[unnamed] <- sel[unnamed]
  }

  sel
}

extract_expr <- function(expr) {
  expr <- get_expr(expr)
  while(is_lang(expr, paren_sym)) {
    expr <- get_expr(expr[[2]])
  }
  expr
}

quo_is_helper <- function(quo) {
  expr <- extract_expr(quo)

  if (!is_lang(expr)) {
    return(FALSE)
  }

  if (is_data_pronoun(expr)) {
    return(FALSE)
  }

  if (is_lang(expr, minus_sym, n = 1)) {
    operand <- extract_expr(expr[[2]])
    return(quo_is_helper(operand))
  }

  if (is_lang(expr, list(colon_sym, c_sym))) {
    return(FALSE)
  }

  TRUE
}
match_var <- function(chr, table) {
  pos <- match(chr, table)
  if (any(are_na(pos))) {
    chr <- glue::collapse(chr[are_na(pos)], ", ")
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
