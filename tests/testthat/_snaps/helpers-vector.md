# `all_of()` fails even if `.strict` is FALSE

    Code
      select_loc(letters2, all_of(c("a", "bar", "c")), strict = FALSE)
    Condition
      Error in `select_loc()`:
      i In argument: `all_of(c("a", "bar", "c"))`.
      Caused by error in `all_of()`:
      ! Can't subset elements that don't exist.
      x Element `bar` doesn't exist.

# all_of() and any_of() check their inputs

    Code
      (expect_error(select_loc(letters2, all_of(NA))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Selections can't have missing values.
    Code
      (expect_error(select_loc(letters2, any_of(NA))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Selections can't have missing values.
    Code
      (expect_error(select_loc(letters2, all_of(TRUE))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      i In argument: `all_of(TRUE)`.
      Caused by error in `all_of()`:
      ! Must subset elements with a valid subscript vector.
      x Subscript has the wrong type `logical`.
      i It must be numeric or character.
    Code
      (expect_error(select_loc(letters2, any_of(TRUE))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      i In argument: `any_of(TRUE)`.
      Caused by error in `any_of()`:
      ! Must subset elements with a valid subscript vector.
      x Subscript has the wrong type `logical`.
      i It must be numeric or character.
    Code
      (expect_error(select_loc(letters2, any_of(is.factor))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      i In argument: `any_of(is.factor)`.
      Caused by error in `any_of()`:
      ! Must subset elements with a valid subscript vector.
      x Subscript has the wrong type `function`.
      i It must be numeric or character.
    Code
      (expect_error(select_loc(letters2, all_of(is.factor))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      i In argument: `all_of(is.factor)`.
      Caused by error in `all_of()`:
      ! Must subset elements with a valid subscript vector.
      x Subscript has the wrong type `function`.
      i It must be numeric or character.

# any_of() errors out of context

    Code
      (expect_error(any_of()))
    Output
      <error/rlang_error>
      Error:
      ! `any_of()` must be used within a *selecting* function.
      i See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for details.

# all_of() is deprecated out of context (#269)

    Code
      out <- all_of("x")
    Condition
      Warning:
      Using `all_of()` outside of a selecting function was deprecated in tidyselect 1.2.0.
      i See details at <https://tidyselect.r-lib.org/reference/faq-selection-context.html>

# any_of generates informative error if ... not empty

    Code
      any_of("b", "c", "d")
    Condition
      Error in `any_of()`:
      ! `...` must be empty.
      i Did you forget `c()`?
      i The expected syntax is `any_of(c("a", "b"))`, not `any_of("a", "b")`

