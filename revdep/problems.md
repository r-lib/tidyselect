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

# baseballr

<details>

* Version: 1.3.0
* GitHub: https://github.com/BillPetti/baseballr
* Source code: https://github.com/cran/baseballr
* Date/Publication: 2022-09-09 07:52:55 UTC
* Number of recursive dependencies: 116

Run `cloud_details(, "baseballr")` for more info

</details>

## Newly broken

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘baseballr.Rmd’ using rmarkdown
    --- finished re-building ‘baseballr.Rmd’
    
    --- re-building ‘ncaa_scraping.Rmd’ using rmarkdown
    Quitting from lines 30-34 (ncaa_scraping.Rmd) 
    Error: processing vignette 'ncaa_scraping.Rmd' failed with diagnostics:
    no applicable method for 'select' applied to an object of class "function"
    --- failed re-building ‘ncaa_scraping.Rmd’
    ...
    --- finished re-building ‘plotting_statcast.Rmd’
    
    --- re-building ‘using_statcast_pitch_data.Rmd’ using rmarkdown
    --- finished re-building ‘using_statcast_pitch_data.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘ncaa_scraping.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# blsR

<details>

* Version: 0.3.1
* GitHub: https://github.com/groditi/blsR
* Source code: https://github.com/cran/blsR
* Date/Publication: 2022-07-23 21:50:03 UTC
* Number of recursive dependencies: 53

Run `cloud_details(, "blsR")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        3.     ├─purrr::reduce(...)
        4.     │ └─purrr:::reduce_impl(.x, .f, ..., .init = .init, .dir = .dir)
        5.     │   ├─dplyr (local) fn(out, elt, ...)
        6.     │   └─dplyr:::left_join.data.frame(out, elt, ...)
        7.     │     └─dplyr:::join_mutate(...)
        8.     │       └─dplyr:::join_cols(...)
        9.     │         └─dplyr:::standardise_join_by(...)
       10.     └─dplyr::all_of(join_by)
       11.       └─tidyselect::peek_vars(fn = "all_of")
       12.         └─cli::cli_abort(...)
       13.           └─rlang::abort(...)
      
      [ FAIL 3 | WARN 5 | SKIP 2 | PASS 39 ]
      Error: Test failures
      Execution halted
    ```

# broom.helpers

<details>

* Version: 1.8.0
* GitHub: https://github.com/larmarange/broom.helpers
* Source code: https://github.com/cran/broom.helpers
* Date/Publication: 2022-07-05 22:40:09 UTC
* Number of recursive dependencies: 205

Run `cloud_details(, "broom.helpers")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘broom.helpers-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: tidy_select_variables
    > ### Title: Select variables to keep/drop
    > ### Aliases: tidy_select_variables
    > 
    > ### ** Examples
    > 
    > res <- Titanic %>%
    ...
      <chr> <chr>   <chr>   <chr>     <int>   <dbl>   <dbl>   <dbl>    <dbl>   <dbl>
    1 (Int… (Inter… <NA>    interc…      NA   2.18    0.176  12.4   3.08e-35   1.84 
    2 AgeC… Age     charac… dichot…       2  -0.110   0.335  -0.328 7.43e- 1  -0.759
    3 AgeC… Age:Sex <NA>    intera…      NA   1.90    0.433   4.39  1.12e- 5   1.04 
    # … with 1 more variable: conf.high <dbl>, and abbreviated variable names
    #   ¹​variable, ²​var_class, ³​var_type, ⁴​var_nlevels, ⁵​estimate, ⁶​std.error,
    #   ⁷​statistic, ⁸​conf.low
    > res %>% tidy_select_variables(include = all_categorical())
    Error: Error in `include=` argument input. Select from ‘(Intercept)’, ‘Class’, ‘Age’, ‘Sex’, ‘Age:Sex’
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        1. ├─testthat::expect_equal(...) at test-select_helpers.R:220:2
        2. │ └─testthat::quasi_label(enquo(object), label, arg = "object")
        3. │   └─rlang::eval_bare(expr, quo_get_env(quo))
        4. ├─... %>% sum()
        5. ├─... %in% "trt"
        6. └─broom.helpers::tidy_add_header_rows(mod_tidy, show_single_row = all_dichotomous())
        7.   └─broom.helpers::.select_to_varnames(...)
        8.     └─base::tryCatch(...)
        9.       └─base (local) tryCatchList(expr, classes, parentenv, handlers)
       10.         └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
       11.           └─value[[3L]](cond)
      
      [ FAIL 2 | WARN 2 | SKIP 52 | PASS 460 ]
      Error: Test failures
      Execution halted
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

# cheese

<details>

* Version: 0.1.1
* GitHub: https://github.com/zajichek/cheese
* Source code: https://github.com/cran/cheese
* Date/Publication: 2020-10-19 17:40:09 UTC
* Number of recursive dependencies: 66

Run `cloud_details(, "cheese")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘cheese-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: stretch
    > ### Title: Span keys and values across the columns
    > ### Aliases: stretch
    > 
    > ### ** Examples
    > 
    > 
    ...
      8. ├─dplyr::summarise(...)
      9. ├─dplyr::group_by_at(., tidyselect::all_of(".id"))
     10. │ └─dplyr:::manip_at(...)
     11. │   └─dplyr:::tbl_at_syms(...)
     12. │     └─dplyr:::tbl_at_vars(...)
     13. └─tidyselect::all_of(".id")
     14.   └─tidyselect::peek_vars(fn = "all_of")
     15.     └─cli::cli_abort(...)
     16.       └─rlang::abort(...)
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘cheese.Rmd’ using rmarkdown
    Quitting from lines 388-395 (cheese.Rmd) 
    Error: processing vignette 'cheese.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘cheese.Rmd’
    
    ...
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘describe.Rmd’
    
    SUMMARY: processing the following files failed:
      ‘cheese.Rmd’ ‘describe.Rmd’
    
    Error: Vignette re-building failed.
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
      
      [ FAIL 2 | WARN 789 | SKIP 40 | PASS 343 ]
      Error: Test failures
      Execution halted
    ```

# cvCovEst

<details>

* Version: 1.1.0
* GitHub: https://github.com/PhilBoileau/cvCovEst
* Source code: https://github.com/cran/cvCovEst
* Date/Publication: 2022-05-04 11:50:02 UTC
* Number of recursive dependencies: 127

Run `cloud_details(, "cvCovEst")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(testthat)
      > library(cvCovEst)
      cvCovEst v1.1.0: Cross-Validated Covariance Matrix Estimation
      > 
      > test_check("cvCovEst")
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 167 ]
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-plot-functions.R:72:3): Objects of other known classes throw an error ──
      `summary(cvTestH, dat)` produced warnings.
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 167 ]
      Error: Test failures
      Execution halted
    ```

# datawizard

<details>

* Version: 0.6.0
* GitHub: https://github.com/easystats/datawizard
* Source code: https://github.com/cran/datawizard
* Date/Publication: 2022-09-15 12:00:02 UTC
* Number of recursive dependencies: 184

Run `cloud_details(, "datawizard")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      `actual$Petal.Width` is a double vector (0.2, 0.2, 0.2, 0.2, 0.2, ...)
      `expected$Petal.Width` is absent
      
      `actual$Species` is an S3 object of class <factor>, an integer vector
      `expected$Species` is absent
      
      `actual$Sepal.Length` is absent
      `expected$Sepal.Length` is a double vector (5.1, 4.9, 4.7, 4.6, 5, ...)
      
      [ FAIL 2 | WARN 7 | SKIP 27 | PASS 1102 ]
      Deleting unused snapshots:
      • format_text.md
      Error: Test failures
      Execution halted
    ```

# dumbbell

<details>

* Version: 0.1
* GitHub: https://github.com/foocheung2/dumbbell
* Source code: https://github.com/cran/dumbbell
* Date/Publication: 2021-02-25 09:10:02 UTC
* Number of recursive dependencies: 131

Run `cloud_details(, "dumbbell")` for more info

</details>

## Newly broken

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘dumbbell.Rmd’ using rmarkdown
    Warning in eng_r(options) :
      Failed to tidy R code in chunk 'unnamed-chunk-2'. Reason:
    Error : The formatR package is required by the chunk option tidy = TRUE but not installed; tidy = TRUE will be ignored.
    
    Selecting by val
    Warning in eng_r(options) :
      Failed to tidy R code in chunk 'unnamed-chunk-3'. Reason:
    Error : The formatR package is required by the chunk option tidy = TRUE but not installed; tidy = TRUE will be ignored.
    ...
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘dumbbell.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘dumbbell.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

## In both

*   checking LazyData ... NOTE
    ```
      'LazyData' is specified without a 'data' directory
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

