context("vars-select-eval")

test_that("leaves of data expression tree are evaluated in the context", {
  wrapper <- function(x, var) vars_select(x, {{ var }}:length(x))
  expect_identical(wrapper(letters, x), vars_select(letters, x:26))
})
