context("vars")

test_that("local_vars() restores previous state", {
  vars <- c("a", "b", "c")
  local_vars(vars)

  fn <- function() {
    local_vars(c("d", "e", "f"))
    starts_with("e")
  }
  expect_identical(fn(), 2L)

  expect_identical(peek_vars(), vars)
})

test_that("with_vars() works", {
  vars <- c("a", "b", "c")
  local_vars(vars)

  fn <- function(expr) {
    with_vars(c("rose", "blue", "red"), expr)
  }
  expect_identical(fn(starts_with("r")), c(1L, 3L))

  expect_identical(peek_vars(), vars)
})

test_that("has_vars() detects variables", {
  expect_false(has_vars())

  local_vars(letters)
  expect_true(has_vars())
})

test_that("Missing names are kept", {
  local_vars(c("foo", NA))
  expect_identical(peek_vars(), c("foo", NA))

  local_vars(c(NA, "foo"))
  expect_identical(peek_vars(), c(NA, "foo"))

  local_vars(c("bar", ""))
  expect_identical(peek_vars(), c("bar", ""))

  local_vars(c("", "bar"))
  expect_identical(peek_vars(), c("", "bar"))
})

test_that("full data is in scope", {
  x <- structure(set_names(letters), class = c("foo", "character"))

  identical <- FALSE
  helper <- function(data = peek_data()) {
    identical <<- identical(data, x)
    1
  }

  select_loc(x, helper())
  expect_true(identical)
})

test_that("peek_data() fails informatively", {
  expect_error(peek_data(), "must be used within")
})
