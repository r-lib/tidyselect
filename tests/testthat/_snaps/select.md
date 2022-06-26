# eval_select() errors mention correct calls

    Code
      (expect_error(select_loc(mtcars, f())))
    Output
      <error/rlang_error>
      Error in `f()`:
      ! foo

# eval_select() produces correct backtraces

    Code
      print(expect_error(select_loc(mtcars, f(base = TRUE))))
    Output
      <error/rlang_error>
      Error in `h()`:
      ! foo
      ---
      Backtrace:
        1. base::print(expect_error(select_loc(mtcars, f(base = TRUE))))
       23. tidyselect (local) f(base = TRUE)
       24. tidyselect (local) g(base)
       25. tidyselect (local) h(base)
       26. base::stop("foo")
    Code
      print(expect_error(select_loc(mtcars, f(base = FALSE))))
    Output
      <error/rlang_error>
      Error in `h()`:
      ! foo
      ---
      Backtrace:
        1. base::print(expect_error(select_loc(mtcars, f(base = FALSE))))
       23. tidyselect (local) f(base = FALSE)
       24. tidyselect (local) g(base)
       25. tidyselect (local) h(base)

