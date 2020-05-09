
test_that("where() selects with a predicate", {
  expect_identical(select_loc(iris, where(is.factor)), c(Species = 5L))
  expect_identical(select_loc(iris, where(~ is.factor(.x))), c(Species = 5L))
})

test_that("where() checks return values", {
  expect_error(select_loc(iris, where(~ NA)), "return `TRUE` or `FALSE`")
})
