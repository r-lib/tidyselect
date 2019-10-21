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
