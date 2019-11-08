
test_that("can refer to columns in | operands", {
  expect_identical(select_pos(mtcars, cyl | am), c(cyl = 2L, am = 9L))
})

test_that("can refer to columns in & operands", {
  expect_identical(select_pos(mtcars, cyl & contains("am")), set_names(int(), chr()))
  expect_identical(select_pos(mtcars, cyl & is.numeric), c(cyl = 2L))
})

test_that("can use named inputs in & operands", {
    x <- list(a = 1L, b = 2L)
    expect_identical(select_pos(x, a & c(foo = a)), c(foo = 1L))
    expect_identical(select_pos(x, c(foo = a) & a), c(foo = 1L))
    expect_identical(select_pos(x, c(foo = a) & c(bar = a)), named(int()))
})

test_that("boolean operators throw relevant errors", {
  expect_error(
    select_pos(mtcars, foobar & contains("am")),
    class = "tidyselect_error_index_oob_names"
  )
  expect_error(
    select_pos(mtcars, contains("am") | foobar),
    class = "tidyselect_error_index_oob_names"
  )
  expect_error(
    select_pos(mtcars, cyl & am),
    "empty selection"
  )

  verify_output(test_path("outputs", "select-eval-boolean-errors.txt"), {
    "Unknown names"
    select_pos(mtcars, foobar & contains("am"))
    select_pos(mtcars, contains("am") | foobar)

    "Empty intersection"
    select_pos(mtcars, cyl & am)
  })
})
