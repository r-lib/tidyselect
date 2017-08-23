context("rename vars")

test_that("when .strict = FALSE, vars_rename always succeeds", {
  expect_error(
    vars_rename(c("a", "b"), d = e, .strict = TRUE),
    "Unknown column `e`",
    fixed = TRUE
  )

  expect_error(
    vars_rename(c("a", "b"), d = e, f = g, .strict = TRUE),
    "Unknown columns `e` and `g`",
    fixed = TRUE
  )

  expect_equal(
    vars_rename(c("a", "b"), d = e, .strict = FALSE),
    c("a" = "a", "b" = "b")
  )

  expect_identical(
    vars_rename("x", A = x, B = y, .strict = FALSE),
    c(A = "x")
  )
})

test_that("vars_rename() works with positions", {
  expect_identical(vars_rename(letters[1:4], new1 = 2, new2 = 4), c(a = "a", new1 = "b", c = "c", new2 = "d"))
  expect_error(vars_rename(letters, new = 1.5), "Column positions must be round numbers")
})

test_that("vars_rename() expects symbol or string", {
  expect_error(
    vars_rename(letters, d = !! list()),
    '`d` = list() must be a symbol or a string, not a list',
    fixed = TRUE
  )
})
