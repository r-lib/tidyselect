# rename_loc() throws helpful errors

    Code
      # Unnamed vector
      rename_loc(letters, c(foo = a))
    Error <rlang_error>
      Can't rename an unnamed vector.
    Code
      # Duplicate names (FIXME)
      rename_loc(mtcars, c(foo = cyl, foo = disp))
    Error <vctrs_error_names_must_be_unique>
      Names must be unique.
      x These names are duplicated:
        * "foo" at locations 1 and 2.
    Code
      # Unnamed inputs
      rename_loc(iris, Species)
    Error <rlang_error>
      All renaming inputs must be named.

