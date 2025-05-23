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

# symbol lookup outside data informs caller about better practice

    Code
      vars <- c("a", "b")
      select_loc(letters2, vars)
    Condition
      Warning:
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
      i See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      a b 
      1 2 

# can forbid use of predicates

    Code
      select_loc(iris, where(is.factor), allow_predicates = FALSE)
    Condition
      Error in `select_loc()`:
      ! This tidyselect interface doesn't support predicates.

# selections provide informative errors

    Code
      # Foreign errors during evaluation
      select_loc(iris, eval_tidy(foobar))
    Condition
      Error in `select_loc()`:
      i In argument: `eval_tidy(foobar)`.
      Caused by error:
      ! object 'foobar' not found

# use of .data is deprecated

    Code
      x <- select_loc(x, .data$a)
    Condition
      Warning:
      Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0.
      i Please use `"a"` instead of `.data$a`

---

    Code
      x <- select_loc(x, .data[[var]])
    Condition
      Warning:
      Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0.
      i Please use `all_of(var)` (or `any_of(var)`) instead of `.data[[var]]`

---

    Code
      x <- vars_pull("a", .data[[var]])
    Condition
      Warning:
      Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0.
      i Please use `all_of(var)` (or `any_of(var)`) instead of `.data[[var]]`

# eval_walk() warns when using a predicate without where()

    Code
      invisible(select_loc(iris, is_integer))
    Condition
      Warning:
      Use of bare predicate functions was deprecated in tidyselect 1.1.0.
      i Please use `where()` to wrap predicate functions instead.
    Code
      invisible(select_loc(iris, is.numeric))
    Condition
      Warning:
      Use of bare predicate functions was deprecated in tidyselect 1.1.0.
      i Please use `where()` to wrap predicate functions instead.
    Code
      invisible(select_loc(iris, isTRUE))
    Condition
      Warning:
      Use of bare predicate functions was deprecated in tidyselect 1.1.0.
      i Please use `where()` to wrap predicate functions instead.
    Code
      # Warning is not repeated
      invisible(select_loc(iris, is_integer))
    Condition
      Warning:
      Use of bare predicate functions was deprecated in tidyselect 1.1.0.
      i Please use `where()` to wrap predicate functions instead.

# eval_walk() errors when formula shorthand are not wrapped

    Code
      select_loc(mtcars, ~ is.numeric(.x))
    Condition <rlang_error>
      Error in `select_loc()`:
      ! Formula shorthand must be wrapped in `where()`.
      
        # Bad
        data %>% select(~is.numeric(.x))
      
        # Good
        data %>% select(where(~is.numeric(.x)))
    Code
      select_loc(mtcars, ~ is.numeric(.x) || is.factor(.x) || is.character(.x))
    Condition <rlang_error>
      Error in `select_loc()`:
      ! Formula shorthand must be wrapped in `where()`.
      
        # Bad
        data %>% select(~is.numeric(.x) || is.factor(.x) || is.character(.x))
      
        # Good
        data %>% select(where(~is.numeric(.x) || is.factor(.x) || is.character(.x)))
    Code
      select_loc(mtcars, ~ is.numeric(.x) || is.factor(.x) || is.character(.x) ||
        is.numeric(.x) || is.factor(.x) || is.character(.x))
    Condition <rlang_error>
      Error in `select_loc()`:
      ! Formula shorthand must be wrapped in `where()`.
      
        # Bad
        data %>% select(~...)
      
        # Good
        data %>% select(where(~...))
    Code
      select_loc(mtcars, .data$"foo")
    Condition <rlang_error>
      Error in `select_loc()`:
      ! The RHS of `.data$rhs` must be a symbol.

# can forbid empty selection

    Code
      ensure_named(integer(), allow_empty = FALSE)
    Condition
      Error:
      ! Must select at least one item.
    Code
      ensure_named(integer(), allow_empty = FALSE, allow_rename = FALSE)
    Condition
      Error:
      ! Must select at least one item.

# duplicate names are checked when literals are supplied (#346)

    Code
      select_loc(df, "x")
    Condition <vctrs_error_names_must_be_unique>
      Error in `select_loc()`:
      ! Names must be unique.
      x These names are duplicated:
        * "x" at locations 1 and 2.
    Code
      select_loc(df, c("x"))
    Condition <vctrs_error_names_must_be_unique>
      Error in `select_loc()`:
      ! Names must be unique.
      x These names are duplicated:
        * "x" at locations 1 and 2.
    Code
      select_loc(df, c(!!1:2))
    Condition <vctrs_error_names_must_be_unique>
      Error in `select_loc()`:
      ! Names must be unique.
      x These names are duplicated:
        * "x" at locations 1 and 2.
    Code
      select_loc(df, !!(1:2))
    Condition <vctrs_error_names_must_be_unique>
      Error in `select_loc()`:
      ! Names must be unique.
      x These names are duplicated:
        * "x" at locations 1 and 2.

