
test_that("location must resolve to numeric variables throws error", {
  expect_error(
    select_loc(letters2, !!list()),
    class = "vctrs_error_subscript_type"
  )
  expect_error(
    select_loc(letters2, !!env()),
    class = "vctrs_error_subscript_type"
  )
})

test_that("order is determined from inputs (#53)", {
  expect_identical(
    select_loc(mtcars, c(starts_with("c"), starts_with("d"))),
    c(cyl = 2L, carb = 11L, disp = 3L, drat = 5L)
  )
  expect_identical(
    select_loc(mtcars, one_of(c("carb", "mpg"))),
    c(carb = 11L, mpg = 1L)
  )
})


test_that("middle (no-match) selector should not clear previous selectors (issue #2275)", {
  cn <- setNames(nm = c("x", "y", "z"))

  expect_equal(
    select_loc(cn, c(contains("x"), contains("foo"), contains("z"))),
    c(x = 1L, z = 3L)
  )
  expect_equal(
    select_loc(cn, c(contains("x"), -contains("foo"), contains("z"))),
    c(x = 1L, z = 3L)
  )
})
