context("vars-select-eval")

test_that("leaves of data expression tree are evaluated in the context", {
  wrapper <- function(x, var) vars_select(x, {{ var }}:length(x))
  expect_identical(wrapper(letters, x), vars_select(letters, x:26))

  wrapper <- function(x, var) vars_select(x, -({{ var }}:length(x)))
  expect_identical(wrapper(letters, x), vars_select(letters, -(x:26)))
})

test_that("non-data variables in data context are deprecated", {
  withr::local_options(c(lifecycle_verbosity = TRUE))
  deprecated <- 3
  expect_warning(vars_select(letters, deprecated), "deprecated")
  expect_warning(vars_select(letters, -deprecated), "deprecated")
  expect_warning(vars_select(letters, 1:deprecated), "deprecated")
})
