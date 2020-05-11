# AzureKusto

<details>

* Version: 1.0.4
* Source code: https://github.com/cran/AzureKusto
* URL: https://github.com/Azure/AzureKusto https://github.com/Azure/AzureR
* BugReports: https://github.com/Azure/AzureKusto/issues
* Date/Publication: 2019-10-26 22:30:08 UTC
* Number of recursive dependencies: 66

Run `revdep_details(,"AzureKusto")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Expected match: "object 'Species1' not found"
      Actual message: "Can't rename columns that don't exist.\n✖ The column `Species1` doesn't exist."
      Backtrace:
        1. testthat::expect_error(show_query(q), "object 'Species1' not found")
       32. vctrs:::stop_subscript_oob(...)
       33. vctrs:::stop_subscript(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 100 | SKIPPED: 7 | WARNINGS: 3 | FAILED: 3 ]
      1. Failure: filter errors on missing symbols (@test_translate.r#96) 
      2. Failure: select errors on column after selected away (@test_translate.r#139) 
      3. Failure: rename() errors when given a nonexistent column (@test_translate.r#282) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tibble’
      All declared Imports should be used.
    ```

# cattonum

<details>

* Version: 0.0.3
* Source code: https://github.com/cran/cattonum
* URL: https://github.com/bfgray3/cattonum
* BugReports: https://github.com/bfgray3/cattonum/issues
* Date/Publication: 2019-12-17 14:10:09 UTC
* Number of recursive dependencies: 71

Run `revdep_details(,"cattonum")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(cattonum)
      > 
      > test_check("cattonum")
      ── 1. Failure: conditions work correctly. (@test-conditions.R#7)  ──────────────
      `catto_label(foo, one_of(x1, x2))` did not throw an error.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 254 | SKIPPED: 4 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: conditions work correctly. (@test-conditions.R#7) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘purrr’
      All declared Imports should be used.
    ```

# cheese

<details>

* Version: 0.0.2
* Source code: https://github.com/cran/cheese
* URL: https://github.com/zajichek/cheese
* Date/Publication: 2020-01-24 05:30:02 UTC
* Number of recursive dependencies: 90

Run `revdep_details(,"cheese")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    +     )
    Error: Names must be unique.
    Backtrace:
         █
      1. └─`%>%`(...)
      2.   ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      3.   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      4.     └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5.       └─`_fseq`(`_lhs`)
      6.         └─magrittr::freduce(value, `_function_list`)
      7.           ├─base::withVisible(function_list[[k]](value))
      8.           └─function_list[[k]](value)
      9.             └─cheese::stretch(...)
     10.               └─`%>%`(...) 00_pkg_src/cheese/R/FUNCTIONS.R:258:16
     11.                 ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
     12.                 └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
     13.                   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
     14.                     └─cheese:::`_fseq`(`_lhs`)
     15.                       └─magrittr::freduce(value, `_function_list`)
     16.                         ├─base::withVisi
    Execution halted
    ```

# dplyr

<details>

* Version: 0.8.3
* Source code: https://github.com/cran/dplyr
* URL: http://dplyr.tidyverse.org, https://github.com/tidyverse/dplyr
* BugReports: https://github.com/tidyverse/dplyr/issues
* Date/Publication: 2019-07-04 15:50:02 UTC
* Number of recursive dependencies: 93

Run `revdep_details(,"dplyr")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Expected match: "Unknown column `test`"
      Actual message: "Can't subset columns that don't exist.\n✖ The column `test` doesn't exist."
      Backtrace:
        1. testthat::expect_error(mutate_at(tibble(), "test", ~1), "Unknown column `test`")
       28. vctrs:::stop_subscript_oob(...)
       29. vctrs:::stop_subscript(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 3405 | SKIPPED: 14 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: colwise mutate gives correct error message if column not found (#4374) (@test-colwise-mutate.R#430) 
      
      Error: testthat unit tests failed
      In addition: Warning message:
      call dbDisconnect() when finished working with a connection 
      Execution halted
    ```

