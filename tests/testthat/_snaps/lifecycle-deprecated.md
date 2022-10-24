# vars_select() type-checks inputs

    Code
      vars_select(letters, TRUE)
    Condition
      Error:
      ! Can't select columns with `TRUE`.
      x `TRUE` must be numeric or character, not `TRUE`.
    Code
      vars_select(letters, 2.5)
    Condition
      Error:
      ! Can't select columns with `2.5`.
      x Can't convert from `2.5` <double> to <integer> due to loss of precision.
    Code
      vars_select(letters, structure(1:3, class = "tidysel_foobar"))
    Condition
      Error:
      ! Can't select columns with `structure(1:3, class = "tidysel_foobar")`.
      x `structure(1:3, class = "tidysel_foobar")` must be numeric or character, not a <tidysel_foobar> object.

# vars_select() has consistent location errors

    Code
      # Bare names
      vars_select(letters, foo)
    Condition
      Error:
      ! Can't select columns that don't exist.
      x Column `foo` doesn't exist.
    Code
      vars_select(letters, -foo)
    Condition
      Error:
      ! Can't select columns that don't exist.
      x Column `foo` doesn't exist.
    Code
      # Names
      vars_select(letters, "foo")
    Condition
      Error:
      ! Can't select columns that don't exist.
      x Column `foo` doesn't exist.
    Code
      vars_select(letters, a:"foo")
    Condition
      Error:
      ! Can't select columns that don't exist.
      x Column `foo` doesn't exist.
    Code
      # Locations
      vars_select(letters, 30, 50, 100)
    Condition
      Error:
      ! Can't select columns past the end.
      i Locations 30, 50, and 100 don't exist.
      i There are only 26 columns.
    Code
      vars_select(letters, -100)
    Condition
      Error:
      ! Can't select columns past the end.
      i Location 100 doesn't exist.
      i There are only 26 columns.
    Code
      vars_select(letters, !100)
    Condition
      Error:
      ! Can't select columns past the end.
      i Location 100 doesn't exist.
      i There are only 26 columns.

# when .strict = FALSE, vars_rename always succeeds

    Code
      vars_rename(c("a", "b"), d = e, .strict = TRUE)
    Condition
      Error:
      ! Can't rename columns that don't exist.
      x Column `e` doesn't exist.
    Code
      vars_rename(c("a", "b"), d = e, f = g, .strict = TRUE)
    Condition
      Error:
      ! Can't rename columns that don't exist.
      x Column `e` doesn't exist.
    Code
      vars_rename(c("a", "b"), d = "e", f = "g", .strict = TRUE)
    Condition
      Error:
      ! Can't rename columns that don't exist.
      x Column `e` doesn't exist.

# vars_rename() disallows renaming to same column

    Code
      # New column
      vars_rename(c("a", "b", "c"), foo = a, foo = b)
    Condition
      Error:
      ! Names must be unique.
      x These names are duplicated:
        * "foo" at locations 1 and 2.
    Code
      # Existing column
      vars_rename(c("a", "b", "c"), c = a, c = b)
    Condition
      Error:
      ! Names must be unique.
      x These names are duplicated:
        * "c" at locations 1, 2, and 3.

# vars_rename() disallows renaming to existing columns (#70)

    Code
      # One column
      vars_rename(c("a", "b", "c"), b = a)
    Condition
      Error:
      ! Names must be unique.
      x These names are duplicated:
        * "b" at locations 1 and 2.
    Code
      # Multiple columns
      vars_rename(c("a", "b", "c", "d"), c = a, d = b)
    Condition
      Error:
      ! Names must be unique.
      x These names are duplicated:
        * "c" at locations 1 and 3.
        * "d" at locations 2 and 4.
    Code
      # Overlapping rename with one duplicate column
      vars_rename(c("a", "b", "c"), b = a, c = b)
    Condition
      Error:
      ! Names must be unique.
      x These names are duplicated:
        * "c" at locations 2 and 3.

# vars_rename() type-checks arguments

    Code
      vars_rename(letters, A = TRUE)
    Condition
      Error:
      ! Can't rename columns with `TRUE`.
      x `TRUE` must be numeric or character, not `TRUE`.
    Code
      vars_rename(letters, A = 1.5)
    Condition
      Error:
      ! Can't rename columns with `1.5`.
      x Can't convert from `1.5` <double> to <integer> due to loss of precision.
    Code
      vars_rename(letters, A = list())
    Condition
      Error:
      ! Can't rename columns with `list()`.
      x `list()` must be numeric or character, not an empty list.

