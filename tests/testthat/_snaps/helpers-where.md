# where() checks return values

    Code
      select_loc(iris, where(~NA))
    Condition
      Error in `FUN()`:
      ! `where()` must be used with functions that return `TRUE` or `FALSE`.
    Code
      select_loc(iris, where(~1))
    Condition
      Error in `FUN()`:
      ! `where()` must be used with functions that return `TRUE` or `FALSE`.

