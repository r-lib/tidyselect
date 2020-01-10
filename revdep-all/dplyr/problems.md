# AMARETTO

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/AMARETTO
* Date/Publication: 2019-05-02
* Number of recursive dependencies: 141

Run `revdep_details(,"AMARETTO")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Nr of reassignments is: 1 
      ── 1. Error: (unknown) (@test_AMARETTO.R#11)  ──────────────────────────────────
      length of 'dimnames' [2] not equal to array extent
      Backtrace:
       1. AMARETTO::AMARETTO_Run(AMARETTOinit)
       2. AMARETTO:::AMARETTO_LarsenBased(...) revdep-all/dplyr/checks.noindex/AMARETTO/new/AMARETTO.Rcheck/00_pkg_src/AMARETTO/R/amaretto_functions.R:121:12
       3. AMARETTO:::AMARETTO_LearnRegulatoryProgramsLarsen(...) revdep-all/dplyr/checks.noindex/AMARETTO/new/AMARETTO.Rcheck/00_pkg_src/AMARETTO/R/amaretto_run.R:29:12
       4. base::`colnames<-`(`*tmp*`, value = RegulatorData_rownames) revdep-all/dplyr/checks.noindex/AMARETTO/new/AMARETTO.Rcheck/00_pkg_src/AMARETTO/R/amaretto_run.R:212:4
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 0 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 1 ]
      1. Error: (unknown) (@test_AMARETTO.R#11) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘AMARETTO-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: AMARETTO_Download
    > ### Title: AMARETTO_Download
    > ### Aliases: AMARETTO_Download
    > 
    > ### ** Examples
    > 
    > TargetDirectory <- file.path(getwd(),"Downloads/");dir.create(TargetDirectory)
    > CancerSite <- 'CHOL'
    > DataSetDirectories <- AMARETTO_Download(CancerSite,TargetDirectory = TargetDirectory)
    Downloading Gene Expression and Copy Number Variation data for: CHOL
    
    This TCGA cancer site/type was not tested, continue at your own risk.
    
    Error in .local(x, i, j, ...) : 'i' must be length 1
    Calls: AMARETTO_Download ... .getResources -> lapply -> FUN -> [[ -> [[ -> .local
    Execution halted
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
    License components with restrictions not permitted:
      Apache License (== 2.0) + file LICENSE
    'LinkingTo' field is unused: package has no 'src' directory
    ```

# assertr

<details>

* Version: 2.6
* Source code: https://github.com/cran/assertr
* URL: https://github.com/ropensci/assertr
* BugReports: https://github.com/ropensci/assertr/issues
* Date/Publication: 2019-01-22 20:50:06 UTC
* Number of recursive dependencies: 45

