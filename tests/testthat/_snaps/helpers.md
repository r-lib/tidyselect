# one_of gives useful errors

    Code
      one_of(1L, .vars = c("x", "y"))
    Condition <vctrs_error_incompatible_index_type>
      Error in `one_of()`:
      ! Input 1 must be a vector of column names, not the number 1.

