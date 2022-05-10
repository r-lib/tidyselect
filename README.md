# tidyselect

<!-- badges: start -->
[![Codecov test coverage](https://codecov.io/gh/r-lib/tidyselect/branch/main/graph/badge.svg)](https://app.codecov.io/gh/r-lib/tidyselect?branch=main)
[![CRAN status](https://www.r-pkg.org/badges/version/tidyselect)](https://cran.r-project.org/package=tidyselect)
[![R-CMD-check](https://github.com/r-lib/tidyselect/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/r-lib/tidyselect/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->


## Overview

The tidyselect package is the backend of functions like `dplyr::select()`
or `dplyr::pull()` as well as several tidyr verbs. It allows you to
create selecting verbs that are consistent with other tidyverse packages.

* To learn about the selection syntax as a user of dplyr or tidyr, read
  the user-friendly [Selection language](https://tidyselect.r-lib.org/reference/language.html) reference.

* To learn how to implement tidyselect in your own functions, read the
  [Get started](https://tidyselect.r-lib.org/articles/tidyselect.html)
  vignette.

* To learn exactly how the tidyselect syntax is interpreted, read the
  [Technical description](https://tidyselect.r-lib.org/articles/syntax.html)
  vignette.


## Installation

tidyselect is on CRAN. You can also install the development version
from github with:

```r
# install.packages("remotes")
remotes::install_github("r-lib/tidyselect")
```


## Code of Conduct

Please note that the tidyselect project is released with a [Contributor Code of Conduct](https://tidyselect.r-lib.org/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