*   checking dependencies in R code ... WARNING
    ```
    '::' or ':::' import not declared from: ‘ellipsis’
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4 marked UTF-8 strings
    ```

# EGAnet

<details>

* Version: 0.9.0
* Source code: https://github.com/cran/EGAnet
* Date/Publication: 2020-01-19 00:20:03 UTC
* Number of recursive dependencies: 180

Run `revdep_details(,"EGAnet")` for more info

</details>

## Newly broken

*   checking package dependencies ... ERROR
    ```
    Package required and available but unsuitable version: ‘tidyselect’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R
    Extensions’ manual.
    ```

## Newly fixed

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘doParallel’ ‘foreach’ ‘psych’ ‘psychTools’ ‘tidyselect’
      All declared Imports should be used.
    ```

# mudata2

<details>

* Version: 1.1.0
* Source code: https://github.com/cran/mudata2
* URL: https://paleolimbot.github.io/mudata2, https://github.com/paleolimbot/mudata2
* BugReports: https://github.com/paleolimbot/mudata2/issues
* Date/Publication: 2020-01-09 16:50:02 UTC
* Number of recursive dependencies: 92

Run `revdep_details(,"mudata2")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      OGR: Unsupported geometry type
      OGR: Unsupported geometry type
      OGR: Unsupported geometry type
      OGR: Unsupported geometry type
      OGR: Unsupported geometry type
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 916 | SKIPPED: 2 | WARNINGS: 4 | FAILED: 5 ]
      1. Failure: rename functions throw errors (@test-rename.R#55) 
      2. Failure: rename functions throw errors (@test-rename.R#56) 
      3. Failure: rename functions throw errors (@test-rename.R#57) 
      4. Failure: rename functions throw errors (@test-rename.R#58) 
      5. Error: rename functions throw errors (@test-rename.R#65) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘ggplot2’
      All declared Imports should be used.
    ```

# tibbleOne

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/tibbleOne
* Date/Publication: 2019-10-28 15:10:02 UTC
* Number of recursive dependencies: 107

Run `revdep_details(,"tibbleOne")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       11. dplyr:::rename.data.frame(., !!!names_to_repair)
       12. tidyselect::vars_rename(names(.data), !!!enquos(...))
       13. tidyselect:::rename_impl(NULL, .vars, quo(c(...)), strict = .strict)
       21. vctrs::vec_as_names(names, repair = "check_unique")
       22. vctrs:::validate_unique(names)
       23. vctrs:::stop_names_must_be_unique(which(duplicated(names)))
       24. vctrs:::stop_names(...)
       25. vctrs:::stop_vctrs(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 36 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: correct inputs work (@test-to_kable.R#38) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘lifecycle’
      All declared Imports should be used.
    ```

# tsibble

<details>

* Version: 0.8.5
* Source code: https://github.com/cran/tsibble
* URL: https://tsibble.tidyverts.org
* BugReports: https://github.com/tidyverts/tsibble/issues
* Date/Publication: 2019-11-03 06:00:02 UTC
* Number of recursive dependencies: 93

Run `revdep_details(,"tsibble")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ── 1. Failure: a tbl_ts of 4 day interval with bad names (@test-gaps.R#74)  ────
      `fill_gaps(tsbl, value1 = value)` threw an error with unexpected message.
      Expected match: "Unknown column"
      Actual message: "Can't subset columns that don't exist.\n✖ The column `value1` doesn't exist."
      Backtrace:
        1. testthat::expect_error(fill_gaps(tsbl, value1 = value), "Unknown column")
       26. vctrs:::stop_subscript_oob(...)
       27. vctrs:::stop_subscript(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 789 | SKIPPED: 2 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: a tbl_ts of 4 day interval with bad names (@test-gaps.R#74) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

