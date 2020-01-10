# arrow

<details>

* Version: 0.15.1.1
* Source code: https://github.com/cran/arrow
* URL: https://github.com/apache/arrow/, https://arrow.apache.org/docs/r
* BugReports: https://issues.apache.org/jira/projects/ARROW/issues
* Date/Publication: 2019-11-05 22:00:09 UTC
* Number of recursive dependencies: 59

Run `revdep_details(,"arrow")` for more info

</details>

## Newly broken

*   checking installed package size ... NOTE
    ```
      installed size is 10.9Mb
      sub-directories of 1Mb or more:
        libs   7.7Mb
        R      3.0Mb
    ```

## Newly fixed

*   checking whether package ‘arrow’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/lionel/Desktop/tidyselect/revdep-all/tidyselect/checks.noindex/arrow/old/arrow.Rcheck/00install.out’ for details.
    ```

# AzureKusto

<details>

* Version: 1.0.4
* Source code: https://github.com/cran/AzureKusto
* URL: https://github.com/Azure/AzureKusto https://github.com/Azure/AzureR
* BugReports: https://github.com/Azure/AzureKusto/issues
* Date/Publication: 2019-10-26 22:30:08 UTC
* Number of recursive dependencies: 67

Run `revdep_details(,"AzureKusto")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       10. AzureKusto::flatten_query(op$ops) revdep-all/tidyselect/checks.noindex/AzureKusto/new/AzureKusto.Rcheck/00_pkg_src/AzureKusto/R/kql-build.R:12:4
       12. AzureKusto:::op_vars.op_rename(flat_op) revdep-all/tidyselect/checks.noindex/AzureKusto/new/AzureKusto.Rcheck/00_pkg_src/AzureKusto/R/ops.R:230:11
       13. tidyselect::vars_rename(op_vars(op$x), !!!op$dots) revdep-all/tidyselect/checks.noindex/AzureKusto/new/AzureKusto.Rcheck/00_pkg_src/AzureKusto/R/ops.R:247:4
       14. tidyselect:::rename_impl(NULL, .vars, quo(c(...)), strict = .strict)
       15. tidyselect:::eval_select_impl(...)
       16. tidyselect:::subclass_index_errors(...)
      
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
* Number of recursive dependencies: 72

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

* Version: 0.0.1
* Source code: https://github.com/cran/cheese
* URL: https://github.com/zajichek/cheese
* Date/Publication: 2019-04-01 08:10:03 UTC
* Number of recursive dependencies: 91

Run `revdep_details(,"cheese")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    +         by = -matches("^(S|H)")
    + )
    Error: Selections can't have negative values.
    <error/rlang_error>
    Selections can't have negative values.
    Backtrace:
         █
      1. └─heart_disease %>% select(Sex, HeartDisease, BloodSugar) %>% divide(by = -matches("^(S|H)"))
      2.   ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      3.   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      4.     └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5.       └─`_fseq`(`_lhs`)
      6.         └─magrittr::freduce(value, `_function_list`)
      7.           ├─base::withVisible(function_list[[k]](value))
      8.           └─function_list[[k]](value)
      9.             └─cheese::divide(., by = -matches("^(S|H)"))
     10.               └─data %>% dplyr::select(by) 00_pkg_src/cheese/R/FUNCTIONS.R:16:8
     11.                 ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
     12.                 └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
     13.                   └─base::eval(quote(`_fseq`(`_lhs`))
    Execution halted
    ```

# dplyr

<details>

* Version: 0.8.3
* Source code: https://github.com/cran/dplyr
* URL: http://dplyr.tidyverse.org, https://github.com/tidyverse/dplyr
* BugReports: https://github.com/tidyverse/dplyr/issues
* Date/Publication: 2019-07-04 15:50:02 UTC
* Number of recursive dependencies: 94

