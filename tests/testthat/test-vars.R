context("vars")

test_that("scoped_vars() restores previous state", {
  vars <- c("a", "b", "c")
  scoped_vars(vars)

  fn <- function() {
    scoped_vars(c("d", "e", "f"))
    starts_with("e")
  }
  expect_identical(fn(), 2L)

  expect_identical(peek_vars(), vars)
})

test_that("with_vars() works", {
  vars <- c("a", "b", "c")
  scoped_vars(vars)

  fn <- function(expr) {
    with_vars(c("rose", "blue", "red"), expr)
  }
  expect_identical(fn(starts_with("r")), c(1L, 3L))

  expect_identical(peek_vars(), vars)
})

test_that("has_vars() detects variables", {
  expect_false(has_vars())

  scoped_vars(letters)
  expect_true(has_vars())
})
