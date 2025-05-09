#' Select variables from character vectors
#'
#' @description
#'
#' These [selection helpers][language] select variables
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
#' @section Examples:
#'
#' ```{r, child = "man/rmd/setup.Rmd"}
#' ```
#'
#' Selection helpers can be used in functions like `dplyr::select()`
#' or `tidyr::pivot_longer()`. Let's first attach the tidyverse:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' library(tidyverse)
#'
#' # For better printing
#' iris <- as_tibble(iris)
#' ```
#'
#' It is a common to have a names of variables in a vector.
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' vars <- c("Sepal.Length", "Sepal.Width")
#'
#' iris[, vars]
#' ```
#'
#' To refer to these variables in selecting function, use `all_of()`:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(all_of(vars))
#'
#' iris %>% pivot_longer(all_of(vars))
#' ```
#'
#' If any of these variables are missing from the data frame, that's an error:
#'
#' ```{r, error = TRUE}
#' starwars %>% select(all_of(vars))
#' ```
#'
#' Use `any_of()` to allow missing variables:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' starwars %>% select(any_of(vars))
#' ```
#'
#' `any_of()` is especially useful to remove variables from a data
#' frame because calling it again does not cause an error:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(-any_of(vars))
#'
#' iris %>% select(-any_of(vars)) %>% select(-any_of(vars))
#' ```
#'
#' Supply named vectors to `all_of()` and `any_of()` to select and rename
#' columns at the same time:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' colors <- c(color_of_hair = "hair_color", color_of_eyes = "eye_color")
#' starwars %>% select(all_of(colors))
#' ```
#'
#' @seealso `r rd_helpers_seealso()`
#' @export
all_of <- function(x) {
  if (!has_vars()) {
    lifecycle::deprecate_soft(
      "1.2.0",
      I("Using `all_of()` outside of a selecting function"),
      details = paste("See details at", peek_vars_link())
    )
    return(x)
  }

  vars <- peek_vars(fn = "all_of")
  as_indices_impl(x, vars = vars, strict = TRUE)
}

#' @rdname all_of
#' @inheritParams rlang::args_dots_empty
#' @export
any_of <- function(x, ..., vars = NULL) {
  vars <- vars %||% peek_vars(fn = "any_of")
  if (!missing(...)) {
    cli::cli_abort(c(
      "{.arg ...} must be empty.",
      i = "Did you forget {.code c()}?",
      i = 'The expected syntax is {.code any_of(c("a", "b"))}, not {.code any_of("a", "b")}'
    ))
  }
  as_indices_impl(x, vars = vars, strict = FALSE)
}
