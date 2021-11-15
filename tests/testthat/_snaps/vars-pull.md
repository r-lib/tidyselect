# errors for bad inputs

    Code
      vars_pull(letters, letters)
      vars_pull(letters, aa)
      vars_pull(letters, 0)
      vars_pull(letters, 100)
      vars_pull(letters, -100)
      vars_pull(letters, -Inf)
      vars_pull(letters, TRUE)
      vars_pull(letters, NA)
      vars_pull(letters, na_int)
      vars_pull(letters, "foo")
      vars_pull(letters, <chr: "a", "b">)
    Error <simpleError>
      <text>:11:20: unexpected '<'
      10: vars_pull(letters, "foo")
      11: vars_pull(letters, <
                             ^

# vars_pull() has informative errors

    Code
      # # vars_pull() instruments base errors
      (expect_error(vars_pull(letters, foobar), ""))
    Output
      <error/rlang_error>
      object 'foobar' not found

