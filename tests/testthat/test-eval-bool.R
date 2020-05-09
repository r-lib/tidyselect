
test_that("can refer to columns in | operands", {
  expect_identical(select_loc(mtcars, cyl | am), c(cyl = 2L, am = 9L))
})

test_that("can refer to columns in & operands", {
  expect_identical(select_loc(mtcars, cyl & contains("am")), set_names(int(), chr()))
  expect_identical(select_loc(mtcars, cyl & where(is.numeric)), c(cyl = 2L))
})

test_that("can use named inputs in & operands", {
    x <- list(a = 1L, b = 2L)
    expect_identical(select_loc(x, a & c(foo = a)), c(foo = 1L))
    expect_identical(select_loc(x, c(foo = a) & a), c(foo = 1L))
    expect_identical(select_loc(x, c(foo = a) & c(bar = a)), named(int()))
})

test_that("symbol operands are evaluated in strict mode", {
  foo <- 1:2
  expect_error(
    select(iris, Species | foo),
    class = "vctrs_error_subscript_oob"
  )
})

test_that("boolean operators throw relevant errors", {
  expect_error(
    select_loc(mtcars, foobar & contains("am")),
    class = "vctrs_error_subscript_oob"
  )
  expect_error(
    select_loc(mtcars, contains("am") | foobar),
    class = "vctrs_error_subscript_oob"
  )
  expect_error(
    select_loc(mtcars, cyl & am),
    "empty selection"
  )

  verify_output(test_path("outputs", "select-eval-boolean-errors.txt"), {
    "Unknown names"
    select_loc(mtcars, foobar & contains("am"))
    select_loc(mtcars, contains("am") | foobar)

    "Empty intersection"
    select_loc(mtcars, cyl & am)

    "Symbol operands are evaluated in strict mode"
    foo <- 1:2
    select_loc(iris, Species | foo)
  })
})
