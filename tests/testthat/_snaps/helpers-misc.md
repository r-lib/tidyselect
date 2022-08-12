# last_col() checks its inputs

    Code
      last_col(Inf, letters[1:3])
    Condition
      Error in `last_col()`:
      ! `offset` (Inf) must be smaller than the number of columns (3).
    Code
      last_col(3, letters[1:3])
    Condition
      Error in `last_col()`:
      ! `offset` (3) must be smaller than the number of columns (3).
    Code
      last_col(0, character())
    Condition
      Error in `last_col()`:
      ! Can't select last column when input is empty.
    Code
      last_col(1:2, letters[1:3])
    Condition
      Error in `last_col()`:
      ! `offset` must be a single integer, not an integer vector.

