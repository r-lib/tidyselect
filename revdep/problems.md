# arrow

<details>

* Version: 9.0.0.1
* GitHub: https://github.com/apache/arrow
* Source code: https://github.com/cran/arrow
* Date/Publication: 2022-09-14 08:10:02 UTC
* Number of recursive dependencies: 72

Run `cloud_details(, "arrow")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       15.       └─tidyselect:::eval_select_impl(...)
       16.         ├─tidyselect:::with_subscript_errors(...)
       17.         │ └─rlang::try_fetch(...)
       18.         │   └─base::withCallingHandlers(...)
       19.         └─tidyselect:::vars_select_eval(...)
       20.           └─tidyselect:::walk_data_tree(expr, data_mask, context_mask)
       21.             └─tidyselect:::eval_c(expr, data_mask, context_mask)
       22.               └─tidyselect:::reduce_sels(node, data_mask, context_mask, init = init)
       23.                 └─tidyselect:::walk_data_tree(new, data_mask, context_mask)
       24.                   └─tidyselect:::expr_kind(expr, error_call)
       25.                     └─tidyselect:::call_kind(expr, error_call)
      
      [ FAIL 6 | WARN 23 | SKIP 65 | PASS 8194 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 113.7Mb
      sub-directories of 1Mb or more:
        R       4.1Mb
        libs  108.4Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘readr’
    ```

# bumbl

<details>

* Version: 1.0.2
* GitHub: https://github.com/Aariq/bumbl
* Source code: https://github.com/cran/bumbl
* Date/Publication: 2022-05-13 20:20:20 UTC
* Number of recursive dependencies: 101

Run `cloud_details(, "bumbl")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Creating plots for 6 colonies...
      [ FAIL 2 | WARN 26 | SKIP 1 | PASS 39 ]
      
      ══ Skipped tests ═══════════════════════════════════════════════════════════════
      • On CRAN (1)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-bumbl.R:56:3): no unexpected warnings ─────────────────────────
      `bumbl(...)` produced warnings.
      ── Failure (test-bumbl.R:57:3): no unexpected warnings ─────────────────────────
      `bumbl(...)` produced warnings.
      
      [ FAIL 2 | WARN 26 | SKIP 1 | PASS 39 ]
      Error: Test failures
      Execution halted
    ```

# covidcast

<details>

* Version: 0.4.2
* GitHub: https://github.com/cmu-delphi/covidcast
* Source code: https://github.com/cran/covidcast
* Date/Publication: 2021-05-04 07:00:12 UTC
* Number of recursive dependencies: 92

Run `cloud_details(, "covidcast")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       18.       │ └─rlang::try_fetch(...)
       19.       │   └─base::withCallingHandlers(...)
       20.       └─tidyselect:::vars_select_eval(...)
       21.         └─tidyselect:::walk_data_tree(expr, data_mask, context_mask)
       22.           └─tidyselect:::eval_c(expr, data_mask, context_mask)
       23.             └─tidyselect:::reduce_sels(node, data_mask, context_mask, init = init)
       24.               └─tidyselect:::walk_data_tree(new, data_mask, context_mask)
       25.                 └─tidyselect:::expr_kind(expr, error_call)
       26.                   └─tidyselect:::call_kind(expr, error_call)
      ── Failure (test-wrangle.R:286:3): can aggregate signals with different metadata ──
      `aggregate_signals(list(foo, baz))` produced warnings.
      
      [ FAIL 5 | WARN 80 | SKIP 7 | PASS 55 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 20 marked UTF-8 strings
    ```

# crosstable

<details>

* Version: 0.5.0
* GitHub: https://github.com/DanChaltiel/crosstable
* Source code: https://github.com/cran/crosstable
* Date/Publication: 2022-08-16 10:40:02 UTC
* Number of recursive dependencies: 120