# eHDPrep

<details>

* Version: 1.2.1
* GitHub: NA
* Source code: https://github.com/cran/eHDPrep
* Date/Publication: 2022-09-07 07:50:14 UTC
* Number of recursive dependencies: 120

Run `cloud_details(, "eHDPrep")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘eHDPrep-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: apply_quality_ctrl
    > ### Title: Apply quality control measures to a dataset
    > ### Aliases: apply_quality_ctrl
    > 
    > ### ** Examples
    > 
    > data(example_data)
    ...
      4. │ └─base::withCallingHandlers(...)
      5. ├─eHDPrep::encode_cats(...)
      6. │ └─dplyr::select(data, !!!dplyr::enquos(...))
      7. ├─base::suppressMessages(.)
      8. │ └─base::withCallingHandlers(...)
      9. └─dplyr::all_of(select_by_datatype(class_tbl, "freetext"))
     10.   └─tidyselect::peek_vars(fn = "all_of")
     11.     └─cli::cli_abort(...)
     12.       └─rlang::abort(...)
    Execution halted
    ```

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘Introduction_to_eHDPrep.Rmd’ using rmarkdown
    Quitting from lines 239-245 (Introduction_to_eHDPrep.Rmd) 
    Error: processing vignette 'Introduction_to_eHDPrep.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘Introduction_to_eHDPrep.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘Introduction_to_eHDPrep.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 7 marked UTF-8 strings
    ```

# finnts

<details>

* Version: 0.2.0
* GitHub: https://github.com/microsoft/finnts
* Source code: https://github.com/cran/finnts
* Date/Publication: 2022-07-14 15:40:05 UTC
* Number of recursive dependencies: 204

Run `cloud_details(, "finnts")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      # … with 3 variables: .model_id <int>, .model <list>, .model_desc <chr>
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Error (test-forecast_time_series.R:23:1): (code run outside of `test_that()`) ──
      Error in `FUN(X[[i]], ...)`: all individual models failed during initial training
      Backtrace:
          ▆
       1. └─finnts::forecast_time_series(...) at test-forecast_time_series.R:23:0
       2.   └─base::lapply(combo_list, forecast_models_fn)
       3.     └─finnts (local) FUN(X[[i]], ...)
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]
      Error: Test failures
      Execution halted
    ```

# ggalluvial

<details>

* Version: 0.12.3
* GitHub: https://github.com/corybrunson/ggalluvial
* Source code: https://github.com/cran/ggalluvial
* Date/Publication: 2020-12-05 16:20:02 UTC
* Number of recursive dependencies: 89

Run `cloud_details(, "ggalluvial")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Loading required package: ggplot2
      > 
      > test_check("ggalluvial")
      [ FAIL 1 | WARN 2 | SKIP 7 | PASS 59 ]
      
      ══ Skipped tests ═══════════════════════════════════════════════════════════════
      • On CRAN (7)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-alluvial-data.r:50:3): `is_lodes_form` recognizes lodes-format Titanic data ──
      `is_lodes_form(titanic_lodes)` did not throw an error.
      
      [ FAIL 1 | WARN 2 | SKIP 7 | PASS 59 ]
      Error: Test failures
      Execution halted
    ```

# GGally

<details>

* Version: 2.1.2
* GitHub: https://github.com/ggobi/ggally
* Source code: https://github.com/cran/GGally
* Date/Publication: 2021-06-21 04:40:10 UTC
* Number of recursive dependencies: 146

Run `cloud_details(, "GGally")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        7. │ └─base::print(x)
        8. ├─GGally::ggcoef_model(...)
        9. │ └─GGally:::ggcoef_data(...)
       10. │   └─broom.helpers::tidy_plus_plus(...)
       11. │     └─res %>% ...
       12. └─broom.helpers::tidy_add_reference_rows(...)
       13.   └─broom.helpers::.select_to_varnames(...)
       14.     └─base::tryCatch(...)
       15.       └─base (local) tryCatchList(expr, classes, parentenv, handlers)
       16.         └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
       17.           └─value[[3L]](cond)
      
      [ FAIL 1 | WARN 1252 | SKIP 3 | PASS 626 ]
      Error: Test failures
      Execution halted
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

# gtreg

<details>

* Version: 0.1.1
* GitHub: https://github.com/shannonpileggi/gtreg
* Source code: https://github.com/cran/gtreg
* Date/Publication: 2022-08-17 14:30:05 UTC
* Number of recursive dependencies: 101

Run `cloud_details(, "gtreg")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        4. ├─purrr::when(...)
        5. └─gtsummary::modify_header(...)
        6.   └─gtsummary:::.combine_update_and_dots(x, update, ...)
        7.     └─broom.helpers::.formula_list_to_named_list(...)
        8.       ├─... %>% list()
        9.       └─broom.helpers:::.single_formula_to_list(...)
       10.         └─broom.helpers::.select_to_varnames(...)
       11.           └─base::tryCatch(...)
       12.             └─base (local) tryCatchList(expr, classes, parentenv, handlers)
       13.               └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
       14.                 └─value[[3L]](cond)
      
      [ FAIL 2 | WARN 626 | SKIP 4 | PASS 49 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘counting-methods.Rmd’ using rmarkdown
    Quitting from lines 92-101 (counting-methods.Rmd) 
    Error: processing vignette 'counting-methods.Rmd' failed with diagnostics:
    Error in `... or update=` argument input. Select from 'tbl_id1', 'tbl_id2', 'variable', 'var_type', 'var_label', 'row_type', 'label', 'stat_1', 'stat_2', 'stat_3'
    --- failed re-building ‘counting-methods.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘counting-methods.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# gtsummary

<details>

* Version: 1.6.1
* GitHub: https://github.com/ddsjoberg/gtsummary
* Source code: https://github.com/cran/gtsummary
* Date/Publication: 2022-06-22 07:40:11 UTC
* Number of recursive dependencies: 183

Run `cloud_details(, "gtsummary")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘gtsummary-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: add_p.tbl_summary
    > ### Title: Adds p-values to summary tables
    > ### Aliases: add_p.tbl_summary
    > 
    > ### ** Examples
    > 
    > # Example 1 ----------------------------------
    ...
    +   select(trt, age, marker) %>%
    +   tbl_summary(by = trt, missing = "no") %>%
    +   add_p(
    +     # perform t-test for all variables
    +     test = everything() ~ "t.test",
    +     # assume equal variance in the t-test
    +     test.args = all_tests("t.test") ~ list(var.equal = TRUE)
    +   )
    Error: Error in `test.args=` argument input. Select from ‘age’, ‘marker’
    Execution halted
    ```

# GWPR.light

<details>

* Version: 0.2.1
* GitHub: https://github.com/MichaelChaoLi-cpu/GWPR.light
* Source code: https://github.com/cran/GWPR.light
* Date/Publication: 2022-06-21 11:00:13 UTC
* Number of recursive dependencies: 131

Run `cloud_details(, "GWPR.light")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘GWPR.light-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: GWPR.moran.test
    > ### Title: Moran's I Test for Panel Regression
    > ### Aliases: GWPR.moran.test
    > 
    > ### ** Examples
    > 
    > data(TransAirPolCalif)
    ...
      4.   │ └─sp (local) .local(x, y, ...)
      5.   │   ├─base::merge(...)
      6.   │   ├─base::merge(...)
      7.   │   └─base::merge.data.frame(...)
      8.   │     └─base (local) fix.by(by.x, x)
      9.   └─dplyr::all_of((colnames(plm::index(plm_model$model))[1]))
     10.     └─tidyselect::peek_vars(fn = "all_of")
     11.       └─cli::cli_abort(...)
     12.         └─rlang::abort(...)
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘introduction_of_GWPR.Rmd’ using rmarkdown
    Quitting from lines 161-164 (introduction_of_GWPR.Rmd) 
    Error: processing vignette 'introduction_of_GWPR.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘introduction_of_GWPR.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘introduction_of_GWPR.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# hyperSpec

