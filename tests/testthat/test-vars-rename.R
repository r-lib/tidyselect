context("rename vars")

test_that("when .strict = FALSE, vars_rename always succeeds", {
  expect_error(
    vars_rename(c("a", "b"), d = e, .strict = TRUE),
    "`e` contains unknown columns",
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

test_that("vars_rename() expects symbol or string", {
  expect_error(
    vars_rename(letters, d = 1),
    '`d` = 1 must be a symbol or a string',
    fixed = TRUE
  )
})
