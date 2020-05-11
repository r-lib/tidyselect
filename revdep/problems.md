# tidytable

<details>

* Version: 0.4.1
* Source code: https://github.com/cran/tidytable
* URL: https://github.com/markfairbanks/tidytable
* BugReports: https://github.com/markfairbanks/tidytable/issues
* Date/Publication: 2020-04-30 12:50:02 UTC
* Number of recursive dependencies: 38

Run `revdep_details(,"tidytable")` for more info

</details>

## Newly broken

*   checking for code/documentation mismatches ... WARNING
    ```
    ...
        Name: 'vars' Code: NULL Docs: peek_vars(fn = "ends_with")
    everything.
      Code: function(vars = NULL)
      Docs: function(vars = peek_vars(fn = "everything"))
      Mismatches in argument default values:
        Name: 'vars' Code: NULL Docs: peek_vars(fn = "everything")
    dt_everything
      Code: function(vars = NULL)
      Docs: function(vars = peek_vars(fn = "everything"))
      Mismatches in argument default values:
        Name: 'vars' Code: NULL Docs: peek_vars(fn = "everything")
    any_of.
      Code: function(x, ..., vars = NULL)
      Docs: function(x, ..., vars = peek_vars(fn = "any_of"))
      Mismatches in argument default values:
        Name: 'vars' Code: NULL Docs: peek_vars(fn = "any_of")
    dt_any_of
      Code: function(x, ..., vars = NULL)
      Docs: function(x, ..., vars = peek_vars(fn = "any_of"))
      Mismatches in argument default values:
        Name: 'vars' Code: NULL Docs: peek_vars(fn = "any_of")
    ```

