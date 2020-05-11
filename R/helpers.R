#' Selection language
#'
#' @description
#'
#' ## Overview of selection features:
#'
#' ```{r, child = identity("man/rmd/overview.Rmd")}
#' ```
#'
#' @section Simple examples:
#'
#' ```{r, child = "man/rmd/setup.Rmd"}
#' ```
#'
#' Here we show the usage for the basic selection operators. See the
#' specific help pages to learn about helpers like [starts_with()].
#'
#' The selection language can be used in functions like
#' `dplyr::select()` or `tidyr::pivot_longer()`. Let's first attach
#' the tidyverse:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' library(tidyverse)
#'
#' # For better printing
#' iris <- as_tibble(iris)
#' ```
#'
#' Select variables by name:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' starwars %>% select(height)
#'
#' iris %>% pivot_longer(Sepal.Length)
#' ```
#'
#' Select multiple variables by separating them with commas. Note how
#' the order of columns is determined by the order of inputs:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' starwars %>% select(homeworld, height, mass)
#' ```
#'
#' Functions like `tidyr::pivot_longer()` don't take variables with
#' dots. In this case use `c()` to select multiple variables:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% pivot_longer(c(Sepal.Length, Petal.Length))
#' ```
#'
#' ## Operators:
#'
#' The `:` operator selects a range of consecutive variables:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' starwars %>% select(name:mass)
#' ```
#'
#' The `!` operator negates a selection:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' starwars %>% select(!(name:mass))
#'
#' iris %>% select(!c(Sepal.Length, Petal.Length))
#'
#' iris %>% select(!ends_with("Width"))
#' ```
#'
#' `&` and `|` take the intersection or the union of two selections:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(starts_with("Petal") & ends_with("Width"))
#'
#' iris %>% select(starts_with("Petal") | ends_with("Width"))
#' ```
#'
#' To take the difference between two selections, combine the `&` and
#' `!` operators:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(starts_with("Petal") & !ends_with("Width"))
#' ```
#'
#' @section Details:
#' The order of selected columns is determined by the inputs.
#'
#' * `all_of(c("foo", "bar"))` selects `"foo"` first.
#'
#' * `c(starts_with("c"), starts_with("d"))` selects all columns
#'   starting with `"c"` first, then all columns starting with `"d"`.
#'
#' @name language
#' @aliases select_helpers
NULL


#' Superseded selection helpers
#'
#' `one_of()` is superseded in favour of the more precise [any_of()] and
#' [all_of()] selectors.
#'
#' @param ... One or more character vectors.
#' @param .vars A character vector of variable names. When called
#'   from inside selecting functions like [dplyr::select()] these are
#'   automatically set to the names of the table.
#'
#' @keywords internal
#' @export
one_of <- function(..., .vars = NULL) {
  .vars <- .vars %||% peek_vars(fn = "one_of")
  keep <- compact(list(...))

  bad_input <- detect_index(keep, ~ !vec_is_coercible(., chr()))
  if (bad_input) {
    type <- friendly_type_of(keep[[bad_input]])
    msg <- glue::glue("Input { bad_input } must be a vector of column names, not {type}.")
    abort(msg, "vctrs_error_incompatible_index_type")
  }

  keep <- vctrs::vec_c(!!!keep, .ptype = character())

  if (!all(keep %in% .vars)) {
    bad <- setdiff(keep, .vars)
    warn(glue("Unknown { plural(.vars) }: ", paste0("`", bad, "`", collapse = ", ")))
  }

  match_vars(keep, .vars)
}

rd_helpers_seealso <- function() {
  "The [selection language][language] page, which includes links to other selection helpers."
}
