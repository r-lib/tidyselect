# tidyr

Version: 0.7.0

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(testthat)
      > library(tidyr)
      > 
      > test_check("tidyr")
      1. Failure: errors are raised (@test-drop_na.R#40) -----------------------------
      tidyr::drop_na(df, NULL) did not throw an error.
      
      
      testthat results ================================================================
      OK: 215 SKIPPED: 0 FAILED: 1
      1. Failure: errors are raised (@test-drop_na.R#40) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 23 marked UTF-8 strings
    ```

