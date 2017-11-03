
This fixes the hotpatch hook in order to port dplyr to tidyselect.
It may also fix the sporadic CRAN warnings.


## Test environments

* local OS X install, R 3.4.1
* ubuntu 12.04 (on travis-ci, R devel and R release)
* Windows (on R-hub and Win-Builder)


## R CMD check results

0 errors | 0 warnings | 1 note

NOTE: Days since last update: 1


## Reverse dependencies

I have checked the 7 projects that depend on tidyselect. There were no
problems.
