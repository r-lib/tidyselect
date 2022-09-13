# multiplication works

    Code
      eval_relocate(quote(where(is.numeric)), foo)
    Condition
      Error:
      ! This tidyselect interface doesn't support predicates.
    Code
      eval_select(quote(where(is.numeric)), foo)
    Condition
      Error:
      ! This tidyselect interface doesn't support predicates.
    Code
      eval_rename(quote(where(is.numeric)), foo)
    Condition
      Error:
      ! All renaming inputs must be named.

