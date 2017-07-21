
# tidyselect 0.1.0

tidyselect is the new home for the `select_vars()`, `rename_vars()`
and `select_var()` functions. We took this opportunity to make a few
adjustments to the API.

* The semantics of evaluation have changed. Symbols are now evaluated
  in a data-only context that is isolated from the calling
  environment. This means that you can no longer refer to local
  variables unless you are explicitly unquoting these variables with
  `!!`.

  Note that since dplyr 0.7, helper calls (like `starts_with()`) obey
  the opposite behaviour and are evaluated in the calling context
  isolated from the data context. To sum up, symbols can only refer to
  data frame objects, while helpers can only refer to contextual
  objects. This differs from usual R evaluation semantics where both
  the data and the calling environment are in scope (with the former
  prevailing over the latter).

* Error messages can now be customised. For consistency with dplyr,
  error messages refer to "columns" by default. This assumes that the
  variables being selected come from a data frame. If this is not
  appropriate for your DSL, you can now add an attribute `vars_type`
  to the `.vars` vector to specify alternative names. This must be a
  character vector of length 2 whose first component is the singular
  form and the second is the plural. For example, `c("variable",
  "variables")`.


tidyselect provides a few more ways of establishing a variable
context:

* `poke_vars()` establishes a new variable context. It returns the
  previous context invisibly and it is your responsibility to restore
  it after you are done.

  `current_vars()` has been renamed to `peek_vars()`. This naming is a
  reference to [peek and poke](https://en.wikipedia.org/wiki/PEEK_and_POKE)
  from legacy languages.

* `scoped_vars()` is like `poke_vars()` but sets up an exit hook to
  automatically restore the previous variables. It is the preferred
  way of changing the variable context.

  `with_vars()` takes variables and an expression and evaluates the
  latter in the context of the former.


There are a few other cosmetic changes:

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
