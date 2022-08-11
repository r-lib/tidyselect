# any_of generates informative error if ... not empty

    Code
      any_of("b", "c", "d")
    Condition
      Error in `any_of()`:
      ! `...` must be empty.
      i Did you forget `c()`?
      i The expected syntax is `any_of(c("a", "b"))`, not `any_of("a", "b")`