Run `revdep_details(,"dplyr")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        8. dplyr:::tbl_at_syms(.tbl, .vars, .include_group_vars = .include_group_vars) revdep-all/tidyselect/checks.noindex/dplyr/new/dplyr.Rcheck/00_pkg_src/dplyr/R/colwise-mutate.R:290:2
        9. dplyr:::tbl_at_vars(tbl, vars, .include_group_vars = .include_group_vars) revdep-all/tidyselect/checks.noindex/dplyr/new/dplyr.Rcheck/00_pkg_src/dplyr/R/colwise.R:169:2
       10. tidyselect::vars_select(tibble_vars, !!!vars) revdep-all/tidyselect/checks.noindex/dplyr/new/dplyr.Rcheck/00_pkg_src/dplyr/R/colwise.R:157:4
       11. tidyselect:::eval_select_impl(...)
       12. tidyselect:::subclass_index_errors(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 3404 | SKIPPED: 14 | WARNINGS: 1 | FAILED: 2 ]
      1. Error: *_(all,at) handle utf-8 names (#2967) (@colwise-select.R#92) 
      2. Failure: colwise mutate gives correct error message if column not found (#4374) (@test-colwise-mutate.R#430) 
      
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

*   checking installed package size ... NOTE
    ```
      installed size is  5.3Mb
      sub-directories of 1Mb or more:
        libs   2.8Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4 marked UTF-8 strings
    ```

# dtplyr

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/dtplyr
* URL: https://github.com/tidyverse/dtplyr
* BugReports: https://github.com/tidyverse/dtplyr/issues
* Date/Publication: 2019-11-12 09:30:02 UTC
* Number of recursive dependencies: 60

Run `revdep_details(,"dtplyr")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ── 1. Error: renames grouping vars (@test-step-call.R#49)  ─────────────────────
      Names must be unique.
      Backtrace:
       1. testthat::expect_equal(rename(gt, y = x)$groups, "y")
       5. dtplyr:::rename.dtplyr_step(gt, y = x)
       6. tidyselect::vars_rename(.data$vars, ...) revdep-all/tidyselect/checks.noindex/dtplyr/new/dtplyr.Rcheck/00_pkg_src/dtplyr/R/step-call.R:40:2
       7. tidyselect:::rename_impl(NULL, .vars, quo(c(...)), strict = .strict)
       8. tidyselect:::subclass_index_errors(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 187 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: renames grouping vars (@test-step-call.R#49) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# mudata2

<details>

* Version: 1.1.0
* Source code: https://github.com/cran/mudata2
* URL: https://paleolimbot.github.io/mudata2, https://github.com/paleolimbot/mudata2
* BugReports: https://github.com/paleolimbot/mudata2/issues
* Date/Publication: 2020-01-09 16:50:02 UTC
* Number of recursive dependencies: 93

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

# probably

<details>

* Version: 0.0.3
* Source code: https://github.com/cran/probably
* URL: https://github.com/tidymodels/probably/
* BugReports: https://github.com/tidymodels/probably/issues
* Date/Publication: 2019-07-07 22:40:03 UTC
* Number of recursive dependencies: 85

Run `revdep_details(,"probably")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      `manual_creation_eq[1:6]` threw an error with unexpected message.
      Expected match: "5 and you've tried to subset element 6"
      Actual message: "Must index existing elements.\n✖ Can't subset position 6.\nℹ There are only 5 elements."
      Backtrace:
        1. testthat::expect_error(manual_creation_eq[1:6], "5 and you've tried to subset element 6")
       10. vctrs::stop_subscript_oob_location(i = i, size = size)
       11. vctrs:::stop_subscript_oob(...)
       12. vctrs:::stop_subscript(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 116 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: slicing (@test-class-pred.R#212) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# RSDA

<details>

* Version: 3.0
* Source code: https://github.com/cran/RSDA
* URL: http://www.oldemarrodriguez.com
* Date/Publication: 2019-10-22 05:30:02 UTC
* Number of recursive dependencies: 127

Run `revdep_details(,"RSDA")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > 
      > test_check("RSDA")
      ── 1. Failure: multiplication works (@test-read_sym_table.R#9)  ────────────────
      is.sym.modal(sym.table$F3) isn't true.
      
      ── 2. Failure: multiplication works (@test-read_sym_table.R#11)  ───────────────
      is.sym.set(sym.table$F5) isn't true.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 24 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 2 ]
      1. Failure: multiplication works (@test-read_sym_table.R#9) 
      2. Failure: multiplication works (@test-read_sym_table.R#11) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# tibbleOne

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/tibbleOne
* Date/Publication: 2019-10-28 15:10:02 UTC
* Number of recursive dependencies: 108

Run `revdep_details(,"tibbleOne")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Names must be unique.
      Backtrace:
        1. tibbleOne::to_kable(tb1, format = "latex")
        2. [ `%<>%`(...) ] with 7 more calls revdep-all/tidyselect/checks.noindex/tibbleOne/new/tibbleOne.Rcheck/00_pkg_src/tibbleOne/R/to_kable.R:225:6
       11. dplyr:::rename.data.frame(., !!!names_to_repair)
       12. tidyselect::vars_rename(names(.data), !!!enquos(...))
       13. tidyselect:::rename_impl(NULL, .vars, quo(c(...)), strict = .strict)
       14. tidyselect:::subclass_index_errors(...)
      
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

# tidyr

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/tidyr
* URL: https://tidyr.tidyverse.org, https://github.com/tidyverse/tidyr
* BugReports: https://github.com/tidyverse/tidyr/issues
* Date/Publication: 2019-09-11 23:00:03 UTC
* Number of recursive dependencies: 62

Run `revdep_details(,"tidyr")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ── 5. Failure: values_summarize applied even when no-duplicates (@test-pivot-wid
      pv$x not equal to list_of(1L, 2L).
      Attributes: < target is NULL, current is list >
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 557 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 5 ]
      1. Failure: can nest multiple columns (@test-nest.R#80) 
      2. Failure: can nest multiple columns (@test-nest.R#81) 
      3. Failure: duplicated keys produce list column with warning (@test-pivot-wide.R#73) 
      4. Failure: warning suppressed by supplying values_fn (@test-pivot-wide.R#87) 
      5. Failure: values_summarize applied even when no-duplicates (@test-pivot-wide.R#99) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 24 marked UTF-8 strings
    ```

# tsibble

<details>

* Version: 0.8.5
* Source code: https://github.com/cran/tsibble
* URL: https://tsibble.tidyverts.org
* BugReports: https://github.com/tidyverts/tsibble/issues
* Date/Publication: 2019-11-03 06:00:02 UTC
* Number of recursive dependencies: 94

Run `revdep_details(,"tsibble")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Expected match: "Unknown column"
      Actual message: "Must select existing columns.\n✖ Can't subset element with unknown name `value1`."
      Backtrace:
        1. testthat::expect_error(fill_gaps(tsbl, value1 = value), "Unknown column")
        7. tsibble:::fill_gaps.tbl_ts(tsbl, value1 = value) revdep-all/tidyselect/checks.noindex/tsibble/new/tsibble.Rcheck/00_pkg_src/tsibble/R/gaps.R:66:2
        8. tidyselect::vars_select(measured_vars(.data), !!!names(lst_exprs)) revdep-all/tidyselect/checks.noindex/tsibble/new/tsibble.Rcheck/00_pkg_src/tsibble/R/gaps.R:85:4
        9. tidyselect:::eval_select_impl(...)
       10. tidyselect:::subclass_index_errors(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 789 | SKIPPED: 2 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: a tbl_ts of 4 day interval with bad names (@test-gaps.R#74) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

