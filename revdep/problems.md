# crosstable

<details>

* Version: 0.4.1
* GitHub: https://github.com/DanChaltiel/crosstable
* Source code: https://github.com/cran/crosstable
* Date/Publication: 2022-02-25 12:20:03 UTC
* Number of recursive dependencies: 115

Run `cloud_details(, "crosstable")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       21. │           └─tidyselect:::reduce_sels(node, data_mask, context_mask, init = init)
       22. │             └─tidyselect:::walk_data_tree(new, data_mask, context_mask)
       23. │               └─tidyselect:::as_indices_sel_impl(...)
       24. │                 ├─base::which(map_lgl(data, predicate))
       25. │                 └─tidyselect:::map_lgl(data, predicate)
       26. │                   └─tidyselect:::.rlang_purrr_map_mold(.x, .f, logical(1), ...)
       27. │                     └─base::vapply(.x, .f, .mold, ..., USE.NAMES = FALSE)
       28. └─base::.handleSimpleError(...)
       29.   └─rlang h(simpleError(msg, call))
       30.     └─handlers[[1L]](cnd)
       31.       └─rlang::abort(...)
      
      [ FAIL 1 | WARN 0 | SKIP 26 | PASS 331 ]
      Error: Test failures
      Execution halted
    ```

# metaconfoundr

<details>

* Version: 0.1.0
* GitHub: https://github.com/malcolmbarrett/metaconfoundr
* Source code: https://github.com/cran/metaconfoundr
* Date/Publication: 2021-10-12 08:10:02 UTC
* Number of recursive dependencies: 117

Run `cloud_details(, "metaconfoundr")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘ellipsis’
      All declared Imports should be used.
    ```

# tidysmd

<details>

* Version: 0.1.0
* GitHub: https://github.com/malcolmbarrett/tidysmd
* Source code: https://github.com/cran/tidysmd
* Date/Publication: 2021-10-25 07:00:02 UTC
* Number of recursive dependencies: 59

Run `cloud_details(, "tidysmd")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘ellipsis’
      All declared Imports should be used.
    ```

