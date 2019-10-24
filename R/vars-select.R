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
vars_select <- function(.vars,
                        ...,
                        .include = character(),
                        .exclude = character(),
                        .strict = TRUE) {
  scoped_vars(.vars)

  dots <- enquos(...)
  if (!length(dots)) {
    signal("", "tidyselect_empty_dots")
    return(empty_sel(.vars, .include, .exclude))
  }

  idx <- select_impl(
    NULL,
    !!!dots,
    .include = .include,
    .exclude = .exclude,
    .strict = .strict
  )

  sel <- set_names(.vars[idx], names(idx))

  # Ensure all output are named, with `.vars` as default
  if (is_empty(sel)) {
    signal("", "tidyselect_empty")
    names(sel) <- chr()
  } else {
    unnamed <- names2(sel) == ""
    names(sel)[unnamed] <- sel[unnamed]
  }

  sel
}

empty_sel <- function(vars, include, exclude) {
  vars <- setdiff(include, exclude)
  set_names(vars, vars)
}