<details>

* Version: 0.100.0
* GitHub: https://github.com/r-hyperspec/hyperSpec
* Source code: https://github.com/cran/hyperSpec
* Date/Publication: 2021-09-13 13:00:02 UTC
* Number of recursive dependencies: 141

Run `cloud_details(, "hyperSpec")` for more info

</details>

## Newly broken

*   checking running R code from vignettes ... ERROR
    ```
    Errors in running code in vignettes:
    when running code in ‘plotting.Rnw’
      ...
      'x' values are not equispaced; output may be wrong
    Warning in (function (x, y, z, subscripts, at = pretty(z), ..., col.regions = regions$col,  :
      'y' values are not equispaced; output may be wrong
    
    > plotvoronoi(uneven)
    Warning in (function (x, y, z, subscripts = TRUE, at = pretty(z), points = TRUE,  :
      The 'use.tripack' argument is deprecated and ignored. See ?panel.voronoi
    ...
    
    ... incomplete output.  Crash?
    
      ‘chondro.pdf.asis’ using ‘UTF-8’... OK
      ‘fileio.pdf.asis’ using ‘UTF-8’... OK
      ‘baseline.Rnw’ using ‘UTF-8’... OK
      ‘flu.Rnw’ using ‘UTF-8’... OK
      ‘hyperspec.Rnw’ using ‘UTF-8’... OK
      ‘laser.Rnw’ using ‘UTF-8’... OK
      ‘plotting.Rnw’ using ‘UTF-8’... failed to complete the test
    ```

## In both

