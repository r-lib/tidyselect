# include and exclude validate their inputs

    Code
      x <- list(a = 1, b = 2, c = 3)
      (expect_error(select_loc(x, "a", include = 1)))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! `include` must be a character vector.
    Code
      (expect_error(select_loc(x, "a", include = "d")))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! `include` must only include variables found in `data`.
      i Unknown variables: d
    Code
      (expect_error(select_loc(x, "a", exclude = 1)))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! `include` must be a character vector.

# can forbid rename syntax (#178)

    Code
      (expect_error(select_loc(mtcars, c(foo = cyl), allow_rename = FALSE)))
    Output
      <error/tidyselect:::error_disallowed_rename>
      Error in `select_loc()`:
      ! Can't rename variables in this context.
    Code
      (expect_error(select_loc(mtcars, c(cyl, foo = cyl), allow_rename = FALSE)))
    Output
      <error/tidyselect:::error_disallowed_rename>
      Error in `select_loc()`:
      ! Can't rename variables in this context.
    Code
      (expect_error(select_loc(mtcars, c(cyl, foo = mpg), allow_rename = FALSE)))
    Output
      <error/tidyselect:::error_disallowed_rename>
      Error in `select_loc()`:
      ! Can't rename variables in this context.
    Code
      (expect_error(select_loc(mtcars, c(foo = mpg, cyl), allow_rename = FALSE)))
    Output
      <error/tidyselect:::error_disallowed_rename>
      Error in `select_loc()`:
      ! Can't rename variables in this context.

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
      i In argument: `f(base = TRUE)`.
      Caused by error in `h()`:
      ! foo
      ---
      Backtrace:
        1. base::print(expect_error(select_loc(mtcars, f(base = TRUE))))
       25. tidyselect (local) f(base = TRUE)
       26. tidyselect (local) g(base)
       27. tidyselect (local) h(base)
       28. base::stop("foo")
    Code
      print(expect_error(select_loc(mtcars, f(base = FALSE))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      i In argument: `f(base = FALSE)`.
      Caused by error in `h()`:
      ! foo
      ---
      Backtrace:
        1. base::print(expect_error(select_loc(mtcars, f(base = FALSE))))
       25. tidyselect (local) f(base = FALSE)
       26. tidyselect (local) g(base)
       27. tidyselect (local) h(base)

# eval_select() produces correct chained errors

    Code
      (expect_error(select_loc(mtcars, 1 + "")))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      i In argument: `1 + ""`.
      Caused by error in `1 + ""`:
      ! non-numeric argument to binary operator
    Code
      f <- (function() 1 + "")
      (expect_error(select_loc(mtcars, f())))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      i In argument: `f()`.
      Caused by error in `1 + ""`:
      ! non-numeric argument to binary operator

