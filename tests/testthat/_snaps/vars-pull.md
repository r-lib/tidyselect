# errors for bad inputs

    Code
      vars_pull(letters, character())
    Condition
      Error:
      ! `character()` must select exactly one column.
    Code
      vars_pull(letters, c("a", "b"))
    Condition
      Error:
      ! `c("a", "b")` must select exactly one column.
    Code
      vars_pull(letters, !!c("a", "b"))
    Condition
      Error:
      ! `!!c("a", "b")` must select exactly one column.
    Code
      vars_pull(letters, aa)
    Condition
      Error:
      ! object 'aa' not found
    Code
      vars_pull(letters, 0)
    Condition
      Error:
      ! Can't extract column with `0`.
      x Subscript `0` must be a positive location, not 0.
    Code
      vars_pull(letters, 100)
    Condition
      Error:
      ! Can't extract columns past the end.
      i Location 100 doesn't exist.
      i There are only 26 columns.
    Code
      vars_pull(letters, -100)
    Condition
      Error:
      ! Can't extract columns past the end.
      i Location 100 doesn't exist.
      i There are only 26 columns.
    Code
      vars_pull(letters, -Inf)
    Condition
      Error:
      ! Can't extract column with `-Inf`.
      x Can't convert from `-Inf` <double> to <integer> due to loss of precision.
    Code
      vars_pull(letters, TRUE)
    Condition
      Error:
      ! Can't extract column with `TRUE`.
      x `TRUE` must be numeric or character, not `TRUE`.
    Code
      vars_pull(letters, NA)
    Condition
      Error:
      ! Can't extract column with `NA`.
      x Subscript `NA` must be a location, not an integer `NA`.
    Code
      vars_pull(letters, na_int)
    Condition
      Error:
      ! Can't extract column with `na_int`.
      x Subscript `na_int` must be a location, not an integer `NA`.
    Code
      vars_pull(letters, "foo")
    Condition
      Error:
      ! Can't extract columns that don't exist.
      x Column `foo` doesn't exist.

# gives informative error if quosure is missing

    Code
      f()
    Condition
      Error in `f()`:
      ! `var` is absent but must be supplied.

# vars_pull() has informative errors

    Code
      # # vars_pull() instruments base errors
      (expect_error(vars_pull(letters, foobar), ""))
    Output
      <error/rlang_error>
      Error:
      ! object 'foobar' not found

# vars_pull() errors mention correct calls

    Code
      (expect_error(vars_pull(letters, f())))
    Output
      <error/rlang_error>
      Error in `f()`:
      ! foo

# vars_pull() produces correct backtraces

    Code
      print(expect_error(vars_pull(letters, f(base = TRUE))))
    Output
      <error/rlang_error>
      Error:
      i In argument: `f(base = TRUE)`.
      Caused by error in `h()`:
      ! foo
      ---
      Backtrace:
           x
        1. +-base::print(expect_error(vars_pull(letters, f(base = TRUE))))
        2. +-testthat::expect_error(vars_pull(letters, f(base = TRUE)))
        3. | \-testthat:::expect_condition_matching(...)
        4. |   \-testthat:::quasi_capture(...)
        5. |     +-testthat (local) .capture(...)
        6. |     | \-base::withCallingHandlers(...)
        7. |     \-rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
        8. +-tidyselect::vars_pull(letters, f(base = TRUE))
        9. | +-tidyselect:::with_chained_errors(...)
       10. | | \-base::withCallingHandlers(...)
       11. | \-rlang::eval_tidy(expr, set_names(seq_along(vars), vars))
       12. \-tidyselect (local) f(base = TRUE)
       13.   \-tidyselect (local) g(base)
       14.     \-tidyselect (local) h(base)
       15.       \-base::stop("foo")
    Code
      print(expect_error(vars_pull(letters, f(base = FALSE))))
    Output
      <error/rlang_error>
      Error:
      i In argument: `f(base = FALSE)`.
      Caused by error in `h()`:
      ! foo
      ---
      Backtrace:
           x
        1. +-base::print(expect_error(vars_pull(letters, f(base = FALSE))))
        2. +-testthat::expect_error(vars_pull(letters, f(base = FALSE)))
        3. | \-testthat:::expect_condition_matching(...)
        4. |   \-testthat:::quasi_capture(...)
        5. |     +-testthat (local) .capture(...)
        6. |     | \-base::withCallingHandlers(...)
        7. |     \-rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
        8. +-tidyselect::vars_pull(letters, f(base = FALSE))
        9. | +-tidyselect:::with_chained_errors(...)
       10. | | \-base::withCallingHandlers(...)
       11. | \-rlang::eval_tidy(expr, set_names(seq_along(vars), vars))
       12. \-tidyselect (local) f(base = FALSE)
       13.   \-tidyselect (local) g(base)
       14.     \-tidyselect (local) h(base)

