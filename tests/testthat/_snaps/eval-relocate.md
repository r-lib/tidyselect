# can't supply both `before` and `after`

    Code
      relocate_loc(c(x = 1), before = 1, after = 1)
    Condition
      Error in `relocate_loc()`:
      ! Can't supply both `before` and `after`.

---

    Code
      relocate_loc(c(x = 1), before = 1, after = 1, before_arg = ".before",
      after_arg = ".after")
    Condition
      Error in `relocate_loc()`:
      ! Can't supply both `.before` and `.after`.

# can't relocate with out-of-bounds variables by default

    Code
      relocate_loc(x, c)
    Condition <vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't relocate columns that don't exist.
      x Column `c` doesn't exist.
    Code
      relocate_loc(x, c(1, 3))
    Condition <vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't relocate columns that don't exist.
      i Location 3 doesn't exist.
      i There are only 2 columns.
    Code
      relocate_loc(x, a, before = c)
    Condition <vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't select columns that don't exist.
      x Column `c` doesn't exist.
    Code
      relocate_loc(x, a, after = c)
    Condition <vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't select columns that don't exist.
      x Column `c` doesn't exist.

# can relocate with out-of-bounds variables in `expr` if `strict = FALSE`

    Code
      relocate_loc(x, a, before = c, strict = FALSE)
    Condition <vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't select columns that don't exist.
      x Column `c` doesn't exist.
    Code
      relocate_loc(x, a, after = c, strict = FALSE)
    Condition <vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't select columns that don't exist.
      x Column `c` doesn't exist.

# can forbid rename syntax

    Code
      relocate_loc(x, c(foo = b), allow_rename = FALSE)
    Condition <tidyselect_error_cannot_rename>
      Error in `relocate_loc()`:
      ! Can't rename variables in this context.
    Code
      relocate_loc(x, c(b, foo = b), allow_rename = FALSE)
    Condition <tidyselect_error_cannot_rename>
      Error in `relocate_loc()`:
      ! Can't rename variables in this context.
    Code
      relocate_loc(x, c(b, foo = b), allow_rename = FALSE, error_arg = "...")
    Condition <tidyselect_error_cannot_rename>
      Error in `relocate_loc()`:
      ! Can't rename variables in this context.
      i In argument: `...`.

# can forbid empty selections

    Code
      relocate_loc(x, allow_empty = FALSE, error_arg = "...")
    Condition
      Error in `relocate_loc()`:
      ! `...` must select at least one column.
    Code
      relocate_loc(mtcars, integer(), allow_empty = FALSE)
    Condition
      Error in `relocate_loc()`:
      ! Must select at least one item.
    Code
      relocate_loc(mtcars, starts_with("z"), allow_empty = FALSE)
    Condition
      Error in `relocate_loc()`:
      ! Must select at least one item.

---

    Code
      relocate_loc(mtcars, before = integer(), allow_empty = FALSE)
    Condition <tidyselect_error_empty_selection>
      Error in `relocate_loc()`:
      ! Must select at least one item.
    Code
      relocate_loc(mtcars, starts_with("z"), allow_empty = FALSE)
    Condition <tidyselect_error_empty_selection>
      Error in `relocate_loc()`:
      ! Must select at least one item.

# `before` and `after` forbid renaming

    Code
      relocate_loc(x, b, before = c(new = c))
    Condition <tidyselect_error_cannot_rename>
      Error in `relocate_loc()`:
      ! Can't rename variables in this context.
      i In argument: `before`.
    Code
      relocate_loc(x, b, before = c(new = c), before_arg = ".before")
    Condition <tidyselect_error_cannot_rename>
      Error in `relocate_loc()`:
      ! Can't rename variables in this context.
      i In argument: `.before`.
    Code
      relocate_loc(x, b, after = c(new = c))
    Condition <tidyselect_error_cannot_rename>
      Error in `relocate_loc()`:
      ! Can't rename variables in this context.
      i In argument: `after`.
    Code
      relocate_loc(x, b, after = c(new = c), after_arg = ".after")
    Condition <tidyselect_error_cannot_rename>
      Error in `relocate_loc()`:
      ! Can't rename variables in this context.
      i In argument: `.after`.

