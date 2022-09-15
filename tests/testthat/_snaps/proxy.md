# eval_*() respects proxy settings

    Code
      eval_select(quote(where(is.numeric)), foo)
    Condition
      Error:
      ! This tidyselect interface doesn't support predicates.
    Code
      eval_rename(quote(c(x = where(is.numeric))), foo)
    Condition
      Error:
      ! This tidyselect interface doesn't support predicates.
    Code
      eval_relocate(quote(where(is.numeric)), foo)
    Condition
      Error:
      ! This tidyselect interface doesn't support predicates.
    Code
      eval_relocate(quote(x), before = quote(where(is.numeric)), foo)
    Condition
      Error:
      ! This tidyselect interface doesn't support predicates.
    Code
      eval_relocate(quote(x), after = quote(where(is.numeric)), foo)
    Condition
      Error:
      ! This tidyselect interface doesn't support predicates.

