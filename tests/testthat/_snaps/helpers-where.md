# where() checks return values

    Code
      select_loc(iris, where(~NA))
    Condition
      Error in `FUN()`:
      ! Function in `where()` must return a single `TRUE` or `FALSE`, not `NA`.
    Code
      select_loc(iris, where(~1))
    Condition
      Error in `FUN()`:
      ! Function in `where()` must return a single `TRUE` or `FALSE`, not a number.

