# ipumsr

<details>

* Version: 0.7.1
* GitHub: https://github.com/ipums/ipumsr
* Source code: https://github.com/cran/ipumsr
* Date/Publication: 2024-02-26 16:00:03 UTC
* Number of recursive dependencies: 138

Run `revdepcheck::cloud_details(, "ipumsr")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(ipumsr)
      
      Attaching package: 'ipumsr'
      
      The following object is masked from 'package:testthat':
      
    ...
        'test_viewer.R:37:3' [success]
      End test: attribute-less microdata doesn't error
      
      Start test: nhgis codebook doesn't error
        'test_viewer.R:45:3' [warning]
        'test_viewer.R:46:3' [success]
      End test: nhgis codebook doesn't error
      
      Error: Test failures
      Execution halted
    ```

# pointblank

<details>

* Version: 0.12.0
* GitHub: https://github.com/rstudio/pointblank
* Source code: https://github.com/cran/pointblank
* Date/Publication: 2024-03-01 08:30:02 UTC
* Number of recursive dependencies: 135

Run `revdepcheck::cloud_details(, "pointblank")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(pointblank)
      > library(dittodb)
      Loading required package: DBI
      > test_check("pointblank")
      [ FAIL 19 | WARN 0 | SKIP 0 | PASS 1540 ]
      
    ...
        7.   ├─base::tryCatch(...)
        8.   │ └─base (local) tryCatchList(expr, classes, parentenv, handlers)
        9.   │   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
       10.   │     └─base (local) doTryCatch(return(expr), name, parentenv, handler)
       11.   └─pointblank:::resolve_columns(...)
       12.     └─rlang::cnd_signal(rlang::error_cnd("resolve_eval_err", parent = out))
      
      [ FAIL 19 | WARN 0 | SKIP 0 | PASS 1540 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1 marked UTF-8 string
    ```