*   checking re-building of vignette outputs ... NOTE
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘chondro.pdf.asis’ using asis
    --- finished re-building ‘chondro.pdf.asis’
    
    --- re-building ‘fileio.pdf.asis’ using asis
    --- finished re-building ‘fileio.pdf.asis’
    
    --- re-building ‘baseline.Rnw’ using Sweave
    Loading required package: lattice
    Loading required package: grid
    ...
    Warning in (function (x, y, z, subscripts, at = pretty(z), ..., col.regions = regions$col,  :
      'y' values are not equispaced; output may be wrong
    Warning in (function (x, y, z, subscripts = TRUE, at = pretty(z), points = TRUE,  :
      The 'use.tripack' argument is deprecated and ignored. See ?panel.voronoi
    Killed
    SUMMARY: processing the following files failed:
      ‘baseline.Rnw’ ‘flu.Rnw’ ‘hyperspec.Rnw’ ‘laser.Rnw’ ‘plotting.Rnw’
    
    Error: Vignette re-building failed.
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
      [ FAIL 2 | WARN 4 | SKIP 5 | PASS 333 ]
      
      ══ Skipped tests ═══════════════════════════════════════════════════════════════
      • On CRAN (4)
      • packageVersion("survey") < package_version("4.2") is TRUE (1)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test_filter_levels.R:25:5): Filtering survey design works ──────────
      `svy_filtered <- filterLevels(svy, "stype", "E")` produced warnings.
      ── Failure (test_filter_numeric.R:42:5): Filtering surveys is valid ────────────
      `svy_filtered <- filterNumeric(svy, "api00", "<", 700)` produced warnings.
      
      [ FAIL 2 | WARN 4 | SKIP 5 | PASS 333 ]
      Error: Test failures
      Execution halted
    ```

# IPDFileCheck

<details>

* Version: 0.7.5
* GitHub: NA
* Source code: https://github.com/cran/IPDFileCheck
* Date/Publication: 2022-02-01 08:00:10 UTC
* Number of recursive dependencies: 144

Run `cloud_details(, "IPDFileCheck")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘IPDFileCheck-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: get_summary_gtsummary
    > ### Title: Function to return the summary table using gtsummary package
    > ### Aliases: get_summary_gtsummary
    > 
    > ### ** Examples
    > 
    > trial <- gtsummary::trial
    ...
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    Backtrace:
        ▆
     1. └─IPDFileCheck::get_summary_gtsummary(...)
     2.   └─tidyselect::all_of(selectvar)
     3.     └─tidyselect::peek_vars(fn = "all_of")
     4.       └─cli::cli_abort(...)
     5.         └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Error (test-IPDFilecheck.R:944:3): testing getting summary from gtsummary ───
      Error: `all_of()` must be used within a *selecting* function.
      i See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for details.
      Backtrace:
          ▆
       1. └─IPDFileCheck::get_summary_gtsummary(...) at test-IPDFilecheck.R:944:2
       2.   └─tidyselect::all_of(selectvar)
       3.     └─tidyselect::peek_vars(fn = "all_of")
       4.       └─cli::cli_abort(...)
       5.         └─rlang::abort(...)
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 162 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘gmodels’ ‘lmtest’ ‘testthat’ ‘tidyverse’ ‘zoo’
      All declared Imports should be used.
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
    }))
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
    }))
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
        6. ├─dplyr:::mutate.data.frame(., key_seq = str_split(key_seq, ",\\s"), key_seq = map(key_seq, function(x) {
        tibble(variable = x) %>% mutate(key_seq = row_number())
      }))
        7. │ └─dplyr:::mutate_cols(.data, dplyr_quosures(...), caller_env = caller_env())
        8. │   ├─base::withCallingHandlers(...)
        9. │   └─mask$eval_all_mutate(quo)
       10. ├─stringr::str_split(key_seq, ",\\s")
       11. │ └─stringi::stri_split_regex(...)
       12. └─base::.handleSimpleError(...)
       13.   └─dplyr (local) h(simpleError(msg, call))
       14.     └─rlang::abort(...)
      
      [ FAIL 4 | WARN 436 | SKIP 0 | PASS 50 ]
      Error: Test failures
      Execution halted
    ```

# mildsvm

<details>

* Version: 0.4.0
* GitHub: https://github.com/skent259/mildsvm
* Source code: https://github.com/cran/mildsvm
* Date/Publication: 2022-07-14 09:00:04 UTC
* Number of recursive dependencies: 59

Run `cloud_details(, "mildsvm")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘mildsvm-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: summarize_samples
    > ### Title: Summarize data across functions
    > ### Aliases: summarize_samples summarize_samples.default
    > ###   summarize_samples.mild_df
    > 
    > ### ** Examples
    > 
    ...
     19. │   └─dplyr:::add_computed_columns(...)
     20. │     ├─base::withCallingHandlers(...)
     21. │     └─dplyr:::mutate_cols(...)
     22. │       ├─base::withCallingHandlers(...)
     23. │       └─mask$eval_all_mutate(quo)
     24. └─dplyr::all_of(dplyr::across(group_cols))
     25.   └─tidyselect::peek_vars(fn = "all_of")
     26.     └─cli::cli_abort(...)
     27.       └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       25. │ └─tidyselect::peek_vars(fn = "all_of")
       26. │   └─cli::cli_abort(...)
       27. │     └─rlang::abort(...)
       28. │       └─rlang:::signal_abort(cnd, .file)
       29. │         └─base::signalCondition(cnd)
       30. ├─dplyr (local) `<fn>`(`<rlng_rrr>`)
       31. │ └─rlang::abort(...)
       32. │   └─rlang:::signal_abort(cnd, .file)
       33. │     └─base::signalCondition(cnd)
       34. └─dplyr (local) `<fn>`(`<dply:::_>`)
       35.   └─rlang::abort(...)
      
      [ FAIL 2 | WARN 2 | SKIP 89 | PASS 375 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘gurobi’
    ```

# MLFS

<details>

* Version: 0.4.2
* GitHub: NA
* Source code: https://github.com/cran/MLFS
* Date/Publication: 2022-04-20 08:22:37 UTC
* Number of recursive dependencies: 34

Run `cloud_details(, "MLFS")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘MLFS-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: predict_mortality
    > ### Title: predict_mortality
    > ### Aliases: predict_mortality
    > 
    > ### ** Examples
    > 
    > data("data_v4")
    ...
        ▆
     1. └─MLFS::predict_mortality(...)
     2.   ├─stats::as.formula(...)
     3.   ├─base::paste0(...)
     4.   ├─base::paste(all_of(site_vars), collapse = "+")
     5.   └─tidyselect::all_of(site_vars)
     6.     └─tidyselect::peek_vars(fn = "all_of")
     7.       └─cli::cli_abort(...)
     8.         └─rlang::abort(...)
    Execution halted
    ```

# modeltime

<details>

* Version: 1.2.2
* GitHub: https://github.com/business-science/modeltime
* Source code: https://github.com/cran/modeltime
* Date/Publication: 2022-06-07 21:50:02 UTC
* Number of recursive dependencies: 243

Run `cloud_details(, "modeltime")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘modeltime-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: naive_reg
    > ### Title: General Interface for NAIVE Forecast Models
    > ### Aliases: naive_reg
    > 
    > ### ** Examples
    > 
    > library(dplyr)
    ...
     16. │   ├─dplyr::transmute(new_data_frame(.data), !!!quosures)
     17. │   └─dplyr:::transmute.data.frame(new_data_frame(.data), !!!quosures)
     18. │     └─dplyr:::mutate_cols(.data, dots, caller_env = caller_env())
     19. │       ├─base::withCallingHandlers(...)
     20. │       └─mask$eval_all_mutate(quo)
     21. └─dplyr::all_of(idx_col)
     22.   └─tidyselect::peek_vars(fn = "all_of")
     23.     └─cli::cli_abort(...)
     24.       └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Caused by error:
      ! `all_of()` must be used within a *selecting* function.
      ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
        details.
      ── Error (test-algo-window_reg.R:390:5): SNAIVE - Check New Factors ────────────
      Error in `dplyr::arrange(., dplyr::all_of(idx_col))`: Problem with the implicit `transmute()` step.
      ✖ Problem while computing `..1 = dplyr::all_of(idx_col)`.
      Caused by error:
      ! `all_of()` must be used within a *selecting* function.
      ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
        details.
      
      [ FAIL 9 | WARN 2 | SKIP 22 | PASS 501 ]
      Error: Test failures
      Execution halted
    ```

# multimorbidity

<details>

* Version: 0.5.0
* GitHub: https://github.com/WYATTBENSKEN/multimorbidity
* Source code: https://github.com/cran/multimorbidity
* Date/Publication: 2021-08-20 12:40:05 UTC
* Number of recursive dependencies: 151

Run `cloud_details(, "multimorbidity")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘multimorbidity-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: prepare_data
    > ### Title: Prepare our claims data for analysis
    > ### Aliases: prepare_data
    > 
    > ### ** Examples
    > 
    > prepare_data(dat = i9_i10_comb, id = patient_id, style = "wide",
    ...
    Backtrace:
        ▆
     1. └─multimorbidity::prepare_data(...)
     2.   ├─dat_dx[tidyselect::all_of(var1)]
     3.   ├─tibble:::`[.tbl_df`(dat_dx, tidyselect::all_of(var1))
     4.   └─tidyselect::all_of(var1)
     5.     └─tidyselect::peek_vars(fn = "all_of")
     6.       └─cli::cli_abort(...)
     7.         └─rlang::abort(...)
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘multimorbidity.Rmd’ using rmarkdown
    Quitting from lines 69-79 (multimorbidity.Rmd) 
    Error: processing vignette 'multimorbidity.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘multimorbidity.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘multimorbidity.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘stats’ ‘tidyverse’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 15 marked UTF-8 strings
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
      - "Please use `any_of()` or `all_of()` instead."
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

# NEONiso

<details>

* Version: 0.6.0
* GitHub: https://github.com/lanl/NEONiso
* Source code: https://github.com/cran/NEONiso
* Date/Publication: 2022-08-08 18:30:17 UTC
* Number of recursive dependencies: 119

Run `cloud_details(, "NEONiso")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ══ Skipped tests ═══════════════════════════════════════════════════════════════
      • On CRAN (11)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-data_extraction.R:14:3): extract_carbon_calibration_data fails if incorrect list provided to function ──
      `extract_carbon_calibration_data(co2test$refe_stacked)` produced warnings.
      ── Failure (test-data_ingestion.R:38:3): restructure_carbon_variables errors when invalid mode provided ──
      `restructure_carbon_variables(...)` produced warnings.
      ── Failure (test-data_ingestion.R:39:3): restructure_carbon_variables errors when invalid mode provided ──
      `restructure_carbon_variables(...)` produced warnings.
      
      [ FAIL 3 | WARN 54 | SKIP 11 | PASS 55 ]
      Error: Test failures
      Execution halted
    ```

# NHSRplotthedots

<details>

* Version: 0.1.0
* GitHub: NA
* Source code: https://github.com/cran/NHSRplotthedots
* Date/Publication: 2021-11-03 20:20:10 UTC
* Number of recursive dependencies: 90

Run `cloud_details(, "NHSRplotthedots")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘NHSRplotthedots-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: ptd_spc
    > ### Title: SPC Plotting Function
    > ### Aliases: ptd_spc
    > 
    > ### ** Examples
    > 
    > library(NHSRdatasets)
    ...
     11.     ├─dplyr::count(...)
     12.     ├─dplyr::group_by_at(.data, all_of(c(options[["date_field"]], options[["facet_field"]])))
     13.     │ └─dplyr:::manip_at(...)
     14.     │   └─dplyr:::tbl_at_syms(...)
     15.     │     └─dplyr:::tbl_at_vars(...)
     16.     └─tidyselect::all_of(c(options[["date_field"]], options[["facet_field"]]))
     17.       └─tidyselect::peek_vars(fn = "all_of")
     18.         └─cli::cli_abort(...)
     19.           └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        8.   │   └─base::eval(assertion, env)
        9.   │     └─base::eval(assertion, env)
       10.   ├─dplyr::count(...)
       11.   ├─dplyr::group_by_at(.data, all_of(c(options[["date_field"]], options[["facet_field"]])))
       12.   │ └─dplyr:::manip_at(...)
       13.   │   └─dplyr:::tbl_at_syms(...)
       14.   │     └─dplyr:::tbl_at_vars(...)
       15.   └─tidyselect::all_of(c(options[["date_field"]], options[["facet_field"]]))
       16.     └─tidyselect::peek_vars(fn = "all_of")
       17.       └─cli::cli_abort(...)
       18.         └─rlang::abort(...)
      
      [ FAIL 28 | WARN 111 | SKIP 2 | PASS 292 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘deviations.Rmd’ using rmarkdown
    Quitting from lines 60-74 (deviations.Rmd) 
    Error: processing vignette 'deviations.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘deviations.Rmd’
    
    --- re-building ‘intro.Rmd’ using rmarkdown
    ...
    --- failed re-building ‘intro.Rmd’
    
    --- re-building ‘number-of-points-required.Rmd’ using rmarkdown
    --- finished re-building ‘number-of-points-required.Rmd’
    
    SUMMARY: processing the following files failed:
      ‘deviations.Rmd’ ‘intro.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘NHSRdatasets’ ‘grid’ ‘utils’
      All declared Imports should be used.
    ```

# PDtoolkit

<details>

* Version: 0.4.0
* GitHub: https://github.com/andrija-djurovic/PDtoolkit
* Source code: https://github.com/cran/PDtoolkit
* Date/Publication: 2022-06-06 18:10:05 UTC
* Number of recursive dependencies: 68

Run `cloud_details(, "PDtoolkit")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘PDtoolkit-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: univariate
    > ### Title: Univariate analysis
    > ### Aliases: univariate
    > 
    > ### ** Examples
    > 
    > suppressMessages(library(PDtoolkit))
    ...
      5. │   └─... %>% ...
      6. ├─dplyr::mutate(...)
      7. ├─dplyr::ungroup(.)
      8. ├─dplyr::summarise_at(...)
      9. │ └─dplyr:::check_dot_cols(.vars, .cols)
     10. └─tidyselect::all_of(x)
     11.   └─tidyselect::peek_vars(fn = "all_of")
     12.     └─cli::cli_abort(...)
     13.       └─rlang::abort(...)
    Execution halted
    ```

# pmetar

<details>

* Version: 0.4.0
* GitHub: https://github.com/prcwiek/pmetar
* Source code: https://github.com/cran/pmetar
* Date/Publication: 2022-09-04 14:30:02 UTC
* Number of recursive dependencies: 63

Run `cloud_details(, "pmetar")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘pmetar-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: metar_get
    > ### Title: Get a current METAR report for an airport.
    > ### Aliases: metar_get
    > 
    > ### ** Examples
    > 
    > metar_get("EPWA")
    ...
    Don't use for flight planning or navigation!
    [1] "EPWA 152100Z 26009KT CAVOK 14/11 Q1001 NOSIG"
    > metar_get("CYUL")
    Getting airport informaiton from the file downloaded from
    http://ourairports.com/data/airports.csv
    Getting information from Aviation Weather Center www.aviationweather.gov/metar
    Error in UseMethod("status_code") : 
      no applicable method for 'status_code' applied to an object of class "character"
    Calls: metar_get -> <Anonymous>
    Execution halted
    ```

# prettyglm

<details>

* Version: 0.1.0
* GitHub: NA
* Source code: https://github.com/cran/prettyglm
* Date/Publication: 2021-06-24 07:40:05 UTC
* Number of recursive dependencies: 116

Run `cloud_details(, "prettyglm")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘prettyglm-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: pretty_relativities
    > ### Title: pretty_relativities
    > ### Aliases: pretty_relativities
    > 
    > ### ** Examples
    > 
    > library(dplyr)
    ...
      5. ├─dplyr::summarise(., number_of_records = dplyr::n())
      6. ├─dplyr::group_by_at(., tidyselect::all_of(factor_name))
      7. │ └─dplyr:::manip_at(...)
      8. │   └─dplyr:::tbl_at_syms(...)
      9. │     └─dplyr:::tbl_at_vars(...)
     10. └─tidyselect::all_of(factor_name)
     11.   └─tidyselect::peek_vars(fn = "all_of")
     12.     └─cli::cli_abort(...)
     13.       └─rlang::abort(...)
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘prettyglm-vignette.Rmd’ using rmarkdown
    Quitting from lines 88-90 (prettyglm-vignette.Rmd) 
    Error: processing vignette 'prettyglm-vignette.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘prettyglm-vignette.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘prettyglm-vignette.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘parsnip’
    ```

# ProAE

<details>

* Version: 0.2.10
* GitHub: NA
* Source code: https://github.com/cran/ProAE
* Date/Publication: 2022-06-30 19:40:02 UTC
* Number of recursive dependencies: 130

Run `cloud_details(, "ProAE")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘ProAE-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: toxSummary
    > ### Title: Create patient-level and group-level summary statistics.
    > ### Aliases: toxSummary
    > 
    > ### ** Examples
    > 
    > toxSummary(dsn=ProAE::tox_acute,
    ...
      3. ├─dplyr::left_join(., dsn_summary, by = dplyr::all_of(id_var))
      4. ├─dplyr:::left_join.data.frame(., dsn_summary, by = dplyr::all_of(id_var))
      5. │ └─dplyr:::join_mutate(...)
      6. │   └─dplyr:::join_cols(...)
      7. │     └─dplyr:::standardise_join_by(...)
      8. └─dplyr::all_of(id_var)
      9.   └─tidyselect::peek_vars(fn = "all_of")
     10.     └─cli::cli_abort(...)
     11.       └─rlang::abort(...)
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

# ReDaMoR

<details>

* Version: 0.6.5
* GitHub: https://github.com/patzaw/ReDaMoR
* Source code: https://github.com/cran/ReDaMoR
* Date/Publication: 2022-09-05 07:40:02 UTC
* Number of recursive dependencies: 87

Run `cloud_details(, "ReDaMoR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘ReDaMoR-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: confront_data
    > ### Title: Confront a RelDataModel to actual data
    > ### Aliases: confront_data
    > 
    > ### ** Examples
    > 
    > ## Read the model ----
    ...
      2.   ├─dplyr::anti_join(...)
      3.   ├─dplyr:::anti_join.data.frame(...)
      4.   │ └─dplyr:::join_filter(x, y, by = by, type = "anti", na_matches = na_matches)
      5.   │   └─dplyr:::join_cols(tbl_vars(x), tbl_vars(y), by = by, error_call = error_call)
      6.   │     └─dplyr:::standardise_join_by(...)
      7.   └─dplyr::all_of(magrittr::set_names(tfki$key$to, tfki$key$from))
      8.     └─tidyselect::peek_vars(fn = "all_of")
      9.       └─cli::cli_abort(...)
     10.         └─rlang::abort(...)
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘ReDaMoR.Rmd’ using rmarkdown
    Quitting from lines 321-329 (ReDaMoR.Rmd) 
    Error: processing vignette 'ReDaMoR.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘ReDaMoR.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘ReDaMoR.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# regions

<details>

* Version: 0.1.8
* GitHub: https://github.com/rOpenGov/regions
* Source code: https://github.com/cran/regions
* Date/Publication: 2021-06-21 11:20:01 UTC
* Number of recursive dependencies: 143

Run `cloud_details(, "regions")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        4. │ └─rlang::list2(...)
        5. ├─dplyr::filter(., !.data$geo %in% potentially_imputed_from_nuts_1$geo)
        6. ├─dplyr::rename(., geo = .data$nuts_level_2)
        7. ├─dplyr::distinct_at(., all_of(c("nuts_level_2", "values", "method")))
        8. │ └─dplyr:::manip_at(...)
        9. │   └─dplyr:::tbl_at_syms(...)
       10. │     └─dplyr:::tbl_at_vars(...)
       11. └─tidyselect::all_of(c("nuts_level_2", "values", "method"))
       12.   └─tidyselect::peek_vars(fn = "all_of")
       13.     └─cli::cli_abort(...)
       14.       └─rlang::abort(...)
      
      [ FAIL 2 | WARN 1 | SKIP 0 | PASS 40 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘Regional_stats.Rmd’ using rmarkdown
    ℹ Loading regions
    
    Attaching package: 'dplyr'
    
    The following object is masked from 'package:testthat':
    
        matches
    
    ...
    
        intersect, setdiff, setequal, union
    
    --- finished re-building ‘validation.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘Regional_stats.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 2 marked Latin-1 strings
      Note: found 50022 marked UTF-8 strings
    ```

# romic

<details>

* Version: 1.0.0
* GitHub: NA
* Source code: https://github.com/cran/romic
* Date/Publication: 2021-07-20 09:00:02 UTC
* Number of recursive dependencies: 111

Run `cloud_details(, "romic")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘romic-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: add_pca_loadings
    > ### Title: Add PCA Loadings
    > ### Aliases: add_pca_loadings
    > 
    > ### ** Examples
    > 
    > add_pca_loadings(brauer_2008_triple, npcs = 5)
    ...
      3. ├─romic::remove_missing_values(., value_var = value_var, missing_val_method = missing_val_method)
      4. │ └─triple_omic$measurements %>% ...
      5. ├─dplyr::filter_at(...)
      6. │ └─dplyr:::tbl_at_syms(.tbl, .vars, .include_group_vars = TRUE)
      7. │   └─dplyr:::tbl_at_vars(...)
      8. └─dplyr::all_of(value_var)
      9.   └─tidyselect::peek_vars(fn = "all_of")
     10.     └─cli::cli_abort(...)
     11.       └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        3. │   └─rlang::eval_bare(expr, quo_get_env(quo))
        4. ├─base::nrow(remove_missing_values(brauer_2008_triple, missing_val_method = "drop_features")$features)
        5. ├─romic::remove_missing_values(brauer_2008_triple, missing_val_method = "drop_features")
        6. │ └─triple_omic$measurements %>% ...
        7. ├─dplyr::filter_at(...)
        8. │ └─dplyr:::tbl_at_syms(.tbl, .vars, .include_group_vars = TRUE)
        9. │   └─dplyr:::tbl_at_vars(...)
       10. └─dplyr::all_of(value_var)
       11.   └─tidyselect::peek_vars(fn = "all_of")
       12.     └─cli::cli_abort(...)
       13.       └─rlang::abort(...)
      
      [ FAIL 1 | WARN 0 | SKIP 1 | PASS 12 ]
      Error: Test failures
      Execution halted
    ```

# sbo

<details>

* Version: 0.5.0
* GitHub: https://github.com/vgherard/sbo
* Source code: https://github.com/cran/sbo
* Date/Publication: 2020-12-05 19:50:02 UTC
* Number of recursive dependencies: 79

Run `cloud_details(, "sbo")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        8. ├─dplyr::select(., prefixes, .data$prediction, .data$score)
        9. ├─dplyr::ungroup(.)
       10. ├─dplyr::mutate(., score = n/sum(n))
       11. ├─dplyr::group_by_at(., all_of(prefixes))
       12. │ └─dplyr:::manip_at(...)
       13. │   └─dplyr:::tbl_at_syms(...)
       14. │     └─dplyr:::tbl_at_vars(...)
       15. └─tidyselect::all_of(prefixes)
       16.   └─tidyselect::peek_vars(fn = "all_of")
       17.     └─cli::cli_abort(...)
       18.       └─rlang::abort(...)
      
      [ FAIL 10 | WARN 96 | SKIP 1 | PASS 237 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘sbo.Rmd’ using rmarkdown
    Quitting from lines 60-69 (sbo.Rmd) 
    Error: processing vignette 'sbo.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘sbo.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘sbo.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 16.0Mb
      sub-directories of 1Mb or more:
        data   3.9Mb
        libs  11.8Mb
    ```

# scrutiny

<details>

* Version: 0.2.2
* GitHub: https://github.com/lhdjung/scrutiny
* Source code: https://github.com/cran/scrutiny
* Date/Publication: 2022-08-22 09:40:02 UTC
* Number of recursive dependencies: 121

Run `cloud_details(, "scrutiny")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘scrutiny-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: debit_map_total_n
    > ### Title: Use DEBIT with hypothetical group sizes
    > ### Aliases: debit_map_total_n
    > 
    > ### ** Examples
    > 
    > # Run `debit_map_total_n()` on data like these:
    ...
      3. │   └─... %>% ...
      4. ├─dplyr::mutate(...)
      5. ├─dplyr::rename_with(., .fn = ~dplyr::all_of(reported_orig), .cols = 1:dplyr::all_of(reported_n_vars))
      6. └─dplyr:::rename_with.data.frame(...)
      7.   └─scrutiny (local) .fn(names[cols], ...)
      8.     └─dplyr::all_of(reported_orig)
      9.       └─tidyselect::peek_vars(fn = "all_of")
     10.         └─cli::cli_abort(...)
     11.           └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        1. ├─scrutiny::grim_map_total_n(df1) at test-reverse-map-total-n.R:15:0
        2. │ └─scrutiny (local) map_total_n_proto(...)
        3. │   └─... %>% ...
        4. ├─dplyr::mutate(...)
        5. ├─dplyr::rename_with(., .fn = ~dplyr::all_of(reported_orig), .cols = 1:dplyr::all_of(reported_n_vars))
        6. └─dplyr:::rename_with.data.frame(...)
        7.   └─scrutiny (local) .fn(names[cols], ...)
        8.     └─dplyr::all_of(reported_orig)
        9.       └─tidyselect::peek_vars(fn = "all_of")
       10.         └─cli::cli_abort(...)
       11.           └─rlang::abort(...)
      
      [ FAIL 3 | WARN 9 | SKIP 0 | PASS 409 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘consistency-tests.Rmd’ using rmarkdown
    Quitting from lines 506-525 (consistency-tests.Rmd) 
    Error: processing vignette 'consistency-tests.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘consistency-tests.Rmd’
    
    --- re-building ‘debit.Rmd’ using rmarkdown
    ...
    --- finished re-building ‘rounding.Rmd’
    
    --- re-building ‘wrangling.Rmd’ using rmarkdown
    --- finished re-building ‘wrangling.Rmd’
    
    SUMMARY: processing the following files failed:
      ‘consistency-tests.Rmd’ ‘debit.Rmd’ ‘grim.Rmd’ ‘grimmer.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# SimplyAgree

<details>

* Version: 0.1.0
* GitHub: NA
* Source code: https://github.com/cran/SimplyAgree
* Date/Publication: 2022-08-24 07:10:16 UTC
* Number of recursive dependencies: 135

Run `cloud_details(, "SimplyAgree")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘SimplyAgree-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: agree_test
    > ### Title: Tests for Absolute Agreement
    > ### Aliases: agree_test
    > 
    > ### ** Examples
    > 
    > data('reps')
    ...
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    Backtrace:
        ▆
     1. └─SimplyAgree::agree_test(x = reps$x, y = reps$y, delta = 2)
     2.   └─tidyselect::all_of(agree.level)
     3.     └─tidyselect::peek_vars(fn = "all_of")
     4.       └─cli::cli_abort(...)
     5.         └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ── Error (test_agree_test.R:6:3): Simple Use Run Through ───────────────────────
      Error: `all_of()` must be used within a *selecting* function.
      ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
        details.
      Backtrace:
          ▆
       1. └─SimplyAgree::agree_test(...) at test_agree_test.R:6:2
       2.   └─tidyselect::all_of(agree.level)
       3.     └─tidyselect::peek_vars(fn = "all_of")
       4.       └─cli::cli_abort(...)
       5.         └─rlang::abort(...)
      
      [ FAIL 5 | WARN 0 | SKIP 0 | PASS 52 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘Deming.Rmd’ using rmarkdown
    --- finished re-building ‘Deming.Rmd’
    
    --- re-building ‘agreement_analysis.Rmd’ using rmarkdown
    Quitting from lines 44-47 (agreement_analysis.Rmd) 
    Error: processing vignette 'agreement_analysis.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    ...
    --- finished re-building ‘reanalysis.Rmd’
    
    --- re-building ‘reliability_analysis.Rmd’ using rmarkdown
    --- finished re-building ‘reliability_analysis.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘agreement_analysis.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# sitar

<details>

* Version: 1.3.0
* GitHub: https://github.com/statist7/sitar
* Source code: https://github.com/cran/sitar
* Date/Publication: 2022-07-20 15:40:02 UTC
* Number of recursive dependencies: 66

Run `cloud_details(, "sitar")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘sitar-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: ob_convertr
    > ### Title: Convert between IOTF, WHO and CDC prevalence rates for child
    > ###   thinness, overweight and obesity
    > ### Aliases: ob_convertr ob_convertr2
    > 
    > ### ** Examples
    > 
    ...
      7. │ └─rlang::list2(...)
      8. ├─... %>% rename_with(~ all_of(epto))
      9. ├─dplyr::rename_with(., ~all_of(epto))
     10. └─dplyr:::rename_with.data.frame(., ~all_of(epto))
     11.   └─sitar (local) .fn(names[cols], ...)
     12.     └─tidyselect::all_of(epto)
     13.       └─tidyselect::peek_vars(fn = "all_of")
     14.         └─cli::cli_abort(...)
     15.           └─rlang::abort(...)
    Execution halted
    ```

# skimr

<details>

* Version: 2.1.4
* GitHub: https://github.com/ropensci/skimr
* Source code: https://github.com/cran/skimr
* Date/Publication: 2022-04-15 02:20:02 UTC
* Number of recursive dependencies: 81

Run `cloud_details(, "skimr")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > test_check("skimr")
      [ FAIL 1 | WARN 0 | SKIP 25 | PASS 630 ]
      
      ══ Skipped tests ═══════════════════════════════════════════════════════════════
      • On CRAN (25)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-data.table.R:6:3): skim of a simple data.table produces no warnings ──
      `skim(DT_letters)` generated warnings:
      * Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0.
      Please use `any_of()` or `all_of()` instead.
      
      [ FAIL 1 | WARN 0 | SKIP 25 | PASS 630 ]
      Error: Test failures
      Execution halted
    ```

# socialrisk

<details>

* Version: 0.5.0
* GitHub: https://github.com/WYATTBENSKEN/multimorbidity
* Source code: https://github.com/cran/socialrisk
* Date/Publication: 2022-03-11 10:00:02 UTC
* Number of recursive dependencies: 145

Run `cloud_details(, "socialrisk")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘socialrisk-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: clean_data
    > ### Title: Prepare our administrative data for analysis
    > ### Aliases: clean_data
    > 
    > ### ** Examples
    > 
    > clean_data(dat = i10_wide, id = patient_id, style = "wide", prefix_dx = "dx")
    ...
    Backtrace:
        ▆
     1. └─socialrisk::clean_data(...)
     2.   ├─dat_dx[tidyselect::all_of(var1)]
     3.   ├─tibble:::`[.tbl_df`(dat_dx, tidyselect::all_of(var1))
     4.   └─tidyselect::all_of(var1)
     5.     └─tidyselect::peek_vars(fn = "all_of")
     6.       └─cli::cli_abort(...)
     7.         └─rlang::abort(...)
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘socialrisk.Rmd’ using rmarkdown
    Quitting from lines 43-47 (socialrisk.Rmd) 
    Error: processing vignette 'socialrisk.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘socialrisk.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘socialrisk.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘stats’ ‘tidyverse’
      All declared Imports should be used.
    ```

# spectralR

<details>

* Version: 0.1.2
* GitHub: https://github.com/olehprylutskyi/spectralR
* Source code: https://github.com/cran/spectralR
* Date/Publication: 2022-06-28 16:30:02 UTC
* Number of recursive dependencies: 109

Run `cloud_details(, "spectralR")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘tinytest.R’
    Running the tests in ‘tests/tinytest.R’ failed.
    Last 13 lines of output:
      test_testdata.R...............   27 tests [0;32mOK[0m [0;34m0.2s[0m
      
      test_violin.plot.R............    1 tests [0;32mOK[0m Joining, by = "variable"
      
      test_violin.plot.R............    2 tests [0;32mOK[0m 
      test_violin.plot.R............    3 tests [0;32mOK[0m 
      test_violin.plot.R............    4 tests [0;32mOK[0m 
      test_violin.plot.R............    5 tests [0;32mOK[0m [0;36m76ms[0m
      ----- FAILED[xcpt]: test_get.pixel.data.R<8--12>
       call| expect_silent(sf_df <- prepare.vector.data(shapefile_name = system.file("extdata/test_shapefile.shp", 
       call| -->    package = "spectralR"), label_field = "veget_type"))
       diff| Execution was not silent. A warning was thrown with message
       diff| 'Problem while computing `..1 = across(.data$label, as.factor)`.'
      Error: 1 out of 73 tests failed
      Execution halted
    ```

## In both

*   checking for executable files ... WARNING
    ```
    Found the following executable files:
      inst/extdata/SouthernBuh-habitats_shapefile.dbf
      inst/extdata/test_shapefile.dbf
    Source packages should not contain undeclared executable files.
    See section ‘Package structure’ in the ‘Writing R Extensions’ manual.
    ```

# sspm

<details>

* Version: 0.9.1
* GitHub: https://github.com/pedersen-fisheries-lab/sspm
* Source code: https://github.com/cran/sspm
* Date/Publication: 2022-05-12 08:10:02 UTC
* Number of recursive dependencies: 100

Run `cloud_details(, "sspm")` for more info

</details>

## Newly broken

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘An_example_with_simulated_data.Rmd’ using rmarkdown
    Quitting from lines 173-177 (An_example_with_simulated_data.Rmd) 
    Error: processing vignette 'An_example_with_simulated_data.Rmd' failed with diagnostics:
    `all_of()` must be used within a *selecting* function.
    ℹ See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for
      details.
    --- failed re-building ‘An_example_with_simulated_data.Rmd’
    
    --- re-building ‘Package_and_workflow_design.Rmd’ using rmarkdown
    --- finished re-building ‘Package_and_workflow_design.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘An_example_with_simulated_data.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# statnipokladna

<details>

* Version: 0.7.0
* GitHub: https://github.com/petrbouchal/statnipokladna
* Source code: https://github.com/cran/statnipokladna
* Date/Publication: 2021-05-26 00:10:03 UTC
* Number of recursive dependencies: 84

Run `cloud_details(, "statnipokladna")` for more info

</details>

## Newly broken

*   checking whether package ‘statnipokladna’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0.
    See ‘/tmp/workdir/statnipokladna/new/statnipokladna.Rcheck/00install.out’ for details.
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tidyselect’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 52 marked UTF-8 strings
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
      
      [ FAIL 2 | WARN 18 | SKIP 88 | PASS 344 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4 marked UTF-8 strings
    ```

# tidycmprsk

<details>

* Version: 0.1.2
* GitHub: https://github.com/MSKCC-Epi-Bio/tidycmprsk
* Source code: https://github.com/cran/tidycmprsk
* Date/Publication: 2022-03-04 16:50:02 UTC
* Number of recursive dependencies: 98

Run `cloud_details(, "tidycmprsk")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘tidycmprsk-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: add_cuminc
    > ### Title: Additional Functions for 'tbl_cuminc()'
    > ### Aliases: add_cuminc add_p.tbl_cuminc add_n.tbl_cuminc
    > ###   add_nevent.tbl_cuminc inline_text.tbl_cuminc
    > 
    > ### ** Examples
    > 
    ...
     11. │       │   │ └─base (local) tryCatchList(expr, classes, parentenv, handlers)
     12. │       │   │   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
     13. │       │   │     └─base (local) doTryCatch(return(expr), name, parentenv, handler)
     14. │       │   └─base::withCallingHandlers(...)
     15. │       └─rlang::eval_tidy(expr, set_names(seq_along(vars), vars))
     16. └─tidyselect::all_of(column)
     17.   └─tidyselect::peek_vars(fn = "all_of")
     18.     └─cli::cli_abort(...)
     19.       └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      11 cases omitted due to missing values
      11 cases omitted due to missing values
      11 cases omitted due to missing values
      [ FAIL 1 | WARN 1254 | SKIP 0 | PASS 92 ]
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Error (test-tbl_cuminc.R:10:3): tbl_cuminc() works ──────────────────────────
      Error in `dplyr::pull(df_gtsummary, all_of(column))`: Problem while evaluating `all_of(column)`.
      Caused by error:
      ! `all_of()` must be used within a *selecting* function.
      i See <https://tidyselect.r-lib.org/reference/faq-selection-context.html> for details.
      
      [ FAIL 1 | WARN 1254 | SKIP 0 | PASS 92 ]
      Error: Test failures
      Execution halted
    ```

# TKCat

<details>

* Version: 1.0.3
* GitHub: https://github.com/patzaw/TKCat
* Source code: https://github.com/cran/TKCat
* Date/Publication: 2022-06-07 14:00:14 UTC
* Number of recursive dependencies: 116

Run `cloud_details(, "TKCat")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘TKCat-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: memoMDB
    > ### Title: An MDB (Modeled DataBase) in memory: memoMDB
    > ### Aliases: memoMDB names<-.memoMDB rename.memoMDB [.memoMDB [[.memoMDB
    > ###   $.memoMDB
    > 
    > ### ** Examples
    > 
    ...
      5.       ├─dplyr::anti_join(...)
      6.       ├─dplyr:::anti_join.data.frame(...)
      7.       │ └─dplyr:::join_filter(x, y, by = by, type = "anti", na_matches = na_matches)
      8.       │   └─dplyr:::join_cols(tbl_vars(x), tbl_vars(y), by = by, error_call = error_call)
      9.       │     └─dplyr:::standardise_join_by(...)
     10.       └─dplyr::all_of(magrittr::set_names(tfki$key$to, tfki$key$from))
     11.         └─tidyselect::peek_vars(fn = "all_of")
     12.           └─cli::cli_abort(...)
     13.             └─rlang::abort(...)
    Execution halted
    ```

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘TKCat-User-guide.Rmd’ using rmarkdown
    Loading required package: ReDaMoR
    Loading required package: dplyr
    
    Attaching package: 'dplyr'
    
    The following objects are masked from 'package:stats':
    
        filter, lag
    ...
    Error: processing vignette 'TKCat-User-guide.Rmd' failed with diagnostics:
    This function need 'igraph' package to compute layout. Please 
             install it before.
    --- failed re-building ‘TKCat-User-guide.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘TKCat-User-guide.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# wpa

<details>

* Version: 1.8.0
* GitHub: https://github.com/microsoft/wpa
* Source code: https://github.com/cran/wpa
* Date/Publication: 2022-07-05 15:40:02 UTC
* Number of recursive dependencies: 121

Run `cloud_details(, "wpa")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘wpa-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: create_IV
    > ### Title: Calculate Information Value for a selected outcome variable
    > ### Aliases: create_IV
    > 
    > ### ** Examples
    > 
    > # Return a summary table of IV
    ...
      details.
    Backtrace:
        ▆
     1. ├─... %>% ...
     2. └─wpa::create_IV(...)
     3.   └─tidyselect::all_of(predictors)
     4.     └─tidyselect::peek_vars(fn = "all_of")
     5.       └─cli::cli_abort(...)
     6.         └─rlang::abort(...)
    Execution halted
    ```

# wrappedtools

<details>

* Version: 0.8.0
* GitHub: NA
* Source code: https://github.com/cran/wrappedtools
* Date/Publication: 2022-09-01 09:20:02 UTC
* Number of recursive dependencies: 126

Run `cloud_details(, "wrappedtools")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘wrappedtools-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: compare_n_numvars
    > ### Title: Comparison for columns of Gaussian or ordinal measures for n
    > ###   groups
    > ### Aliases: compare_n_numvars
    > 
    > ### ** Examples
    > 
    ...
     1. ├─wrappedtools::compare_n_numvars(...)
     2. │ └─... %>% purrr::map(~ set_names(.x, all_of(dep_vars)))
     3. └─purrr::map(., ~set_names(.x, all_of(dep_vars)))
     4.   └─wrappedtools (local) .f(.x[[i]], ...)
     5.     ├─rlang::set_names(.x, all_of(dep_vars))
     6.     └─tidyselect::all_of(dep_vars)
     7.       └─tidyselect::peek_vars(fn = "all_of")
     8.         └─cli::cli_abort(...)
     9.           └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        2. │ └─testthat::quasi_label(enquo(object), label, arg = "object")
        3. │   └─rlang::eval_bare(expr, quo_get_env(quo))
        4. ├─wrappedtools::compare_n_numvars(...)
        5. │ └─... %>% purrr::map(~ set_names(.x, all_of(dep_vars)))
        6. └─purrr::map(., ~set_names(.x, all_of(dep_vars)))
        7.   └─wrappedtools (local) .f(.x[[i]], ...)
        8.     ├─rlang::set_names(.x, all_of(dep_vars))
        9.     └─tidyselect::all_of(dep_vars)
       10.       └─tidyselect::peek_vars(fn = "all_of")
       11.         └─cli::cli_abort(...)
       12.           └─rlang::abort(...)
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 60 ]
      Error: Test failures
      Execution halted
    ```

