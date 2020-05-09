#' Select variables from character vectors
#'
#' @description
#'
#' These [selection helpers][select_helpers] select variables
#' contained in a character vector. They are especially useful for
#' programming with selecting functions.
#'
#' * [all_of()] is for strict selection. If any of the variables in
#'   the character vector is missing, an error is thrown.
#'
#' * [any_of()] doesn't check for missing variables. It is especially
#'   useful with negative selections, when you would like to make sure
#'   a variable is removed.
#'
#' The order of selected columns is determined by the order in the
#' vector.
#'
#' @inheritParams starts_with
#' @param x A vector of character names or numeric locations.
#'
#' @section Usage:
#'
#' ```{r, include = FALSE}
#' options(
#'   tibble.print_min = 4,
#'   digits = 2,
#'   tibble.max_extra_cols = 8,
#'   crayon.enabled = FALSE,
#'   cli.unicode = FALSE
#' )
#' library(tidyverse)
#' ```
#'
#' Selection helpers can be used in functions like `dplyr::select()`
#' or `tidyr::pivot_longer()`. Let's first attach the tidyverse:
#'
#' ```{r}
#' library(tidyverse)
#'
#' # For better printing
#' iris <- as_tibble(iris)
#' ```
#'
#' It is a common to have a names of variables in a vector.
#'
#' ```{r}
#' vars <- c("Sepal.Length", "Sepal.Width")
#'
#' iris[, vars]
#' ```
#'
#' To refer to these variables in selecting function, use `all_of()`:
#'
#' ```{r}
#' iris %>% select(all_of(vars))
#'
#' iris %>% pivot_longer(all_of(vars))
#' ```
#'
#' If any of the variable is missing from the data frame, that's an error:
#'
#' ```{r, error = TRUE}
#' starwars %>% select(all_of(vars))
#' ```
#'
#' Use `any_of()` to allow missing variables:
#'
#' ```{r}
#' starwars %>% select(any_of(vars))
#' ```
#'
#' `any_of()` is especially useful to remove variables from a data
#' frame because calling it again does not cause an error:
#'
#' ```{r}
#' iris %>% select(-any_of(vars))
#'
#' iris %>% select(-any_of(vars)) %>% select(-any_of(vars))
#' ```
#'
#' @family selection helpers
#' @export
all_of <- function(x) {
  if (is.function(x)) {
    # Trigger bad type error
    vctrs::vec_as_location(x, 0L)
    abort("Internal error: `all_of()` should have failed sooner")
  }

  x
}

#' @rdname all_of
#' @inheritParams ellipsis::dots_empty
#' @export
any_of <- function(x,
                   ...,
                   vars = peek_vars(fn = "any_of")) {
  ellipsis::check_dots_empty()
  as_indices_impl(x, vars = vars, strict = FALSE)
}
