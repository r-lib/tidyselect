# include and exclude validate their inputs

    Code
      x <- list(a = 1, b = 2, c = 3)
      select_loc(x, "a", include = 1)
    Condition <rlang_error>
      Error in `select_loc()`:
      ! `include` must be a character vector.
    Code
      select_loc(x, "a", include = "d")
    Condition <rlang_error>
      Error in `select_loc()`:
      ! `include` must only include variables found in `data`.
      i Unknown variables: d
    Code
      select_loc(x, "a", exclude = 1)
    Condition <rlang_error>
      Error in `select_loc()`:
      ! `include` must be a character vector.

# can forbid rename syntax (#178)

    Code
      select_loc(mtcars, c(foo = cyl), allow_rename = FALSE)
    Condition <tidyselect:::error_disallowed_rename>
      Error in `select_loc()`:
      ! Can't rename variables in this context.
    Code
      select_loc(mtcars, c(cyl, foo = cyl), allow_rename = FALSE)
    Condition <tidyselect:::error_disallowed_rename>
      Error in `select_loc()`:
      ! Can't rename variables in this context.
    Code
      select_loc(mtcars, c(cyl, foo = mpg), allow_rename = FALSE)
    Condition <tidyselect:::error_disallowed_rename>
      Error in `select_loc()`:
      ! Can't rename variables in this context.
    Code
      select_loc(mtcars, c(foo = mpg, cyl), allow_rename = FALSE)
    Condition <tidyselect:::error_disallowed_rename>
      Error in `select_loc()`:
      ! Can't rename variables in this context.
    Code
      select_loc(mtcars, c(foo = mpg, cyl), error_arg = "x", allow_rename = FALSE)
    Condition <tidyselect:::error_disallowed_rename>
      Error in `select_loc()`:
      ! Can't rename variables in this context.
      i `x` can't be renamed.

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

# can forbid empty selections with informative error

    Code
      select_loc(mtcars, allow_empty = FALSE, error_arg = "cols")
    Condition
      Error in `select_loc()`:
      ! `cols` must select at least one column.
    Code
      select_loc(mtcars, integer(), allow_empty = FALSE, error_arg = "x")
    Condition
      Error in `select_loc()`:
      ! `x` must select at least one column.
    Code
      select_loc(mtcars, starts_with("z"), allow_empty = FALSE, error_arg = "y")
    Condition
      Error in `select_loc()`:
      ! `y` must select at least one column.

# eval_select() errors mention correct calls

    Code
      select_loc(mtcars, f())
    Condition <rlang_error>
      Error in `select_loc()`:
      Caused by error in `f()`:
      ! foo

# predicate outputs are type-checked

    Code
      select_loc(mtcars, function(x) "")
    Condition <rlang_error>
      Error in `select_loc()`:
      ! Predicate must return `TRUE` or `FALSE`, not the empty string "".

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
           x
        1. +-base::print(expect_error(select_loc(mtcars, f(base = TRUE))))
        2. +-testthat::expect_error(select_loc(mtcars, f(base = TRUE)))
        3. | \-testthat:::expect_condition_matching(...)
        4. |   \-testthat:::quasi_capture(...)
        5. |     +-testthat (local) .capture(...)
        6. |     | \-base::withCallingHandlers(...)
        7. |     \-rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
        8. +-tidyselect:::select_loc(mtcars, f(base = TRUE))
        9. | \-tidyselect::eval_select(...)
       10. |   \-tidyselect:::eval_select_impl(...)
       11. |     +-tidyselect:::with_subscript_errors(...)
       12. |     | \-base::withCallingHandlers(...)
       13. |     \-tidyselect:::vars_select_eval(...)
       14. |       \-tidyselect:::walk_data_tree(expr, data_mask, context_mask)
       15. |         \-tidyselect:::eval_context(expr, context_mask, call = error_call)
       16. |           +-tidyselect:::with_chained_errors(...)
       17. |           | \-base::withCallingHandlers(...)
       18. |           \-rlang::eval_tidy(as_quosure(expr, env), context_mask)
       19. \-tidyselect (local) f(base = TRUE)
       20.   \-tidyselect (local) g(base)
       21.     \-tidyselect (local) h(base)
       22.       \-base::stop("foo")
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
           x
        1. +-base::print(expect_error(select_loc(mtcars, f(base = FALSE))))
        2. +-testthat::expect_error(select_loc(mtcars, f(base = FALSE)))
        3. | \-testthat:::expect_condition_matching(...)
        4. |   \-testthat:::quasi_capture(...)
        5. |     +-testthat (local) .capture(...)
        6. |     | \-base::withCallingHandlers(...)
        7. |     \-rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
        8. +-tidyselect:::select_loc(mtcars, f(base = FALSE))
        9. | \-tidyselect::eval_select(...)
       10. |   \-tidyselect:::eval_select_impl(...)
       11. |     +-tidyselect:::with_subscript_errors(...)
       12. |     | \-base::withCallingHandlers(...)
       13. |     \-tidyselect:::vars_select_eval(...)
       14. |       \-tidyselect:::walk_data_tree(expr, data_mask, context_mask)
       15. |         \-tidyselect:::eval_context(expr, context_mask, call = error_call)
       16. |           +-tidyselect:::with_chained_errors(...)
       17. |           | \-base::withCallingHandlers(...)
       18. |           \-rlang::eval_tidy(as_quosure(expr, env), context_mask)
       19. \-tidyselect (local) f(base = FALSE)
       20.   \-tidyselect (local) g(base)
       21.     \-tidyselect (local) h(base)

# eval_select() produces correct chained errors

    Code
      select_loc(mtcars, 1 + "")
    Condition <rlang_error>
      Error in `select_loc()`:
      i In argument: `1 + ""`.
      Caused by error in `1 + ""`:
      ! non-numeric argument to binary operator
    Code
      f <- (function() 1 + "")
      select_loc(mtcars, f())
    Condition <rlang_error>
      Error in `select_loc()`:
      i In argument: `f()`.
      Caused by error in `1 + ""`:
      ! non-numeric argument to binary operator