Run `cloud_details(, "crosstable")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      `.` produced warnings.
      Backtrace:
          ▆
       1. ├─... %>% expect_silent() at test-selection.R:52:2
       2. └─testthat::expect_silent(.)
      ── Failure (test-selection.R:57:3): crosstable with external character vector ──
      `.` produced warnings.
      Backtrace:
          ▆
       1. ├─... %>% expect_silent() at test-selection.R:57:2
       2. └─testthat::expect_silent(.)
      
      [ FAIL 2 | WARN 791 | SKIP 40 | PASS 343 ]
      Error: Test failures
      Execution halted
    ```

# edibble

<details>

* Version: 0.1.1
* GitHub: https://github.com/emitanaka/edibble
* Source code: https://github.com/cran/edibble
* Date/Publication: 2022-08-26 06:22:35 UTC
* Number of recursive dependencies: 83

Run `cloud_details(, "edibble")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘edibble-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: anatomy
    > ### Title: Anatomy of the design
    > ### Aliases: anatomy
    > 
    > ### ** Examples
    > 
    > split <- takeout(menu_split(t1 = 3, t2 = 2, r = 2))
    ...
      Consider 'structure(list(), *)' instead.
    > anatomy(split)
    Error in `edbl_design()`:
    ! An edibble design is not available in .edibble.
    Backtrace:
        ▆
     1. └─edibble::anatomy(split)
     2.   └─edibble::edbl_design(.edibble)
     3.     └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       18. │       └─vctrs::vec_as_subscript(x, logical = "error", call = call)
       19. └─rlang::cnd_signal(x)
      ── Error (test-rcrds.R:4:3): measure response ──────────────────────────────────
      Error in `edbl_design(.edibble)`: An edibble design is not available in .edibble.
      Backtrace:
          ▆
       1. ├─... %>% assign_trts("random", seed = 1) at test-rcrds.R:4:2
       2. └─edibble::assign_trts(., "random", seed = 1)
       3.   └─edibble:::add_edibble_seed(returnValue(default = FALSE), .RNGstate)
       4.     └─edibble::edbl_design(.edibble)
       5.       └─rlang::abort(...)
      
      [ FAIL 21 | WARN 0 | SKIP 6 | PASS 31 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘R6’
      All declared Imports should be used.
    ```

# ggip

<details>

* Version: 0.2.1
* GitHub: https://github.com/davidchall/ggip
* Source code: https://github.com/cran/ggip
* Date/Publication: 2022-08-13 22:40:02 UTC
* Number of recursive dependencies: 72

Run `cloud_details(, "ggip")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Loading required package: ipaddress
      > 
      > test_check("ggip")
      [ FAIL 1 | WARN 96 | SKIP 5 | PASS 93 ]
      
      ══ Skipped tests ═══════════════════════════════════════════════════════════════
      • On CRAN (5)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-geom-hilbert-outline.R:89:3): networks outside 2D grid raise warning ──
      `layer_grob(p + geom_hilbert_outline(na.rm = TRUE))` produced warnings.
      
      [ FAIL 1 | WARN 96 | SKIP 5 | PASS 93 ]
      Error: Test failures
      Execution halted
    ```

# iNZightTools

<details>

* Version: 1.12.3
* GitHub: https://github.com/iNZightVIT/iNZightTools
* Source code: https://github.com/cran/iNZightTools
* Date/Publication: 2022-08-22 20:20:02 UTC
* Number of recursive dependencies: 86

Run `cloud_details(, "iNZightTools")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test_aggregateData.R:57:5): Aggregating survey data is valid ───────
      `... <- NULL` produced warnings.
      ── Failure (test_aggregateData.R:74:5): Aggregating survey data is valid ───────
      `svy_agg <- aggregateData(svy, "stype", c("iqr"), c("api99", "api00"))` produced warnings.
      ── Failure (test_aggregateData.R:84:5): Aggregating survey data is valid ───────
      `... <- NULL` produced warnings.
      ── Failure (test_filter_levels.R:25:5): Filtering survey design works ──────────
      `svy_filtered <- filterLevels(svy, "stype", "E")` produced warnings.
      ── Failure (test_filter_numeric.R:42:5): Filtering surveys is valid ────────────
      `svy_filtered <- filterNumeric(svy, "api00", "<", 700)` produced warnings.
      
      [ FAIL 5 | WARN 8 | SKIP 5 | PASS 330 ]
      Error: Test failures
      Execution halted
    ```

