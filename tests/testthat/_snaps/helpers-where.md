# where() checks return values

    Code
      where(NA)
    Condition
      Error in `where()`:
      ! Can't convert `fn`, `NA`, to a function.

---

    Code
      select_loc(iris, where(~NA))
    Condition
      Error in `where()`:
      ! Predicate must return a single `TRUE` or `FALSE`, not `NA`.
    Code
      select_loc(iris, where(~1))
    Condition
      Error in `where()`:
      ! Predicate must return a single `TRUE` or `FALSE`, not a number.
    Code
      select_loc(iris, where(mean))
    Condition
      Error in `where()`:
      ! Predicate must return a single `TRUE` or `FALSE`, not a number.

