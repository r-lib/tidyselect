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
      (expect_error(relocate_loc(x, c)))
    Output
      <error/vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't subset columns that don't exist.
      x Column `c` doesn't exist.
    Code
      (expect_error(relocate_loc(x, c(1, 3))))
    Output
      <error/vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't subset columns past the end.
      i Location 3 doesn't exist.
      i There are only 2 columns.
    Code
      (expect_error(relocate_loc(x, a, before = c)))
    Output
      <error/vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't subset columns that don't exist.
      x Column `c` doesn't exist.
    Code
      (expect_error(relocate_loc(x, a, after = c)))
    Output
      <error/vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't subset columns that don't exist.
      x Column `c` doesn't exist.

# can relocate with out-of-bounds variables in `expr` if `strict = FALSE`

    Code
      (expect_error(relocate_loc(x, a, before = c, strict = FALSE)))
    Output
      <error/vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't subset columns that don't exist.
      x Column `c` doesn't exist.
    Code
      (expect_error(relocate_loc(x, a, after = c, strict = FALSE)))
    Output
      <error/vctrs_error_subscript_oob>
      Error in `relocate_loc()`:
      ! Can't subset columns that don't exist.
      x Column `c` doesn't exist.

# can forbid rename syntax

    Code
      (expect_error(relocate_loc(x, c(foo = b), allow_rename = FALSE)))
    Output
      <error/tidyselect:::error_disallowed_rename>
      Error in `relocate_loc()`:
      ! Can't rename variables in this context.
    Code
      (expect_error(relocate_loc(x, c(b, foo = b), allow_rename = FALSE)))
    Output
      <error/tidyselect:::error_disallowed_rename>
      Error in `relocate_loc()`:
      ! Can't rename variables in this context.

# can forbid empty selections

    Code
      (expect_error(relocate_loc(x, allow_empty = FALSE)))
    Output
      <error/rlang_error>
      Error in `relocate_loc()`:
      ! Must select at least one item.
    Code
      (expect_error(relocate_loc(mtcars, integer(), allow_empty = FALSE)))
    Output
      <error/rlang_error>
      Error in `relocate_loc()`:
      ! Must select at least one item.
    Code
      (expect_error(relocate_loc(mtcars, starts_with("z"), allow_empty = FALSE)))
    Output
      <error/rlang_error>
      Error in `relocate_loc()`:
      ! Must select at least one item.

# `before` and `after` forbid renaming

    Code
      (expect_error(relocate_loc(x, b, before = c(new = c))))
    Output
      <error/rlang_error>
      Error in `relocate_loc()`:
      ! Can't rename variables when `before` is supplied.
    Code
      (expect_error(relocate_loc(x, b, before = c(new = c), before_arg = ".before")))
    Output
      <error/rlang_error>
      Error in `relocate_loc()`:
      ! Can't rename variables when `.before` is supplied.
    Code
      (expect_error(relocate_loc(x, b, after = c(new = c))))
    Output
      <error/rlang_error>
      Error in `relocate_loc()`:
      ! Can't rename variables when `after` is supplied.
    Code
      (expect_error(relocate_loc(x, b, after = c(new = c), after_arg = ".after")))
    Output
      <error/rlang_error>
      Error in `relocate_loc()`:
      ! Can't rename variables when `.after` is supplied.

