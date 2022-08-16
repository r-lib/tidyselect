# `all_of()` fails even if `.strict` is FALSE

    Code
      select_loc(letters2, all_of(c("a", "bar", "c")), strict = FALSE)
    Condition
      Error in `select_loc()`:
      ! Problem while evaluating `all_of(c("a", "bar", "c"))`.
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
      ! Problem while evaluating `all_of(TRUE)`.
      Caused by error in `all_of()`:
      ! Must subset elements with a valid subscript vector.
      x Subscript has the wrong type `logical`.
      i It must be numeric or character.
    Code
      (expect_error(select_loc(letters2, any_of(TRUE))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Problem while evaluating `any_of(TRUE)`.
      Caused by error in `any_of()`:
      ! Must subset elements with a valid subscript vector.
      x Subscript has the wrong type `logical`.
      i It must be numeric or character.
    Code
      (expect_error(select_loc(letters2, any_of(is.factor))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Problem while evaluating `any_of(is.factor)`.
      Caused by error in `any_of()`:
      ! Must subset elements with a valid subscript vector.
      x Subscript has the wrong type `function`.
      i It must be numeric or character.
    Code
      (expect_error(select_loc(letters2, all_of(is.factor))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Problem while evaluating `all_of(is.factor)`.
      Caused by error in `all_of()`:
      ! Must subset elements with a valid subscript vector.
      x Subscript has the wrong type `function`.
      i It must be numeric or character.

# any_of() and all_off() error out of context (#269)

    Code
      (expect_error(all_of()))
    Output
      <error/rlang_error>
      Error:
      ! `all_of()` must be used within a *selecting* function.
      i See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for details.
    Code
      (expect_error(any_of()))
    Output
      <error/rlang_error>
      Error:
      ! `any_of()` must be used within a *selecting* function.
      i See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for details.

# any_of generates informative error if ... not empty

    Code
      any_of("b", "c", "d")
    Condition
      Error in `any_of()`:
      ! `...` must be empty.
      i Did you forget `c()`?
      i The expected syntax is `any_of(c("a", "b"))`, not `any_of("a", "b")`

