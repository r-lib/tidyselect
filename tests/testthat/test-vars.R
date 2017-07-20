context("vars")

test_that("scoped_vars() restores previous state", {
  vars <- c("a", "b", "c")
  scoped_vars(vars)

  fn <- function() {
    scoped_vars(c("d", "e", "f"))
    starts_with("e")
  }
  expect_identical(fn(), 2L)

  expect_identical(query_vars(), vars)
})
