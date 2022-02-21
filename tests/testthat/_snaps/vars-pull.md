# errors for bad inputs

    Code
      vars_pull(letters, letters)
    Condition
      Error:
      ! Must extract column with a single valid subscript.
      x Subscript `var` has size 26 but must be size 1.
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
      x Subscript `var` has value 0 but must be a positive location.
    Code
      vars_pull(letters, 100)
    Condition
      Error in `stop_subscript()`:
      ! Can't extract columns that don't exist.
      x Location 100 doesn't exist.
      i There are only 26 columns.
    Code
      vars_pull(letters, -100)
    Condition
      Error in `stop_subscript()`:
      ! Can't extract columns that don't exist.
      x Location 100 doesn't exist.
      i There are only 26 columns.
    Code
      vars_pull(letters, -Inf)
    Condition
      Error:
      ! Must extract column with a single valid subscript.
      x Can't convert from `var` <double> to <integer> due to loss of precision.
      Caused by error in `stop_vctrs()`:
      ! Can't convert from `var` <double> to <integer> due to loss of precision.
      * Locations: 1
    Code
      vars_pull(letters, TRUE)
    Condition
      Error:
      ! Must extract column with a single valid subscript.
      x Subscript `var` has the wrong type `logical`.
      i It must be numeric or character.
    Code
      vars_pull(letters, NA)
    Condition
      Error:
      ! Must extract column with a single valid subscript.
      x Subscript `var` can't be `NA`.
    Code
      vars_pull(letters, na_int)
    Condition
      Error:
      ! Must extract column with a single valid subscript.
      x Subscript `var` can't be `NA`.
    Code
      vars_pull(letters, "foo")
    Condition
      Error in `stop_subscript()`:
      ! Can't extract columns that don't exist.
      x Column `foo` doesn't exist.
    Code
      vars_pull(letters, !!c("a", "b"))
    Condition
      Error:
      ! Must extract column with a single valid subscript.
      x Subscript `var` has size 2 but must be size 1.

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
      Error in `h()`:
      ! foo
      Backtrace:
        1. base::print(expect_error(vars_pull(letters, f(base = TRUE))))
       17. base::.handleSimpleError(`<fn>`, "foo", base::quote(h(base)))
       18. rlang h(simpleError(msg, call))
       19. handlers[[1L]](cnd)
    Code
      print(expect_error(vars_pull(letters, f(base = FALSE))))
    Output
      <error/rlang_error>
      Error in `h()`:
      ! foo
      Backtrace:
        1. base::print(expect_error(vars_pull(letters, f(base = FALSE))))
       13. tidyselect f(base = FALSE)
       14. tidyselect g(base)
       15. tidyselect h(base)

