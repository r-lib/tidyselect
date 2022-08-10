
test_that("last_col() selects last argument with offset", {
  vars <- letters[1:3]
  expect_identical(last_col(0, vars), 3L)
  expect_identical(last_col(2, vars), 1L)

  expect_error(last_col(3, vars), "`offset` must be smaller than the number of columns")
  expect_error(last_col(vars = chr()), "Can't select last column when input is empty")
})
