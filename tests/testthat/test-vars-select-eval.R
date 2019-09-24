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

test_that("quosures can be used in data expressions", {
  expect_identical(vars_select(letters, !!quo(a)), vars_select(letters, a))
  expect_identical(vars_select(letters, !!quo(a:!!quo(c))), vars_select(letters, a:c))
})

test_that("quosures update the current context", {
  quo <- local({
    `_foo` <- 24
    quo(a:identity(`_foo`))
  })
  expect_identical(vars_select(letters, !!quo(-(!!quo))), vars_select(letters, -(a:24)))
})