# metacore

<details>

* Version: 0.0.4
* GitHub: NA
* Source code: https://github.com/cran/metacore
* Date/Publication: 2022-03-31 15:00:02 UTC
* Number of recursive dependencies: 70

Run `cloud_details(, "metacore")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘metacore-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: get_control_term
    > ### Title: Get Control Term
    > ### Aliases: get_control_term
    > 
    > ### ** Examples
    > 
    > meta_ex <- spec_to_metacore(metacore_example("p21_mock.xlsx"))
    ...
      6. ├─dplyr:::mutate.data.frame(...)
      7. │ └─dplyr:::mutate_cols(.data, dplyr_quosures(...), caller_env = caller_env())
      8. │   ├─base::withCallingHandlers(...)
      9. │   └─mask$eval_all_mutate(quo)
     10. ├─stringr::str_split(key_seq, ",\\s")
     11. │ └─stringi::stri_split_regex(...)
     12. └─base::.handleSimpleError(...)
     13.   └─dplyr (local) h(simpleError(msg, call))
     14.     └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        4. ├─dplyr::filter(., code_id != "CL.Y_BLANK")
        5. ├─dplyr::mutate(., code_id = paste0("CL.", code_id))
        6. ├─metacore::spec_type_to_codelist(spec, simplify = FALSE)
        7. │ └─... %>% ...
        8. ├─dplyr::mutate(...)
        9. ├─tidyr::nest(., codes = c(code, decode))
       10. ├─dplyr::mutate(...)
       11. ├─dplyr::group_by(., code_id)
       12. └─dplyr:::group_by.data.frame(., code_id)
       13.   └─dplyr::group_by_prepare(.data, ..., .add = .add, caller_env = caller_env())
       14.     └─rlang::abort(bullets, call = error_call)
      
      [ FAIL 10 | WARN 0 | SKIP 0 | PASS 45 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘Building_Specification_Readers.Rmd’ using rmarkdown
    Quitting from lines 121-132 (Building_Specification_Readers.Rmd) 
    Error: processing vignette 'Building_Specification_Readers.Rmd' failed with diagnostics:
    Problem while computing `key_seq = str_split(key_seq, ",\\s")`.
    Caused by error in `stri_split_regex()`:
    ! object 'key_seq' not found
    --- failed re-building ‘Building_Specification_Readers.Rmd’
    
    --- re-building ‘Example.Rmd’ using rmarkdown
    --- finished re-building ‘Example.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘Building_Specification_Readers.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# metatools

<details>

* Version: 0.1.1
* GitHub: NA
* Source code: https://github.com/cran/metatools
* Date/Publication: 2022-04-20 08:52:30 UTC
* Number of recursive dependencies: 66

Run `cloud_details(, "metatools")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘metatools-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: create_var_from_codelist
    > ### Title: Create Variable from Codelist
    > ### Aliases: create_var_from_codelist
    > 
    > ### ** Examples
    > 
    > library(metacore)
    ...
      6. ├─dplyr:::mutate.data.frame(...)
      7. │ └─dplyr:::mutate_cols(.data, dplyr_quosures(...), caller_env = caller_env())
      8. │   ├─base::withCallingHandlers(...)
      9. │   └─mask$eval_all_mutate(quo)
     10. ├─stringr::str_split(key_seq, ",\\s")
     11. │ └─stringi::stri_split_regex(...)
     12. └─base::.handleSimpleError(...)
     13.   └─dplyr (local) h(simpleError(msg, call))
     14.     └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        4. ├─tidyr::unnest(., key_seq)
        5. ├─dplyr::mutate(...)
        6. ├─dplyr:::mutate.data.frame(...)
        7. │ └─dplyr:::mutate_cols(.data, dplyr_quosures(...), caller_env = caller_env())
        8. │   ├─base::withCallingHandlers(...)
        9. │   └─mask$eval_all_mutate(quo)
       10. ├─stringr::str_split(key_seq, ",\\s")
       11. │ └─stringi::stri_split_regex(...)
       12. └─base::.handleSimpleError(...)
       13.   └─dplyr (local) h(simpleError(msg, call))
       14.     └─rlang::abort(...)
      
      [ FAIL 4 | WARN 438 | SKIP 0 | PASS 50 ]
      Error: Test failures
      Execution halted
    ```

# namedropR

<details>

* Version: 2.4.1
* GitHub: https://github.com/nucleic-acid/namedropR
* Source code: https://github.com/cran/namedropR
* Date/Publication: 2022-08-28 10:50:02 UTC
* Number of recursive dependencies: 98

Run `cloud_details(, "namedropR")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      bulk_res4$warnings[2] (`actual`) not equal to "No reference matches the given cite_keys. Please check that citation key(s) are correct." (`expected`).
      
      lines(actual) vs lines(expected)
      - "Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0."
      - "Please use `\"AUTHOR\"` instead of `.data$AUTHOR`"
      + "No reference matches the given cite_keys. Please check that citation key(s) are correct."
      Backtrace:
          ▆
       1. ├─withr::with_dir(...) at test-drop_name.R:145:2
       2. │ └─base::force(code)
       3. └─testthat::expect_equal(bulk_res4$warnings[2], "No reference matches the given cite_keys. Please check that citation key(s) are correct.") at test-drop_name.R:164:6
      
      [ FAIL 2 | WARN 62 | SKIP 0 | PASS 57 ]
      Error: Test failures
      Execution halted
    ```

# r2dii.analysis

<details>

* Version: 0.2.0
* GitHub: https://github.com/2DegreesInvesting/r2dii.analysis
* Source code: https://github.com/cran/r2dii.analysis
* Date/Publication: 2022-05-05 12:50:02 UTC
* Number of recursive dependencies: 76

Run `cloud_details(, "r2dii.analysis")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       14.       └─tidyselect:::eval_select_impl(...)
       15.         ├─tidyselect:::with_subscript_errors(...)
       16.         │ └─rlang::try_fetch(...)
       17.         │   └─base::withCallingHandlers(...)
       18.         └─tidyselect:::vars_select_eval(...)
       19.           └─tidyselect:::walk_data_tree(expr, data_mask, context_mask)
       20.             └─tidyselect:::eval_c(expr, data_mask, context_mask)
       21.               └─tidyselect:::reduce_sels(node, data_mask, context_mask, init = init)
       22.                 └─tidyselect:::walk_data_tree(new, data_mask, context_mask)
       23.                   └─tidyselect:::expr_kind(expr, error_call)
       24.                     └─tidyselect:::call_kind(expr, error_call)
      
      [ FAIL 1 | WARN 1243 | SKIP 4 | PASS 265 ]
      Error: Test failures
      Execution halted
    ```

# r2dii.match

<details>

* Version: 0.1.1
* GitHub: https://github.com/2DegreesInvesting/r2dii.match
* Source code: https://github.com/cran/r2dii.match
* Date/Publication: 2022-09-05 12:50:05 UTC
* Number of recursive dependencies: 71

Run `cloud_details(, "r2dii.match")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       19.       └─tidyselect:::eval_select_impl(...)
       20.         ├─tidyselect:::with_subscript_errors(...)
       21.         │ └─rlang::try_fetch(...)
       22.         │   └─base::withCallingHandlers(...)
       23.         └─tidyselect:::vars_select_eval(...)
       24.           └─tidyselect:::walk_data_tree(expr, data_mask, context_mask)
       25.             └─tidyselect:::eval_c(expr, data_mask, context_mask)
       26.               └─tidyselect:::reduce_sels(node, data_mask, context_mask, init = init)
       27.                 └─tidyselect:::walk_data_tree(new, data_mask, context_mask)
       28.                   └─tidyselect:::expr_kind(expr, error_call)
       29.                     └─tidyselect:::call_kind(expr, error_call)
      
      [ FAIL 1 | WARN 759 | SKIP 5 | PASS 169 ]
      Error: Test failures
      Execution halted
    ```

# SynthCast

<details>

* Version: 0.2.1
* GitHub: NA
* Source code: https://github.com/cran/SynthCast
* Date/Publication: 2022-03-08 14:50:02 UTC
* Number of recursive dependencies: 100

Run `cloud_details(, "SynthCast")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
        `actual`: 2
      `expected`: 4
      ── Failure (test-syth-cast.R:223:5): Tests run_synthetic_forecast() ────────────
      names(synthetic_forecast) (`actual`) not equal to c(...) (`expected`).
      
          actual    | expected                                
      [1] "message" - "synthetic_control_composition"      [1]
      [2] "call"    - "variable_importance_and_comparison" [2]
                    - "mape_backtest"                      [3]
                    - "output_projecao"                    [4]
      
      [ FAIL 11 | WARN 0 | SKIP 0 | PASS 10 ]
      Error: Test failures
      Execution halted
    ```

# targets

<details>

* Version: 0.13.4
* GitHub: https://github.com/ropensci/targets
* Source code: https://github.com/cran/targets
* Date/Publication: 2022-09-15 16:56:11 UTC
* Number of recursive dependencies: 170

Run `cloud_details(, "targets")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Error (test-tar_newer.R:8:3): tar_newer() works ─────────────────────────────
      Error in `tar_tidyselect_eval(names_quosure, meta$name)`: Problem while evaluating `all_of("y")`.
      Caused by error in `all_of()`:
      ! Can't subset elements that don't exist.
      x Element `y` doesn't exist.
      ── Error (test-tar_older.R:8:3): tar_older() works ─────────────────────────────
      Error in `tar_tidyselect_eval(names_quosure, meta$name)`: Problem while evaluating `all_of("y")`.
      Caused by error in `all_of()`:
      ! Can't subset elements that don't exist.
      x Element `y` doesn't exist.
      
      [ FAIL 2 | WARN 0 | SKIP 387 | PASS 2472 ]
      Error: Test failures
      Execution halted
    ```

# textrecipes

<details>

* Version: 1.0.0
* GitHub: https://github.com/tidymodels/textrecipes
* Source code: https://github.com/cran/textrecipes
* Date/Publication: 2022-07-02 07:10:02 UTC
* Number of recursive dependencies: 121

Run `cloud_details(, "textrecipes")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       18.     └─tidyselect:::eval_select_impl(...)
       19.       ├─tidyselect:::with_subscript_errors(...)
       20.       │ └─rlang::try_fetch(...)
       21.       │   └─base::withCallingHandlers(...)
       22.       └─tidyselect:::vars_select_eval(...)
       23.         └─tidyselect:::walk_data_tree(expr, data_mask, context_mask)
       24.           └─tidyselect:::eval_c(expr, data_mask, context_mask)
       25.             └─tidyselect:::reduce_sels(node, data_mask, context_mask, init = init)
       26.               └─tidyselect:::walk_data_tree(new, data_mask, context_mask)
       27.                 └─tidyselect:::expr_kind(expr, error_call)
       28.                   └─tidyselect:::call_kind(expr, error_call)
      
      [ FAIL 2 | WARN 17 | SKIP 88 | PASS 344 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4 marked UTF-8 strings
    ```

