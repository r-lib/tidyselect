context("select")

test_that("vec_select() is generic", {
  expect_identical(
    vec_select(set_names(letters), b:c),
    c(b = "b", c = "c")
  )
  expect_identical(
    vec_select(as.list(set_names(letters)), b:c),
    list(b = "b", c = "c")
  )
})

test_that("vec_select() supports existing duplicates", {
  x <- list(a = 1, b = 2, a = 3)
  expect_identical(vec_select(x, A = a), list(A = 1, A = 3))
})

test_that("can call `select_pos()` without arguments", {
  expect_identical(select_pos(mtcars), set_names(int(), chr()))
})

test_that("can specify inclusion and exclusion", {
  x <- list(a = 1, b = 2, c = 3)
  expect_identical(select_pos(x, int(), .include = "b"), c(b = 2L))
  expect_identical(select_pos(x, -int(), .exclude = c("a", "c")), c(b = 2L))
})

test_that("select_pos() checks inputs", {
  expect_error(select_pos(function() NULL), class = "vctrs_error_scalar_type")
})
