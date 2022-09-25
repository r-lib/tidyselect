# academictwitteR

<details>

* Version: 0.3.1
* GitHub: https://github.com/cjbarrie/academictwitteR
* Source code: https://github.com/cran/academictwitteR
* Date/Publication: 2022-02-16 15:20:09 UTC
* Number of recursive dependencies: 104

Run `cloud_details(, "academictwitteR")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      • !dir.exists("../testdata/reuters") is TRUE (1)
      • !dir.exists("api.twitter.com") is TRUE (69)
      • !file.exists("../testdata/hkx.RDS") is TRUE (1)
      • !file.exists("../testdata/rate_limit_res.RDS") is TRUE (3)
      • On CRAN (2)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-deprecate.R:2:3): bind_tweet_jsons ────────────────────────────
      `bind_tweet_jsons("../testdata/commtwitter")` did not throw the expected warning.
      ── Failure (test-deprecate.R:6:3): bind_user_jsons ─────────────────────────────
      `bind_user_jsons("../testdata/commtwitter")` did not throw the expected warning.
      
      [ FAIL 2 | WARN 0 | SKIP 77 | PASS 60 ]
      Error: Test failures
      Execution halted
    ```

# admiral

<details>

* Version: 0.8.1
* GitHub: https://github.com/pharmaverse/admiral
* Source code: https://github.com/cran/admiral
* Date/Publication: 2022-09-20 22:30:08 UTC
* Number of recursive dependencies: 126

Run `cloud_details(, "admiral")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > test_check("admiral")
      [1] "N" "Y" NA 
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 497 ]
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-deprecation.R:207:3): derive_var_agegr_fda Test 1: A warning is issued if `derive_var_agegr_fda()` is called ──
      `derive_var_agegr_fda(admiral_dm, age_var = AGE, new_var = AGEGR1)` did not produce any warnings.
      Backtrace:
          ▆
       1. ├─rlang::with_options(...) at test-deprecation.R:207:2
       2. └─testthat::expect_warning(...) at test-deprecation.R:208:4
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 497 ]
      Error: Test failures
      Execution halted
    ```

# bupaR

<details>

* Version: 0.5.0
* GitHub: https://github.com/bupaverse/bupaR
* Source code: https://github.com/cran/bupaR
* Date/Publication: 2022-07-05 15:30:02 UTC
* Number of recursive dependencies: 82

Run `cloud_details(, "bupaR")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ Skipped tests ═══════════════════════════════════════════════════════════════
      • TODO: rewrite ordered fails (1)
      • TODO: rewrite slice tests (2)
      • codes fails on ordered (1)
      • empty test (1)
      • grouped_activitylog not fully functional yet (2)
      • problem with grouped eventlogs (1)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test_utils.R:10:3): test lifecycle_warning_eventlog ────────────────
      `result1 <- case_labels(eventlog = patients)` did not produce any warnings.
      
      [ FAIL 1 | WARN 0 | SKIP 8 | PASS 275 ]
      Error: Test failures
      Execution halted
    ```

# d3r

<details>

* Version: 1.0.0
* GitHub: https://github.com/timelyportfolio/d3r
* Source code: https://github.com/cran/d3r
* Date/Publication: 2021-08-15 18:00:06 UTC
* Number of recursive dependencies: 64

