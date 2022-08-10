test_that("last_col() selects last argument with offset", {
  vars <- letters[1:3]
  expect_identical(last_col(0, vars), 3L)
  expect_identical(last_col(2, vars), 1L)
})

test_that("last_col() checks its inputs", {
  expect_snapshot(error = TRUE, {
    last_col(3, letters[1:3])
    last_col(0, character())
    last_col(1:2, letters[1:3])
  })
})
