# DEP

<details>

* Version: 1.6.1
* Source code: https://github.com/cran/DEP
* Date/Publication: 2019-08-08
* Number of recursive dependencies: 149

Run `revdep_details(,"DEP")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        7. rmarkdown::render(...) revdep/checks.noindex/DEP/new/DEP.Rcheck/00_pkg_src/DEP/R/workflow_functions.R:334:4
        8. rmarkdown::render(...)
        9. rmarkdown:::latexmk(...)
       10. tinytex::latexmk(file, engine, if (biblatex) "biber" else "bibtex")
       11. tinytex:::latexmk_emu(...)
       12. tinytex:::run_engine()
       14. tinytex:::on_error()
       15. tinytex:::show_latex_error(file, logfile)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 332 | SKIPPED: 0 | WARNINGS: 3 | FAILED: 1 ]
      1. Error: report output  (@test_9_workflows.R#69) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## Newly fixed

*   R CMD check timed out
    

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.7Mb
      sub-directories of 1Mb or more:
        data   1.4Mb
        doc    3.1Mb
    ```

# GerminaR

<details>

* Version: 1.3
* Source code: https://github.com/cran/GerminaR
* URL: https://flavjack.shinyapps.io/germinaquant/
* BugReports: https://github.com/Flavjack/GerminaR/issues
* Date/Publication: 2019-04-18 16:30:21 UTC
* Number of recursive dependencies: 120

Run `revdep_details(,"GerminaR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > 
    > library(GerminaR)
    > dt <- prosopis
    > gas <- ger_ASG(SeedN = "seeds", evalName = "D", data = dt)
    Error: argument is not interpretable as logical
    <error/rlang_error>
    argument is not interpretable as logical
    Backtrace:
        █
     1. └─GerminaR::ger_ASG(SeedN = "seeds", evalName = "D", data = dt)
     2.   └─GerminaR::ger_GRP(SeedN, evalName, data) 00_pkg_src/GerminaR/R/indexes.R:75:2
     3.     └─GerminaR::ger_GRS(evalName, data) 00_pkg_src/GerminaR/R/indexes.R:50:2
     4.       └─GerminaR::evalDays(evalName, data) 00_pkg_src/GerminaR/R/indexes.R:17:2
     5.         ├─dplyr::select(data, starts_with(colnames(data), evalName)) 00_pkg_src/GerminaR/R/utils.R:58:4
     6.         └─dplyr:::select.data.frame(data, starts_with(colnames(data), evalName))
     7.           └─tidyselect::vars_select(tbl_vars(.data), !!!enquos(...))
     8.             └─tidyselect:::eval_select_impl(...)
     9.               └─tidyselect:::subclass_index_errors(...)
    <parent: error/simpleError>
    argument is not interpretable as logical
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘DT’ ‘shinydashboard’
      All declared Imports should be used.
    ```

# irteQ

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/irteQ
* URL: https://github.com/hwangQ/irteQ
* BugReports: https://github.com/hwangQ/irteQ/issues
* Date/Publication: 2018-11-19 18:30:08 UTC
* Number of recursive dependencies: 0

Run `revdep_details(,"irteQ")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > # conduct the IRT linking using a non-symmetric Stocking-Lord method
    > rst <- irtlink(x, method.link = 'SL', D = 1.7)
    Error: Can't use arithmetic operator `+` in selection context.
    <error/rlang_error>
    Can't use arithmetic operator `+` in selection context.
    Backtrace:
         █
      1. ├─irteQ::irtlink(x, method.link = "SL", D = 1.7)
      2. └─irteQ:::irtlink.preplink(x, method.link = "SL", D = 1.7) 00_pkg_src/irteQ/R/irtlink.R:250:11
      3.   └─irteQ:::MMS(anc.base, anc.new, method.link = "MS") 00_pkg_src/irteQ/R/irtlink.R:316:2
      4.     └─`%>%`(...) 00_pkg_src/irteQ/R/linking_methods.R:117:2
      5.       ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      6.       └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      7.         └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      8.           └─irteQ:::`_fseq`(`_lhs`)
      9.             └─magrittr::freduce(value, `_function_list`)
     10.               └─function_list[[i]](value)
     11.                 └─dplyr::mutate_at(...)
     12.                   └─dplyr:::manip_at(...)
     13.                     └─dplyr:::tbl_at_s
    Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘rpf’, ‘plink’
    ```

# janitor

<details>

* Version: 1.2.0
* Source code: https://github.com/cran/janitor
* URL: https://github.com/sfirke/janitor
* BugReports: https://github.com/sfirke/janitor/issues
* Date/Publication: 2019-04-21 04:20:13 UTC
* Number of recursive dependencies: 60

