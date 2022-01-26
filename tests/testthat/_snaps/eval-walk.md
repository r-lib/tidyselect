# scalar boolean operators fail informatively

    Code
      select_loc(letters2, starts_with("a") || ends_with("b"))
    Condition
      Error in `select_loc()`:
      ! Can't use scalar `||` in selections.
      i Do you need `|` instead?
    Code
      select_loc(letters2, starts_with("a") && ends_with("b"))
    Condition
      Error in `select_loc()`:
      ! Can't use scalar `&&` in selections.
      i Do you need `&` instead?

# can't use `*` and `^` in data context

    Code
      select_loc(letters2, a * 2)
    Condition
      Error in `select_loc()`:
      ! Can't use arithmetic operator `*` in selection context.
    Code
      select_loc(letters2, a^2)
    Condition
      Error in `select_loc()`:
      ! Can't use arithmetic operator `^` in selection context.

# symbol evaluation only informs once (#184)

    Code
      # Default
      with_options(tidyselect_verbosity = NULL, {
        `_vars_default` <- "cyl"
        select_loc(mtcars, `_vars_default`)
        select_loc(mtcars, `_vars_default`)
        invisible(NULL)
      })
    Message
      Note: Using an external vector in selections is ambiguous.
      i Use `all_of(_vars_default)` instead of `_vars_default` to silence this message.
      i See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
      This message is displayed once per session.
    Code
      # Verbose
      with_options(tidyselect_verbosity = "verbose", {
        `_vars_verbose` <- "cyl"
        select_loc(mtcars, `_vars_verbose`)
        select_loc(mtcars, `_vars_verbose`)
        invisible(NULL)
      })
    Message
      Note: Using an external vector in selections is ambiguous.
      i Use `all_of(_vars_verbose)` instead of `_vars_verbose` to silence this message.
      i See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
      Note: Using an external vector in selections is ambiguous.
      i Use `all_of(_vars_verbose)` instead of `_vars_verbose` to silence this message.
      i See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Code
      # Quiet
      with_options(tidyselect_verbosity = "quiet", {
        `_vars_quiet` <- "cyl"
        select_loc(mtcars, `_vars_quiet`)
        select_loc(mtcars, `_vars_quiet`)
        invisible(NULL)
      })

# selections provide informative errors

    Code
      # Foreign errors during evaluation
      select_loc(iris, eval_tidy(foobar))
    Condition
      Error:
      ! object 'foobar' not found

# eval_walk() has informative messages

    Code
      # # Using a predicate without where() warns
      invisible(select_loc(iris, is_integer))
    Condition
      Warning:
      Predicate functions must be wrapped in `where()`.
      
        # Bad
        data %>% select(is_integer)
      
        # Good
        data %>% select(where(is_integer))
      
      i Please update your code.
      This message is displayed once per session.
    Code
      invisible(select_loc(iris, is.numeric))
    Condition
      Warning:
      Predicate functions must be wrapped in `where()`.
      
        # Bad
        data %>% select(is.numeric)
      
        # Good
        data %>% select(where(is.numeric))
      
      i Please update your code.
      This message is displayed once per session.
    Code
      invisible(select_loc(iris, isTRUE))
    Condition
      Warning:
      Predicate functions must be wrapped in `where()`.
      
        # Bad
        data %>% select(isTRUE)
      
        # Good
        data %>% select(where(isTRUE))
      
      i Please update your code.
      This message is displayed once per session.
    Code
      # Warning is not repeated
      invisible(select_loc(iris, is_integer))
      # formula shorthand must be wrapped
      (expect_error(select_loc(mtcars, ~ is.numeric(.x))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Formula shorthand must be wrapped in `where()`.
      
        # Bad
        data %>% select(~is.numeric(.x))
      
        # Good
        data %>% select(where(~is.numeric(.x)))
    Code
      (expect_error(select_loc(mtcars, ~ is.numeric(.x) || is.factor(.x) ||
        is.character(.x))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Formula shorthand must be wrapped in `where()`.
      
        # Bad
        data %>% select(~is.numeric(.x) || is.factor(.x) || is.character(.x))
      
        # Good
        data %>% select(where(~is.numeric(.x) || is.factor(.x) || is.character(.x)))
    Code
      (expect_error(select_loc(mtcars, ~ is.numeric(.x) || is.factor(.x) ||
        is.character(.x) || is.numeric(.x) || is.factor(.x) || is.character(.x))))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! Formula shorthand must be wrapped in `where()`.
      
        # Bad
        data %>% select(~...)
      
        # Good
        data %>% select(where(~...))
    Code
      (expect_error(select_loc(mtcars, .data$"foo")))
    Output
      <error/rlang_error>
      Error in `select_loc()`:
      ! The RHS of `.data$rhs` must be a symbol.