Run `revdep_details(,"assertr")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        1. testthat::expect_error(...)
        6. assertr::insist(mtcars, within_n_sds(5), tree)
        8. dplyr:::select.data.frame(data, !!!(keeper.vars))
        9. tidyselect::vars_select(tbl_vars(.data), !!!enquos(...))
       10. tidyselect:::eval_select_impl(...)
       11. tidyselect:::subclass_index_errors(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 388 | SKIPPED: 0 | WARNINGS: 9 | FAILED: 3 ]
      1. Failure: assert breaks appropriately (@test-assertions.R#224) 
      2. Failure: assert_rows breaks appropriately (@test-assertions.R#290) 
      3. Failure: insist breaks appropriately (@test-assertions.R#341) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# ddpcr

<details>

* Version: 1.11
* Source code: https://github.com/cran/ddpcr
* URL: https://github.com/daattali/ddpcr
* BugReports: https://github.com/daattali/ddpcr/issues
* Date/Publication: 2019-01-03 15:10:10 UTC
* Number of recursive dependencies: 88

Run `revdep_details(,"ddpcr")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    +   well_info(wells_success(plate), "negative_freq")
    Error: Can't use arithmetic operator `*` in selection context.
    <error/rlang_error>
    Can't use arithmetic operator `*` in selection context.
    Backtrace:
         █
      1. └─`%>%`(...)
      2.   ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      3.   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      4.     └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5.       └─`_fseq`(`_lhs`)
      6.         └─magrittr::freduce(value, `_function_list`)
      7.           └─function_list[[i]](value)
      8.             └─ddpcr::calculate_negative_freqs(.)
      9.               └─`%>%`(...) 00_pkg_src/ddpcr/R/pnpp_experiment-calculate_neg_freq.R:57:2
     10.                 ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
     11.                 └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
     12.                   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
     13.                     └─ddpcr:::`_fseq`(`_lhs`)
     14.                       └─magrittr::fre
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 136 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 23 ]
      1. Error: (unknown) (@test-custom_thresholds.R#4) 
      2. Error: get_empty_cutoff works (@test-empty.R#4) 
      3. Error: get_empty_cutoff for pnpp works (@test-empty.R#18) 
      4. Error: is_well_success works (@test-failures.R#4) 
      5. Error: get_outlier_cutoff works (@test-outliers.R#4) 
      6. Error: test basic plate attribute getters/setters (@test-plate-attribs.R#4) 
      7. Error: (unknown) (@test-plate.R#3) 
      8. Error: calculate_negative_freqs works (@test-pnpp_experiment-calculate_neg_freq.R#21) 
      9. Error: (unknown) (@test-pnpp_experiment.R#4) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# disk.frame

<details>

* Version: 0.3.1
* Source code: https://github.com/cran/disk.frame
* URL: https://diskframe.com
* BugReports: https://github.com/xiaodaigh/disk.frame/issues
* Date/Publication: 2019-12-20 09:00:02 UTC
* Number of recursive dependencies: 115

Run `revdep_details(,"disk.frame")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    +   # only run in interactive()
    +   setup_disk.frame(gui = TRUE)
    + }
    > 
    > # set the number workers to 2
    > setup_disk.frame(2)
    Warning in socketConnection("localhost", port = port, server = TRUE, blocking = TRUE,  :
      port 37400 cannot be opened
    Error in socketConnection("localhost", port = port, server = TRUE, blocking = TRUE,  : 
      Failed to launch and connect to R worker on local machine ‘localhost’ from local machine ‘Eustache’.
     * The error produced by socketConnection() was: ‘cannot open the connection’
     * In addition, socketConnection() produced 1 warning(s):
       - Warning #1: ‘port 37400 cannot be opened’ (which suggests that this port is either already occupied by another process or blocked by the firewall on your local machine)
     * The localhost socket connection that failed to connect to the R worker used port 37400 using a communication timeout of 120 seconds and a connection timeout of 120 seconds.
     * Worker launch call: '/Library/Frameworks/R.framework/Resources/bin/Rscript' --default-packages=datasets,utils,grDevices,graphics,stats,methods -e '#label=UNKNOWN:97989:Eustache:lionel' -e 'try(suppressWarnings(cat(Sys.getpid(),file="/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//RtmpZZAqd7/future.parent=97989.17ec528e44deb.pid")), silent = TRUE)' -e 'parallel:::.slaveRSOCK()' MASTER=localhost PORT=37400 OUT=/dev/null TIMEOUT=120 XDR=TRUE.
     * Worker (PID 98289) was successfully killed: TRUE
     * Troubleshooting suggestions:
       - Suggestion #1: Set 'verbose=TRUE' to see more details.
       - Suggestion #2: Set 'outfile=NULL' to see output from worker.
    Calls: setup_disk.frame ... tryCatchList -> tryCatchOne -> <Anonymous> -> <Anonymous>
    Execution halted
    ```

# levi

<details>

* Version: 1.2.0
* Source code: https://github.com/cran/levi
* Date/Publication: 2019-05-02
* Number of recursive dependencies: 83

Run `revdep_details(,"levi")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    ℹ There are only 2 elements.
    Backtrace:
        █
     1. └─levi::levi(...)
     2.   └─levi:::levi_function(...) 00_pkg_src/levi/R/levi.R:83:8
     3.     ├─dplyr::select(edges, -3) 00_pkg_src/levi/R/levi_function.R:295:12
     4.     └─dplyr:::select.data.frame(edges, -3)
     5.       └─tidyselect::vars_select(tbl_vars(.data), !!!enquos(...))
     6.         └─tidyselect:::eval_select_impl(...)
     7.           └─tidyselect:::subclass_index_errors(...)
    <parent: error/vctrs_error_subscript_oob_location>
    Must index existing elements.
    ✖ Can't subset position 3.
    ℹ There are only 2 elements.
    Backtrace:
         █
      1. ├─tidyselect:::sanitise_base_errors(expr)
      2. │ └─base::withCallingHandlers(...)
      3. ├─tidyselect:::vars_select_eval(...)
      4. │ └─tidyselect:::wa
    Execution halted
    ```

## In both

*   checking R code for possible problems ... NOTE
    ```
    levi_function: no visible binding for global variable ‘x’
      (/Users/lionel/Desktop/tidyselect/revdep-all/dplyr/checks.noindex/levi/new/levi.Rcheck/00_pkg_src/levi/R/levi_function.R:34)
    levi_function: no visible binding for global variable ‘x’
      (/Users/lionel/Desktop/tidyselect/revdep-all/dplyr/checks.noindex/levi/new/levi.Rcheck/00_pkg_src/levi/R/levi_function.R:503-532)
    levi_function: no visible binding for global variable ‘x’
      (/Users/lionel/Desktop/tidyselect/revdep-all/dplyr/checks.noindex/levi/new/levi.Rcheck/00_pkg_src/levi/R/levi_function.R:534-562)
    LEVIui: no visible global function definition for ‘is’
      (/Users/lionel/Desktop/tidyselect/revdep-all/dplyr/checks.noindex/levi/new/levi.Rcheck/00_pkg_src/levi/R/LEVIui.R:23-24)
    Undefined global functions or variables:
      is x
    Consider adding
      importFrom("methods", "is")
    to your NAMESPACE file (and ensure that your DESCRIPTION Imports field contains
    'methods').
    ```

# Mapinguari

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/Mapinguari
* URL: http://github.com/gabrielhoc/Mapinguari
* BugReports: http://github.com/gabrielhoc/Mapinguari/issues
* Date/Publication: 2019-09-30 16:40:02 UTC
* Number of recursive dependencies: 51

Run `revdep_details(,"Mapinguari")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    The error most likely occurred in:
    
    > ### Name: transform_rasters
    > ### Title: Transform raster values using custom calls.
    > ### Aliases: transform_rasters
    > 
    > ### ** Examples
    > 
    > # You can apply any function to subsets of rasters in the stack,
    > # by selecting the layers with double brackets.
    > 
    > transform_rasters(raster_stack = df_tmax,
    +     total_1sem = sum(tmax[1:6]),
    +     mean_1sem = mean(tmax[1:6]),
    +     sd_1sem = sd(tmax[1:6]))
    Warning in socketConnection("localhost", port = port, server = TRUE, blocking = TRUE,  :
      port 11831 cannot be opened
    Error in socketConnection("localhost", port = port, server = TRUE, blocking = TRUE,  : 
      cannot open the connection
    Calls: transform_rasters ... makePSOCKcluster -> newPSOCKnode -> socketConnection
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dplyr’ ‘rgdal’ ‘rlang’ ‘testthat’
      All declared Imports should be used.
    ```

# SemNeT

<details>

* Version: 1.1.2
* Source code: https://github.com/cran/SemNeT
* URL: https://github.com/AlexChristensen/SemNeT
* BugReports: https://github.com/AlexChristensen/SemNeT/issues
* Date/Publication: 2019-10-28 23:40:16 UTC
* Number of recursive dependencies: 187

Run `revdep_details(,"SemNeT")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > 
    > ### ** Examples
    > 
    > # Simulate Datasets
    > one <- sim.fluency(10)
    > 
    > # Compute similarity matrix
    > cos <- similarity(one, method = "cosine")
    > 
    > # Compute networks using NetworkToolbox
    > net <- NetworkToolbox::TMFG(cos)$A
    > ## Don't show: 
    > randnet.test(net, iter = 1, cores = 2)
    Generating random networks...done
    Computing network measures...
    Warning in socketConnection("localhost", port = port, server = TRUE, blocking = TRUE,  :
      port 11067 cannot be opened
    Error in socketConnection("localhost", port = port, server = TRUE, blocking = TRUE,  : 
      cannot open the connection
    Calls: randnet.test ... makePSOCKcluster -> newPSOCKnode -> socketConnection
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘grid’ ‘purrr’ ‘RColorBrewer’ ‘SemNetCleaner’
      All declared Imports should be used.
    ```

# teamcolors

<details>

* Version: 0.0.3
* Source code: https://github.com/cran/teamcolors
* URL: http://github.com/beanumber/teamcolors
* BugReports: https://github.com/beanumber/teamcolors/issues
* Date/Publication: 2019-11-27 07:20:02 UTC
* Number of recursive dependencies: 57

Run `revdep_details(,"teamcolors")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Expected match: "between"
      Actual message: "Must select existing columns.\n✖ Can't subset position 15.\nℹ There are only 11 elements."
      Backtrace:
        1. testthat::expect_error(team_pal(13), "between")
        6. teamcolors::team_pal(13)
        8. dplyr:::pull.data.frame(teams, which + 2)
        9. tidyselect::vars_pull(names(.data), !!enquo(var))
       10. tidyselect:::subclass_index_errors(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 6 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: colors work (@test-colors.R#7) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

