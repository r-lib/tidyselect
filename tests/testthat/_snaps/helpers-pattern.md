# num_range recycles with tidyverse rules (#355)

    Code
      select_loc(vars, num_range(c("x", "y"), 1:3))
    Condition
      Error in `select_loc()`:
      i In argument: `num_range(c("x", "y"), 1:3)`.
      Caused by error in `num_range()`:
      ! Can't recycle `prefix` (size 2) to match `range` (size 3).

---

    Code
      select_loc(vars, num_range(c("x", "y"), 1:2, c("_foo", "_bar", "_baz")))
    Condition
      Error in `select_loc()`:
      i In argument: `num_range(c("x", "y"), 1:2, c("_foo", "_bar", "_baz"))`.
      Caused by error in `num_range()`:
      ! Can't recycle `prefix` (size 2) to match `suffix` (size 3).

# matches() complains about bad stringr pattern usage

    Code
      matches(stringr::fixed("a"), perl = TRUE)
    Condition
      Error in `matches()`:
      ! `perl` not supported when `match` is a stringr pattern.
    Code
      matches(stringr::fixed("a"), ignore.case = TRUE)
    Condition
      Error in `matches()`:
      ! `ignore.case` not supported when `match` is a stringr pattern.
    Code
      matches(stringr::fixed(c("a", "b")))
    Condition
      Error in `matches()`:
      ! stringr patterns must be length 1.

