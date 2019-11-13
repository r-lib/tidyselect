# tidyselect

<!-- badges: start -->
[![Travis build status](https://travis-ci.org/r-lib/tidyselect.svg?branch=master)](https://travis-ci.org/r-lib/tidyselect)
[![Codecov test coverage](https://codecov.io/gh/r-lib/tidyselect/branch/master/graph/badge.svg)](https://codecov.io/gh/r-lib/tidyselect?branch=master)
[![CRAN status](https://www.r-pkg.org/badges/version/tidyselect)](https://cran.r-project.org/package=tidyselect)
<!-- badges: end -->


## Overview

The tidyselect package is the backend of functions like `dplyr::select()`
or `dplyr::pull()` as well as several tidyr verbs. It allows you to
create selecting verbs that are consistent with other tidyverse packages.

* To learn about tidyselect syntax as a user of dplyr or tidyr, read
  the [Select columns](https://r4ds.had.co.nz/transform.html#select)
  section of the R4DS book.

* To learn how to implement tidyselect in your own functions, read the
  [Get started](https://tidyselect.r-lib.org/articles/tidyselect.html)
  vignette.

* To learn exactly how the tidyselect syntax is interpreted, read the
  [Technical descrition](https://tidyselect.r-lib.org/articles/syntax.html)
  vignette.


## Installation

tidyselect is on CRAN. You can also install the development version
from github with:

```r
# install.packages("remotes")
remotes::install_github("r-lib/tidyselect")
```
