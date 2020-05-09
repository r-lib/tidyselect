#' Select all variables or the last variable
#'
#' @description
#'
#' These functions are [selection helpers][language].
#'
#' * [everything()] selects all variable. It is also useful in
#'   combination with other tidyselect operators.
#'
#' * [last_col()] selects the last variable.
#'
#' @inheritParams starts_with
#'
#' @section Usage:
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
#' mtcars <- as_tibble(mtcars)
#' ```
#'
#' Use `everything()` to select all variables:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(everything())
#'
#' mtcars %>% pivot_longer(everything())
#' ```
#'
#' Use `last_col()` to select the last variable:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(last_col())
#'
#' mtcars %>% pivot_longer(last_col())
#' ```
#'
#' Pass an offset to select a number of variables from the end:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' mtcars %>% select(1:last_col(5))
#' ```
#'
#' @family selection helpers
#' @export
everything <- function(vars = peek_vars(fn = "everything")) {
  seq_along(vars)
}

#' @rdname everything
#' @export
#' @param offset Set it to `n` to select the nth var from the end.
last_col <- function(offset = 0L, vars = peek_vars(fn = "last_col")) {
  stopifnot(is_integerish(offset))
  n <- length(vars)

  if (offset && n <= offset) {
    abort(glue("`offset` must be smaller than the number of { plural(vars) }"))
  } else if (n == 0) {
    abort(glue("Can't select last { singular(vars) } when input is empty"))
  } else {
    n - as.integer(offset)
  }
}
