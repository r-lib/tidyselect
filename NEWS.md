
# tidyselect 0.0.0.9000

tidyselect is the new home for the `select_vars()`, `rename_vars()`
and `select_var()` functions. We took this opportunity to make a few
adjustments to the API. The semantics of evaluation have changed:

* Symbols are now evaluated in a data-only context that is isolated
  from the calling environment. This means that you can no longer
  refer to local variables unless you are explicitly unquoting these
  variables with `!!`.

  Note that since dplyr 0.7, helper calls (like `starts_with()`) obey
  the opposite behaviour and are evaluated in the calling context
  isolated from the data context. To sum up, symbols can only refer to
  data frame objects, while helpers can only refer to contextual
  objects. This differs from usual R evaluation semantics where both
  the data and the calling environment are in scope (with the former
  prevailing over the latter).


There are a few cosmetic changes as well:

* `select_vars()` and `rename_vars()` are now `vars_select()` and
  `vars_rename()`. This follows the tidyverse convention that a prefix
  corresponds to the input type while suffixes indicate the output
  type. Similarly, `select_var()` is now `vars_pull()`.

* The arguments are now prefixed with dots to limit argument matching
  issues. While the dots help, it is still a good idea to splice a
  list of captured quosures to make sure dotted arguments are never
  matched to `vars_select()`'s named arguments:

  ```
  vars_select(vars, !!! quos(...))
  ```
