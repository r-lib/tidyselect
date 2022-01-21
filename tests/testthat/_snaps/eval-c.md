# uniquely-named inputs can't rename duplicates

    Code
      names(df)
    Output
      [1] "a" "b" "a"
    Code
      select_loc(df, c(foo = a))
    Condition
      Error in `combine_names()`:
      ! Can't rename duplicate variables to `foo`.

