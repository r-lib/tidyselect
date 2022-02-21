# vars_select() type-checks inputs

    Code
      vars_select(letters, TRUE)
    Condition
      Error:
      ! Must subset columns with a valid subscript vector.
      x Subscript has the wrong type `logical`.
      i It must be numeric or character.
    Code
      vars_select(letters, 2.5)
    Condition
      Error:
      ! Must subset columns with a valid subscript vector.
      x Can't convert from <double> to <integer> due to loss of precision.
      Caused by error in `stop_vctrs()`:
      ! Can't convert from <double> to <integer> due to loss of precision.
      * Locations: 1
    Code
      vars_select(letters, structure(1:3, class = "tidysel_foobar"))
    Condition
      Error:
      ! Must subset columns with a valid subscript vector.
      x Subscript has the wrong type `tidysel_foobar`.
      i It must be numeric or character.

# vars_select() has consistent location errors

    Code
      # Bare names
      vars_select(letters, foo)
    Condition
      Error in `stop_subscript()`:
      ! Can't subset columns that don't exist.
      x Column `foo` doesn't exist.
    Code
      vars_select(letters, -foo)
    Condition
      Error in `stop_subscript()`:
      ! Can't subset columns that don't exist.
      x Column `foo` doesn't exist.
    Code
      # Names
      vars_select(letters, "foo")
    Condition
      Error in `stop_subscript()`:
      ! Can't subset columns that don't exist.
      x Column `foo` doesn't exist.
    Code
      vars_select(letters, a:"foo")
    Condition
      Error in `stop_subscript()`:
      ! Can't subset columns that don't exist.
      x Column `foo` doesn't exist.
    Code
      # Locations
      vars_select(letters, 30, 50, 100)
    Condition
      Error in `stop_subscript()`:
      ! Can't subset columns that don't exist.
      x Locations 30, 50, and 100 don't exist.
      i There are only 26 columns.
    Code
      vars_select(letters, -100)
    Condition
      Error in `stop_subscript()`:
      ! Can't subset columns that don't exist.
      x Location 100 doesn't exist.
      i There are only 26 columns.
    Code
      vars_select(letters, !100)
    Condition
      Error in `stop_subscript()`:
      ! Can't subset columns that don't exist.
      x Location 100 doesn't exist.
      i There are only 26 columns.

# when .strict = FALSE, vars_rename always succeeds

    Code
      vars_rename(c("a", "b"), d = e, .strict = TRUE)
    Condition
      Error in `stop_subscript()`:
      ! Can't rename columns that don't exist.
      x Column `e` doesn't exist.
    Code
      vars_rename(c("a", "b"), d = e, f = g, .strict = TRUE)
    Condition
      Error in `stop_subscript()`:
      ! Can't rename columns that don't exist.
      x Column `e` doesn't exist.
    Code
      vars_rename(c("a", "b"), d = "e", f = "g", .strict = TRUE)
    Condition
      Error in `stop_subscript()`:
      ! Can't rename columns that don't exist.
      x Column `e` doesn't exist.

# vars_rename() disallows renaming to same column

    Code
      # New column
      vars_rename(c("a", "b", "c"), foo = a, foo = b)
    Condition
      Error in `stop_vctrs()`:
      ! Names must be unique.
      x These names are duplicated:
        * "foo" at locations 1 and 2.
    Code
      # Existing column
      vars_rename(c("a", "b", "c"), c = a, c = b)
    Condition
      Error in `stop_vctrs()`:
      ! Names must be unique.
      x These names are duplicated:
        * "c" at locations 1, 2, and 3.

# vars_rename() disallows renaming to existing columns (#70)

    Code
      # One column
      vars_rename(c("a", "b", "c"), b = a)
    Condition
      Error in `stop_vctrs()`:
      ! Names must be unique.
      x These names are duplicated:
        * "b" at locations 1 and 2.
    Code
      # Multiple columns
      vars_rename(c("a", "b", "c", "d"), c = a, d = b)
    Condition
      Error in `stop_vctrs()`:
      ! Names must be unique.
      x These names are duplicated:
        * "c" at locations 1 and 3.
        * "d" at locations 2 and 4.
    Code
      # Overlapping rename with one duplicate column
      vars_rename(c("a", "b", "c"), b = a, c = b)
    Condition
      Error in `stop_vctrs()`:
      ! Names must be unique.
      x These names are duplicated:
        * "c" at locations 2 and 3.

# vars_rename() type-checks arguments

    Code
      vars_rename(letters, A = TRUE)
    Condition
      Error:
      ! Must rename columns with a valid subscript vector.
      x Subscript has the wrong type `logical`.
      i It must be numeric or character.
    Code
      vars_rename(letters, A = 1.5)
    Condition
      Error:
      ! Must rename columns with a valid subscript vector.
      x Can't convert from <double> to <integer> due to loss of precision.
      Caused by error in `stop_vctrs()`:
      ! Can't convert from <double> to <integer> due to loss of precision.
      * Locations: 1
    Code
      vars_rename(letters, A = list())
    Condition
      Error:
      ! Must rename columns with a valid subscript vector.
      x Subscript has the wrong type `list`.
      i It must be numeric or character.

