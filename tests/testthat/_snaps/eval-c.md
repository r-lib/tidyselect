# uniquely-named inputs can't rename duplicates

    Code
      names(df)
    Output
      [1] "a" "b" "a"
    Code
      select_loc(df, c(foo = a))
    Error <rlang_error>
      Can't rename duplicate variables to `foo`.

