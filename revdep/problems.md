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
      
      [ FAIL 2 | WARN 792 | SKIP 40 | PASS 343 ]
      Error: Test failures
      Execution halted
    ```

# galah

<details>

* Version: 1.4.0
* GitHub: https://github.com/AtlasOfLivingAustralia/galah
* Source code: https://github.com/cran/galah
* Date/Publication: 2022-01-24 10:52:46 UTC
* Number of recursive dependencies: 166

Run `cloud_details(, "galah")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ Skipped tests ═══════════════════════════════════════════════════════════════
      • On CRAN (32)
      • Slow test (1)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-galah_select.R:17:3): galah_select returns requested columns ──
      names(query) not equal to c("year", "basisOfRecord").
      Lengths differ: 9 is not 2
      ── Failure (test-galah_select.R:18:3): galah_select returns requested columns ──
      names(query) not equal to selected_columns[[1]].
      Lengths differ: 9 is not 2
      
      [ FAIL 2 | WARN 0 | SKIP 33 | PASS 228 ]
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

