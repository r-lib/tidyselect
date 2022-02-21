# boolean operators throw relevant errors

    Code
      # Unknown names
      select_loc(mtcars, foobar & contains("am"))
    Condition
      Error in `stop_subscript()`:
      ! Can't subset columns that don't exist.
      x Column `foobar` doesn't exist.
    Code
      select_loc(mtcars, contains("am") | foobar)
    Condition
      Error in `stop_subscript()`:
      ! Can't subset columns that don't exist.
      x Column `foobar` doesn't exist.
    Code
      # Empty intersection
      select_loc(mtcars, cyl & am)
    Condition
      Error in `select_loc()`:
      ! Can't take the intersection of two columns.
      i `cyl & am` is always an empty selection.
    Code
      # Symbol operands are evaluated in strict mode
      foo <- 1:2
      select_loc(iris, Species | foo)
    Condition
      Error in `stop_subscript()`:
      ! Can't subset columns that don't exist.
      x Column `foo` doesn't exist.

