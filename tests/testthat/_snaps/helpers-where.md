# where() checks return values

    Code
      where(NA)
    Condition
      Error in `where()`:
      ! Can't convert `fn`, a logical vector, to a function.

---

    Code
      select_loc(iris, where(~NA))
    Condition
      Error in `where()`:
      ! Predicate must return `TRUE` or `FALSE`, not `NA`.
    Code
      select_loc(iris, where(~1))
    Condition
      Error in `where()`:
      ! Predicate must return `TRUE` or `FALSE`, not the number 1.
    Code
      select_loc(iris, where(mean))
    Condition
      Error in `where()`:
      ! Predicate must return `TRUE` or `FALSE`, not the number 5.84.

