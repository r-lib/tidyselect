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

