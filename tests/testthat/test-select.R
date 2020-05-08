context("select")

test_that("select() is generic", {
  expect_identical(
    select(set_names(letters), b:c),
    c(b = "b", c = "c")
  )
  expect_identical(
    select(as.list(set_names(letters)), b:c),
    list(b = "b", c = "c")
  )
})

test_that("select() supports existing duplicates", {
  x <- list(a = 1, b = 2, a = 3)
  expect_identical(select(x, A = a), list(A = 1, A = 3))
})

test_that("can call `select_loc()` without arguments", {
  expect_identical(select_loc(mtcars), set_names(int(), chr()))
})

test_that("can specify inclusion and exclusion", {
  x <- list(a = 1, b = 2, c = 3)
  expect_identical(select_loc(x, int(), include = "b"), c(b = 2L))
  expect_identical(select_loc(x, -int(), exclude = c("a", "c")), c(b = 2L))
})

test_that("variables are excluded with non-strict `any_of()`", {
  expect_identical(
    select_loc(iris, 1:3, exclude = "foo"),
    select_loc(iris, 1:3)
  )
})

test_that("select_loc() checks inputs", {
  expect_error(select_loc(function() NULL), class = "vctrs_error_scalar_type")
})

test_that("select_loc() accepts name spec", {
  expect_identical(
    select_loc(mtcars, c(foo = c(mpg, cyl)), name_spec = "{outer}_{inner}"),
    c(foo_1 = 1L, foo_2 = 2L)
  )
})

test_that("result is named even with constant inputs (#173)", {
  expect_identical(
    eval_select("Sepal.Width", iris),
    c(Sepal.Width = 2L)
  )
})

test_that("can forbid rename syntax (#178)", {
  expect_error(select_loc(mtcars, c(foo = cyl), allow_rename = FALSE), "Can't rename")
  expect_error(select_loc(mtcars, c(cyl, foo = cyl), allow_rename = FALSE), "Can't rename")
  expect_named(select_loc(mtcars, starts_with("c") | all_of("am"), allow_rename = FALSE), NULL)
})
