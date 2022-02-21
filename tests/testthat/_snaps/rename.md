# rename_loc() throws helpful errors

    Code
      # Unnamed vector
      rename_loc(letters, c(foo = a))
    Condition
      Error in `rename_loc()`:
      ! Can't rename an unnamed vector.
    Code
      # Duplicate names (FIXME)
      rename_loc(mtcars, c(foo = cyl, foo = disp))
    Condition
      Error in `stop_vctrs()`:
      ! Names must be unique.
      x These names are duplicated:
        * "foo" at locations 1 and 2.
    Code
      # Unnamed inputs
      rename_loc(iris, Species)
    Condition
      Error in `rename_loc()`:
      ! All renaming inputs must be named.

