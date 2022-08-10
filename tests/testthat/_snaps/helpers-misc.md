# last_col() checks its inputs

    Code
      last_col(3, letters[1:3])
    Condition
      Error in `last_col()`:
      ! `offset` must be smaller than the number of columns.
    Code
      last_col(0, character())
    Condition
      Error in `last_col()`:
      ! Can't select last column when input is empty.
    Code
      last_col(1:2, letters[1:3])
    Condition
      Error in `last_col()`:
      ! `offset` must be a single integer.

