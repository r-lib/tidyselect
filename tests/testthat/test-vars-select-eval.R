context("vars-select-eval")

test_that("leaves of data expression tree are evaluated in the context", {
  wrapper <- function(x, var) vars_select(x, {{ var }}:length(x))
  expect_identical(wrapper(letters, x), vars_select(letters, x:26))

  wrapper <- function(x, var) vars_select(x, -({{ var }}:length(x)))
  expect_identical(wrapper(letters, x), vars_select(letters, -(x:26)))

  wrapper <- function(x, var1, var2) vars_select(x, c(-{{ var1 }}, -({{ var2 }}:length(x))))
  expect_identical(wrapper(letters, a, c), vars_select(letters, -a, -(c:26)))
})

test_that("dots passed to `c()` are evaluated in their context", {
  wrapper <- function(x, ...) {
    vars_select(x, c(x, length(x), ...))
  }
  f <- function(x, ...) {
    a <- 13
    g(x, ..., identity(a))
  }
  g <- function(x, ...) {
    a <- 15
    wrapper(x, ..., identity(a))
  }
  expect_identical(f(letters, e, 10), vars_select(letters, x, 26, e, 10, 13, 15))
})

test_that("non-data variables in data context are deprecated", {
  withr::local_options(c(lifecycle_verbosity = TRUE))
  deprecated <- 3
  expect_warning(vars_select(letters, deprecated), "deprecated")
  expect_warning(vars_select(letters, -deprecated), "deprecated")
  expect_warning(vars_select(letters, 1:deprecated), "deprecated")
  expect_warning(vars_select(letters, c(deprecated)), "deprecated")
})

test_that("quosures can be used in data expressions", {
  expect_identical(vars_select(letters, !!quo(a)), vars_select(letters, a))
  expect_identical(vars_select(letters, !!quo(a:!!quo(c))), vars_select(letters, a:c))
  expect_identical(vars_select(letters, !!quo(c(!!quo(a)))), vars_select(letters, a))
})

test_that("quosures update the current context", {
  quo <- local({
    `_foo` <- 24
    quo(a:identity(`_foo`))
  })
  expect_identical(vars_select(letters, !!quo(c(-(!!quo)))), vars_select(letters, -(a:24)))
})