Run `cloud_details(, "d3r")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      • On CRAN (3)
      • V8 cannot be loaded (1)
      • github cannot be loaded (1)
      • igraph cannot be loaded (1)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test_deps.R:39:3): d3_dep-* src href is a valid url ────────────────
      is_valid_url(file.path(jetpack_offline$src$href, jetpack$script)) is not TRUE
      
      `actual`:   FALSE
      `expected`: TRUE 
      
      [ FAIL 1 | WARN 0 | SKIP 6 | PASS 18 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking package dependencies ... NOTE
    ```
    Packages which this enhances but not available for checking:
      'igraph', 'partykit', 'treemap', 'V8'
    ```

# dm

<details>

* Version: 1.0.2
* GitHub: https://github.com/cynkra/dm
* Source code: https://github.com/cran/dm
* Date/Publication: 2022-09-20 07:46:26 UTC
* Number of recursive dependencies: 152

Run `cloud_details(, "dm")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       1. ├─dm:::expect_equivalent_dm(...) at test-db-interface.R:25:2
       2. │ ├─dm_get_tables_impl(object) %>% map(collect) at tests/testthat/helper-expectations.R:6:2
       3. │ └─dm:::dm_get_tables_impl(object)
       4. │   └─dm:::dm_get_def(x, quiet)
       5. │     └─dm:::check_dm(x)
       6. │       └─dm::is_dm(dm)
       7. ├─purrr::map(., collect)
       8. └─dm:::expect_deprecated_obj(copy_dm_to(default_local_src(), dm_for_filter()))
       9.   └─lifecycle::expect_deprecated(...)
      ── Failure (test_dm_from_con.R:77:3): dm_from_src() deprecated ─────────────────
      `dm_from_src(src_from_src_or_con(con_db), learn_keys = FALSE)` did not throw the expected warning.
      
      [ FAIL 4 | WARN 0 | SKIP 191 | PASS 1333 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘dm-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: dm_flatten_to_tbl
    > ### Title: Flatten a part of a 'dm' into a wide table
    > ### Aliases: dm_flatten_to_tbl
    > 
    > ### ** Examples
    > 
    > 
    ...
      8. │   └─dm:::check_dm(dm)
      9. │     └─dm::is_dm(dm)
     10. ├─dm::dm_financial()
     11. │ ├─base::withVisible(eval(mc, parent.frame()))
     12. │ └─base::eval(mc, parent.frame())
     13. │   └─base::eval(mc, parent.frame())
     14. └─dm (local) `<fn>`()
     15.   └─dm:::financial_db_con()
     16.     └─rlang::abort(...)
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

# gratia

<details>

* Version: 0.7.3
* GitHub: https://github.com/gavinsimpson/gratia
* Source code: https://github.com/cran/gratia
* Date/Publication: 2022-05-09 11:20:03 UTC
* Number of recursive dependencies: 83

Run `cloud_details(, "gratia")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘test-all.R’
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      • hgam-paper/hgam-paper-bird-move-model-1.svg
      • hgam-paper/hgam-paper-bird-move-model-2.svg
      • hgam-paper/hgam-paper-bird-move-model-3.svg
      • hgam-paper/hgam-paper-bird-move-model-5.svg
      • hgam-paper/hgam-paper-co2-model-1.svg
      • hgam-paper/hgam-paper-co2-model-2.svg
      • hgam-paper/hgam-paper-co2-model-3.svg
      • hgam-paper/hgam-paper-co2-model-4.svg
      • hgam-paper/hgam-paper-co2-model-5.svg
      • hgam-paper/hgam-paper-zoop-model-4.svg
      • hgam-paper/hgam-paper-zoop-model-5.svg
      • rootograms/draw-gaussian-rootogram.svg
      • rootograms/draw-neg-bin-rootogram.svg
      Error: Test failures
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
      
      [ FAIL 4 | WARN 0 | SKIP 0 | PASS 50 ]
      Error: Test failures
      Execution halted
    ```

# opencage

<details>

* Version: 0.2.2
* GitHub: https://github.com/ropensci/opencage
* Source code: https://github.com/cran/opencage
* Date/Publication: 2021-02-20 01:00:02 UTC
* Number of recursive dependencies: 78

Run `cloud_details(, "opencage")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ── Failure (test-deprecated.R:126:3): `opencage_key(quiet = FALSE)` messages ───
      `opencage_key(quiet = FALSE)` did not produce any warnings.
      Backtrace:
          ▆
       1. ├─testthat::expect_message(...) at test-deprecated.R:126:2
       2. │ └─testthat:::quasi_capture(enquo(object), label, capture_messages)
       3. │   ├─testthat (local) .capture(...)
       4. │   │ └─base::withCallingHandlers(...)
       5. │   └─rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
       6. └─lifecycle::expect_deprecated(opencage_key(quiet = FALSE))
       7.   └─testthat::expect_warning(...)
      
      [ FAIL 6 | WARN 0 | SKIP 33 | PASS 223 ]
      Error: Test failures
      Execution halted
    ```

# parsnip

<details>

* Version: 1.0.1
* GitHub: https://github.com/tidymodels/parsnip
* Source code: https://github.com/cran/parsnip
* Date/Publication: 2022-08-18 07:30:02 UTC
* Number of recursive dependencies: 134

Run `cloud_details(, "parsnip")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      [ FAIL 1 | WARN 0 | SKIP 67 | PASS 944 ]
      
      ══ Skipped tests ═══════════════════════════════════════════════════════════════
      • On CRAN (59)
      • flexsurv cannot be loaded (2)
      • tune_check() is TRUE (6)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test_surv_reg.R:21:3): deprecation warning ─────────────────────────
      `surv_reg()` did not throw the expected warning.
      
      [ FAIL 1 | WARN 0 | SKIP 67 | PASS 944 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘rules’, ‘h2o’, ‘agua’, ‘baguette’, ‘ipred’, ‘dbarts’, ‘lightgbm’, ‘bonsai’, ‘mboost’, ‘mda’, ‘sda’, ‘sparsediscrim’, ‘klaR’, ‘workflows’, ‘brulee’, ‘glmnet’, ‘rstan’, ‘rstanarm’, ‘naivebayes’, ‘plsmod’, ‘pscl’, ‘randomForest’, ‘xrf’, ‘flexsurv’, ‘broom’
    ```

# r2dii.plot

<details>

* Version: 0.3.0
* GitHub: https://github.com/2DegreesInvesting/r2dii.plot
* Source code: https://github.com/cran/r2dii.plot
* Date/Publication: 2022-05-05 23:20:10 UTC
* Number of recursive dependencies: 91

Run `cloud_details(, "r2dii.plot")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      `plot_techmix(example_tech_mix())` did not generate error with class 'warning'
      Backtrace:
          ▆
       1. └─testthat::expect_snapshot_error(...) at test-plot_techmix.R:296:2
       2.   └─testthat:::expect_snapshot_condition(...)
      ── Failure (test-plot_trajectory.R:204:3): throws expected warning about API change ──
      `plot_trajectory(example_market_share())` did not generate error with class 'warning'
      Backtrace:
          ▆
       1. └─testthat::expect_snapshot_error(...) at test-plot_trajectory.R:204:2
       2.   └─testthat:::expect_snapshot_condition(...)
      
      [ FAIL 3 | WARN 0 | SKIP 43 | PASS 103 ]
      Error: Test failures
      Execution halted
    ```

# ssdtools

<details>

* Version: 1.0.2
* GitHub: https://github.com/bcgov/ssdtools
* Source code: https://github.com/cran/ssdtools
* Date/Publication: 2022-05-14 23:50:02 UTC
* Number of recursive dependencies: 143

Run `cloud_details(, "ssdtools")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      • ssd-plot/boron_breaks.png
      • ssd-plot/boron_cens_pred.png
      • ssd-plot/boron_cens_pred_ribbon.png
      • ssd-plot/boron_cens_pred_species.png
      • ssd-plot/boron_pred.png
      • ssd-plot/boron_pred_label.png
      • ssd-plot/boron_pred_ribbon.png
      • ssd-plot/boron_pred_shift_x.png
      • ssd-plot/missing_order.png
      • tidy/tidy.csv
      • weibull/hc_anona.csv
      • weibull/tidy.csv
      • weibull/tidy_anona.csv
      Error: Test failures
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 23.9Mb
      sub-directories of 1Mb or more:
        doc    1.2Mb
        help   1.0Mb
        libs  21.3Mb
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

# tibble

<details>

* Version: 3.1.8
* GitHub: https://github.com/tidyverse/tibble
* Source code: https://github.com/cran/tibble
* Date/Publication: 2022-07-22 06:10:02 UTC
* Number of recursive dependencies: 103

Run `cloud_details(, "tibble")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      `code` did not throw the expected warning.
      ── Failure (test-zzz-name-repair.R:189:3): names<-() and set_names() reject non-minimal names ──
      `code` did not throw the expected warning.
      ── Failure (test-zzz-name-repair.R:195:3): names<-() and set_names() reject non-minimal names ──
      `code` did not throw the expected warning.
      ── Failure (test-zzz-name-repair.R:201:3): names<-() and set_names() reject non-minimal names ──
      `code` did not throw the expected warning.
      ── Failure (test-zzz-data-frame.R:618:3): `validate` triggers deprecation message, but then works ──
      `df <- as_tibble(list(a = 1, "hi", a = 2), validate = FALSE)` did not throw the expected warning.
      ── Failure (test-zzz-data-frame.R:627:3): `validate` triggers deprecation message, but then works ──
      `df <- as_tibble(df, validate = FALSE)` did not throw the expected warning.
      
      [ FAIL 21 | WARN 8 | SKIP 144 | PASS 1315 ]
      Error: Test failures
      Execution halted
    ```

# workflowsets

<details>

* Version: 1.0.0
* GitHub: https://github.com/tidymodels/workflowsets
* Source code: https://github.com/cran/workflowsets
* Date/Publication: 2022-07-12 23:20:01 UTC
* Number of recursive dependencies: 123

Run `cloud_details(, "workflowsets")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      • rlang::is_installed("rlang") is TRUE (1)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-pull.R:20:3): pulling objects ─────────────────────────────────
      `expect_equal(car_set_1 %>% pull_workflow("reg_lm"), car_set_1$info[[1]]$workflow[[1]])` did not throw the expected warning.
      ── Failure (test-pull.R:28:3): pulling objects ─────────────────────────────────
      `expect_equal(...)` did not throw the expected warning.
      ── Failure (test-pull.R:36:3): pulling objects ─────────────────────────────────
      `expect_error(...)` did not throw the expected warning.
      ── Failure (test-pull.R:44:3): pulling objects ─────────────────────────────────
      `expect_error(...)` did not throw the expected warning.
      
      [ FAIL 4 | WARN 0 | SKIP 10 | PASS 373 ]
      Error: Test failures
      Execution halted
    ```

# ypr

<details>

* Version: 0.6.0
* GitHub: https://github.com/poissonconsulting/ypr
* Source code: https://github.com/cran/ypr
* Date/Publication: 2022-08-29 22:30:03 UTC
* Number of recursive dependencies: 99

Run `cloud_details(, "ypr")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      • tabulate-sr/srpopulationRk.csv
      • tabulate-yield/almostpopulationextinct.csv
      • tabulate-yield/ecotypes.csv
      • tabulate-yield/ecotypes1.csv
      • tabulate-yield/inst2inter.csv
      • tabulate-yield/population.csv
      • tabulate-yield/populationall.csv
      • tabulate-yield/populationextinct.csv
      • tabulate-yield/populations.csv
      • tabulate-yield/populationsall.csv
      • tabulate-yields/ecotypes.csv
      • tabulate-yields/populations01.csv
      • tabulate-yields/populations01all.csv
      Error: Test failures
      Execution halted
    ```

