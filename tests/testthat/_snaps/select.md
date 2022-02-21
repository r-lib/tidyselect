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
      Backtrace:
        1. base::print(expect_error(select_loc(mtcars, f(base = TRUE))))
       27. base::.handleSimpleError(`<fn>`, "foo", base::quote(h(base)))
       28. rlang h(simpleError(msg, call))
       29. handlers[[1L]](cnd)
    Code
      print(expect_error(select_loc(mtcars, f(base = FALSE))))
    Output
      <error/rlang_error>
      Error in `h()`:
      ! foo
      Backtrace:
        1. base::print(expect_error(select_loc(mtcars, f(base = FALSE))))
       23. tidyselect f(base = FALSE)
       24. tidyselect g(base)
       25. tidyselect h(base)