Run `revdep_details(,"janitor")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        1. testthat::expect_error(mtcars %>% tabyl(moose), "object 'moose' not found")
        6. janitor::tabyl(., moose)
       15. janitor:::tabyl_1way(...) revdep-all/tidyr/checks.noindex/janitor/new/janitor.Rcheck/00_pkg_src/janitor/R/tabyl.R:150:4
       16. dplyr:::select.data.frame(dat, !!var1)
       18. tidyselect::vars_select(tbl_vars(.data), !!!enquos(...))
       19. tidyselect:::eval_select_impl(...)
       20. tidyselect:::subclass_index_errors(...)
       21. testthat::expect_error(mtcars %>% tabyl(moose), "object 'moose' not found")
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 559 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: if called on non-existent vector, returns useful error message (@test-tabyl.R#190) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# mnreadR

<details>

* Version: 2.1.3
* Source code: https://github.com/cran/mnreadR
* URL: http://legge.psych.umn.edu/mnread-acuity-charts
* Date/Publication: 2019-07-19 10:10:03 UTC
* Number of recursive dependencies: 45

Run `revdep_details(,"mnreadR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    ✖ `i` has the wrong type `logical`.
    ℹ These indices must be locations or names.
    <error/tidyselect_error_subscript_bad_type>
    Must select with column names or positions.
    ✖ `i` has the wrong type `logical`.
    ℹ These indices must be locations or names.
    Backtrace:
         █
      1. └─mnreadR::mnreadCurve(data_s1, ps, vd, rt, err, polarity)
      2.   └─`%>%`(...) 00_pkg_src/mnreadR/R/mnread_curve.R:242:4
      3.     ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      4.     └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5.       └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      6.         └─mnreadR:::`_fseq`(`_lhs`)
      7.           └─magrittr::freduce(value, `_function_list`)
      8.             ├─base::withVisible(function_list[[k]](value))
      9.             └─function_list[[k]](value)
     10.               ├─dplyr::select(., -.drop)
     11.               └─dplyr:::select.data.frame(., -.drop)
     12. 
    Execution halted
    ```

# nationwider

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/nationwider
* URL: https://github.com/kvasilopoulos/nationwider
* BugReports: https://github.com/kvasilopoulos/nationwider/issues
* Date/Publication: 2019-10-04 10:50:02 UTC
* Number of recursive dependencies: 84

Run `revdep_details(,"nationwider")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       19. tidyr::gather(., key, value, -Date)
       36. tidyselect::vars_select(tbl_vars(data), !!!quos)
       37. tidyselect:::eval_select_impl(...)
       38. tidyselect:::vars_select_eval(...)
       39. vctrs::vec_as_names(names(pos), repair = "check_unique")
        1. vctrs:::validate_unique(names)
        5. vctrs:::validate_minimal(names, n)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 21 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 2 ]
      1. Failure: id works (@test-symbols.R#14) 
      2. Error: tidy objects (@test-tidy.R#9) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# pammtools

<details>

* Version: 0.1.14
* Source code: https://github.com/cran/pammtools
* URL: https://github.com/adibender/pammtools
* BugReports: https://github.com/adibender/pammtools/issues
* Date/Publication: 2019-09-08 14:40:02 UTC
* Number of recursive dependencies: 96

Run `revdep_details(,"pammtools")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ── 1. Failure: LL helpers and as_ped produce equivalent LL windows (@test-cumula
      `LL1` not equal to `LL1.2`.
      Types not compatible: double is not character
      
      ── 2. Failure: LL helpers and as_ped produce equivalent LL windows (@test-cumula
      `LL2` not equal to `LL2.2`.
      Types not compatible: double is not character
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 284 | SKIPPED: 0 | WARNINGS: 4 | FAILED: 2 ]
      1. Failure: LL helpers and as_ped produce equivalent LL windows (@test-cumulative-effect.R#55) 
      2. Failure: LL helpers and as_ped produce equivalent LL windows (@test-cumulative-effect.R#56) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# sjPlot

<details>

* Version: 2.8.1
* Source code: https://github.com/cran/sjPlot
* URL: https://strengejacke.github.io/sjPlot/
* BugReports: https://github.com/strengejacke/sjPlot/issues
* Date/Publication: 2019-12-03 11:20:02 UTC
* Number of recursive dependencies: 190

Run `revdep_details(,"sjPlot")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > # plot "cross tablulation" of x and grp
    > plot_xtab(x, grp)
    Error: Can't use arithmetic operator `+` in selection context.
    <error/rlang_error>
    Can't use arithmetic operator `+` in selection context.
    Backtrace:
         █
      1. └─sjPlot::plot_xtab(x, grp)
      2.   ├─tidyr::gather(myptab, "group", "prc", !!2:(grpcount + 1), factor_key = TRUE) 00_pkg_src/sjPlot/R/sjPlotxtab.R:244:2
      3.   └─tidyr:::gather.data.frame(...)
      4.     ├─base::unname(tidyselect::vars_select(tbl_vars(data), !!!quos))
      5.     └─tidyselect::vars_select(tbl_vars(data), !!!quos)
      6.       └─tidyselect:::eval_select_impl(...)
      7.         ├─tidyselect:::subclass_index_errors(...)
      8.         │ ├─base::tryCatch(...)
      9.         │ │ └─base:::tryCatchList(expr, classes, parentenv, handlers)
     10.         │ │   ├─base:::tryCatchOne(...)
     11.         │ │   │ └─base:::doTryCatch(return(expr), name, parentenv, handler)
     12.         │ │   └─base:::tryCatchList(expr, names[-nh], parentenv, handlers[-nh])
     13.         
    Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘snakecase’
    ```

