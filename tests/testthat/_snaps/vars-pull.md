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
      ! Must extract column with a single valid subscript.
      x Subscript `0` has value 0 but must be a positive location.
    Code
      vars_pull(letters, 100)
    Condition
      Error in `vec_as_location2_result()`:
      ! Can't extract columns past the end.
      i Location 100 doesn't exist.
      i There are only 26 columns.
    Code
      vars_pull(letters, -100)
    Condition
      Error in `vec_as_location2_result()`:
      ! Can't extract columns past the end.
      i Location 100 doesn't exist.
      i There are only 26 columns.
    Code
      vars_pull(letters, -Inf)
    Condition
      Error:
      ! Must extract column with a single valid subscript.
      x Subscript `-Inf` has the wrong type `double`.
      i It must be numeric or character.
    Code
      vars_pull(letters, TRUE)
    Condition
      Error:
      ! Must extract column with a single valid subscript.
      x Subscript `TRUE` has the wrong type `logical`.
      i It must be numeric or character.
    Code
      vars_pull(letters, NA)
    Condition
      Error:
      ! Must extract column with a single valid subscript.
      x Subscript `NA` can't be `NA`.
    Code
      vars_pull(letters, na_int)
    Condition
      Error:
      ! Must extract column with a single valid subscript.
      x Subscript `na_int` can't be `NA`.
    Code
      vars_pull(letters, "foo")
    Condition
      Error in `vec_as_location2_result()`:
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
      ! Problem while evaluating `f(base = TRUE)`.
      Caused by error in `h()`:
      ! foo
      ---
      Backtrace:
        1. base::print(expect_error(vars_pull(letters, f(base = TRUE))))
       17. tidyselect (local) f(base = TRUE)
       18. tidyselect (local) g(base)
       19. tidyselect (local) h(base)
       20. base::stop("foo")
    Code
      print(expect_error(vars_pull(letters, f(base = FALSE))))
    Output
      <error/rlang_error>
      Error:
      ! Problem while evaluating `f(base = FALSE)`.
      Caused by error in `h()`:
      ! foo
      ---
      Backtrace:
        1. base::print(expect_error(vars_pull(letters, f(base = FALSE))))
       17. tidyselect (local) f(base = FALSE)
       18. tidyselect (local) g(base)
       19. tidyselect (local) h(base)

