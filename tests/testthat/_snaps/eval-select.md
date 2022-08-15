# can forbid empty selections

    Code
      select_loc(mtcars, allow_empty = FALSE)
    Condition
      Error in `select_loc()`:
      ! Must select at least one item.
    Code
      select_loc(mtcars, integer(), allow_empty = FALSE)
    Condition
      Error in `select_loc()`:
      ! Must select at least one item.
    Code
      select_loc(mtcars, starts_with("z"), allow_empty = FALSE)
    Condition
      Error in `select_loc()`:
      ! Must select at least one item.

# eval_select() errors mention correct calls

    Code
      (expect_error(select_loc(mtcars, f())))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      Caused by error in `f()`:
      ! foo

# predicate outputs are type-checked

    Code
      (expect_error(select_loc(mtcars, function(x) "")))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Predicate must return `TRUE` or `FALSE`, not `""`.

# eval_select() produces correct backtraces

    Code
      print(expect_error(select_loc(mtcars, f(base = TRUE))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Problem while evaluating `f(base = TRUE)`.
      Caused by error in `h()`:
      ! foo
      ---
      Backtrace:
        1. base::print(expect_error(select_loc(mtcars, f(base = TRUE))))
       27. tidyselect (local) f(base = TRUE)
       28. tidyselect (local) g(base)
       29. tidyselect (local) h(base)
       30. base::stop("foo")
    Code
      print(expect_error(select_loc(mtcars, f(base = FALSE))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Problem while evaluating `f(base = FALSE)`.
      Caused by error in `h()`:
      ! foo
      ---
      Backtrace:
        1. base::print(expect_error(select_loc(mtcars, f(base = FALSE))))
       27. tidyselect (local) f(base = FALSE)
       28. tidyselect (local) g(base)
       29. tidyselect (local) h(base)

# eval_select() produces correct chained errors

    Code
      (expect_error(select_loc(mtcars, 1 + "")))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      Caused by error in `1 + ""`:
      ! non-numeric argument to binary operator
    Code
      f <- (function() 1 + "")
      (expect_error(select_loc(mtcars, f())))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Problem while evaluating `f()`.
      Caused by error in `1 + ""`:
      ! non-numeric argument to binary operator

