# condformat

Version: 0.7.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > test_check("condformat")
      Unable to find any JVMs matching version "(null)".
      No Java runtime present, try --request to install.
      -- 1. Error: condformat2excel generates a file (@test_rendering.R#38)  ---------
      Please install the xlsx package in order to export to excel
      1: condformat2excel(condformat(head(iris, n = rows_to_write)), filename = filename) at testthat/test_rendering.R:38
      2: require_xlsx() at /Users/lionel/Desktop/tidyselect/revdep/checks.noindex/condformat/new/condformat.Rcheck/00_pkg_src/condformat/R/condformat_render.R:111
      3: stop("Please install the xlsx package in order to export to excel") at /Users/lionel/Desktop/tidyselect/revdep/checks.noindex/condformat/new/condformat.Rcheck/00_pkg_src/condformat/R/condformat_render.R:88
      
      == testthat results  ===========================================================
      OK: 114 SKIPPED: 0 FAILED: 1
      1. Error: condformat2excel generates a file (@test_rendering.R#38) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Unable to find any JVMs matching version "(null)".
    No Java runtime present, try --request to install.
    Unable to find any JVMs matching version "(null)".
    No Java runtime present, try --request to install.
    ```

# dlookr

Version: 0.3.2

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.1Mb
      sub-directories of 1Mb or more:
        doc   4.2Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dbplyr’ ‘randomForest’
      All declared Imports should be used.
    ```

# dplyr

Version: 0.7.6

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  8.2Mb
      sub-directories of 1Mb or more:
        R      2.1Mb
        libs   4.4Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4 marked UTF-8 strings
    ```

# ggeffects

Version: 0.5.0

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘ordinal’
    ```

# heatmaply

Version: 0.15.2

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.3Mb
      sub-directories of 1Mb or more:
        doc   4.6Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘d3heatmap’
    ```

# implyr

Version: 0.2.4

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Loading required package: rJava
      Unable to find any JVMs matching version "(null)".
      No Java runtime present, try --request to install.
      Error: package or namespace load failed for 'rJava':
       .onLoad failed in loadNamespace() for 'rJava', details:
        call: dyn.load(file, DLLpath = DLLpath, ...)
        error: unable to load shared object '/Users/lionel/Desktop/tidyselect/revdep/library.noindex/implyr/rJava/libs/rJava.so':
        dlopen(/Users/lionel/Desktop/tidyselect/revdep/library.noindex/implyr/rJava/libs/rJava.so, 6): Library not loaded: /Library/Java/JavaVirtualMachines/jdk-9.jdk/Contents/Home/lib/server/libjvm.dylib
        Referenced from: /Users/lionel/Desktop/tidyselect/revdep/library.noindex/implyr/rJava/libs/rJava.so
        Reason: image not found
      Error: package 'rJava' could not be loaded
      In addition: Warning message:
      In system("/usr/libexec/java_home", intern = TRUE) :
        running command '/usr/libexec/java_home' had status 1
      Execution halted
    ```

# pivot

Version: 18.4.17

## In both

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘odbc’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘colorspace’ ‘lubridate’
      All declared Imports should be used.
    ```

# plyranges

Version: 1.0.3

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
             e$handled <- TRUE
             test_error <<- e
         }, "could not find function \"WIGFile\"", quote(WIGFile(test_wig))) at testthat/test-io-wig.R:24
      2: eval(code, test_env)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 271 SKIPPED: 0 FAILED: 5
      1. Error: read_bed returns correct GRanges (@test-io-bed.R#67) 
      2. Error: read_bed_graph returns correct GRanges (@test-io-bedGraph.R#39) 
      3. Error: reading/ writing bigwig files returns correct GRanges (@test-io-bw.R#19) 
      4. Error: reading GFF files returns correct GRanges (@test-io-gff.R#87) 
      5. Error: reading WIG files (@test-io-wig.R#24) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘BSgenome.Hsapiens.UCSC.hg19’
    ```

# rscorecard

Version: 0.10.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tidyselect’
      All declared Imports should be used.
    ```

# RSDA

Version: 2.0.7

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘randomcoloR’
      All declared Imports should be used.
    ```

# sf

Version: 0.6-3

## In both

*   checking whether package ‘sf’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/lionel/Desktop/tidyselect/revdep/checks.noindex/sf/new/sf.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘sf’ ...
** package ‘sf’ successfully unpacked and MD5 sums checked
configure: CC: clang
configure: CXX: clang++
checking for gdal-config... /usr/local/bin/gdal-config
checking gdal-config usability... yes
configure: GDAL: 2.3.1
checking GDAL version >= 2.0.0... yes
checking for gcc... clang
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... 
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether clang accepts -g... yes
checking for clang option to accept ISO C89... none needed
checking how to run the C preprocessor... clang -E
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking gdal.h usability... yes
checking gdal.h presence... yes
checking for gdal.h... yes
checking GDAL: linking with --libs only... no
checking GDAL: linking with --libs and --dep-libs... no
In file included from gdal_test.cpp:1:
In file included from /usr/local/include/gdal.h:45:
/usr/local/include/cpl_port.h:187:6: error: Must have C++11 or newer.
#    error Must have C++11 or newer.
     ^
1 error generated.
In file included from gdal_test.cpp:1:
In file included from /usr/local/include/gdal.h:45:
/usr/local/include/cpl_port.h:187:6: error: Must have C++11 or newer.
#    error Must have C++11 or newer.
     ^
1 error generated.
configure: Install failure: compilation and/or linkage problems.
configure: error: GDALAllRegister not found in libgdal.
ERROR: configuration failed for package ‘sf’
* removing ‘/Users/lionel/Desktop/tidyselect/revdep/checks.noindex/sf/new/sf.Rcheck/sf’

```
### CRAN

```
* installing *source* package ‘sf’ ...
** package ‘sf’ successfully unpacked and MD5 sums checked
configure: CC: clang
configure: CXX: clang++
checking for gdal-config... /usr/local/bin/gdal-config
checking gdal-config usability... yes
configure: GDAL: 2.3.1
checking GDAL version >= 2.0.0... yes
checking for gcc... clang
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... 
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether clang accepts -g... yes
checking for clang option to accept ISO C89... none needed
checking how to run the C preprocessor... clang -E
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking gdal.h usability... yes
checking gdal.h presence... yes
checking for gdal.h... yes
checking GDAL: linking with --libs only... no
checking GDAL: linking with --libs and --dep-libs... no
In file included from gdal_test.cpp:1:
In file included from /usr/local/include/gdal.h:45:
/usr/local/include/cpl_port.h:187:6: error: Must have C++11 or newer.
#    error Must have C++11 or newer.
     ^
1 error generated.
In file included from gdal_test.cpp:1:
In file included from /usr/local/include/gdal.h:45:
/usr/local/include/cpl_port.h:187:6: error: Must have C++11 or newer.
#    error Must have C++11 or newer.
     ^
1 error generated.
configure: Install failure: compilation and/or linkage problems.
configure: error: GDALAllRegister not found in libgdal.
ERROR: configuration failed for package ‘sf’
* removing ‘/Users/lionel/Desktop/tidyselect/revdep/checks.noindex/sf/old/sf.Rcheck/sf’

```
# SingleCaseES

Version: 0.4.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    pandoc-citeproc: when expecting a product (:*:), encountered Object instead
    Error running filter /usr/local/bin/pandoc-citeproc:
    Filter returned error status 1
    Error: processing vignette 'Effect-size-definitions.Rmd' failed with diagnostics:
    pandoc document conversion failed with error 83
    Execution halted
    ```

# tidybayes

Version: 1.0.1

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘rjags’
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘rjags’
    ```

# tidyinftheo

Version: 0.2.1

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      12: shannon_entropy(.)
      13: reduce_data(.data, !!enquo(X), numvars = 1, na.rm = na.rm) at /Users/lionel/Desktop/tidyselect/revdep/checks.noindex/tidyinftheo/new/tidyinftheo.Rcheck/00_pkg_src/tidyinftheo/R/inftheo.R:70
      14: tidyselect::vars_select(names(reduced_tab), !!!quos(...)) at /Users/lionel/Desktop/tidyselect/revdep/checks.noindex/tidyinftheo/new/tidyinftheo.Rcheck/00_pkg_src/tidyinftheo/R/inftheo.R:26
      15: vars_select_eval(.vars, quos) at /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/RtmpYfYZ6E/R.INSTALL88695a0b73d2/tidyselect/R/vars-select.R:118
      16: map_lgl(quos, quo_is_helper) at /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/RtmpYfYZ6E/R.INSTALL88695a0b73d2/tidyselect/R/vars-select.R:222
      17: .f(.x[[i]], ...)
      18: extract_expr(quo) at /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/RtmpYfYZ6E/R.INSTALL88695a0b73d2/tidyselect/R/vars-select.R:292
      19: is_call(expr, paren_sym) at /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/RtmpYfYZ6E/R.INSTALL88695a0b73d2/tidyselect/R/vars-select.R:285
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 37 SKIPPED: 0 FAILED: 1
      1. Error: right number of columns given (@test-errors.R#10) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    pandoc-citeproc: when expecting a product (:*:), encountered Object instead
    Error running filter /usr/local/bin/pandoc-citeproc:
    Filter returned error status 1
    Error: processing vignette 'math.Rmd' failed with diagnostics:
    pandoc document conversion failed with error 83
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘tibble’ ‘tidyverse’
      All declared Imports should be used.
    ```

# tidyr

Version: 0.8.1

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 23 marked UTF-8 strings
    ```

# tsibble

Version: 0.5.3

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    The following object is masked from 'package:stats':
    
        filter
    
    
    Attaching package: 'lubridate'
    
    The following objects are masked from 'package:tsibble':
    
        interval, new_interval
    
    The following object is masked from 'package:base':
    
        date
    
    pandoc-citeproc: when expecting a product (:*:), encountered Object instead
    Error running filter /usr/local/bin/pandoc-citeproc:
    Filter returned error status 1
    Error: processing vignette 'intro-tsibble.Rmd' failed with diagnostics:
    pandoc document conversion failed with error 83
    Execution halted
    ```

# yardstick

Version: 0.0.1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
         {
             rlang::abort("No variables or terms were selected.")
         }, class = c("exiting", "handler")))
      10: tryCatchList(expr, classes, parentenv, handlers)
      11: tryCatchOne(expr, names, parentenv, handlers[[1L]])
      12: value[[3L]](cond)
      13: rlang::abort("No variables or terms were selected.") at /Users/lionel/Desktop/tidyselect/revdep/checks.noindex/yardstick/new/yardstick.Rcheck/00_pkg_src/yardstick/R/selectors.R:5
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 118 SKIPPED: 0 FAILED: 2
      1. Error: correct metrics returned (@test_metrics.R#17) 
      2. Error: correct results (@test_metrics.R#88) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

