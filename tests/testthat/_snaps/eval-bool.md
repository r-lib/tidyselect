# boolean operators throw relevant errors

    Code
      # Unknown names
      select_loc(mtcars, foobar & contains("am"))
    Error <vctrs_error_subscript_oob>
      Can't subset columns that don't exist.
      x Column `foobar` doesn't exist.
    Code
      select_loc(mtcars, contains("am") | foobar)
    Error <vctrs_error_subscript_oob>
      Can't subset columns that don't exist.
      x Column `foobar` doesn't exist.
    Code
      # Empty intersection
      select_loc(mtcars, cyl & am)
    Error <rlang_error>
      Can't take the intersection of two columns.
      i `cyl & am` is always an empty selection.
    Code
      # Symbol operands are evaluated in strict mode
      foo <- 1:2
      select_loc(iris, Species | foo)
    Error <vctrs_error_subscript_oob>
      Can't subset columns that don't exist.
      x Column `foo` doesn't exist.

