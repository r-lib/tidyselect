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
#' mtcars <- as_tibble(mtcars)
#' ```
#'
#' Use `everything()` to select all variables:
#'
#' ```{r}
#' iris %>% select(everything())
#'
#' mtcars %>% pivot_longer(everything())
#' ```
#'
#' Use `last_col()` to select the last variable:
#'
#' ```{r}
#' iris %>% select(last_col())
#'
#' mtcars %>% pivot_longer(last_col())
#' ```
#'
#' Pass an offset to select a number of variables from the end:
#'
#' ```{r}
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
