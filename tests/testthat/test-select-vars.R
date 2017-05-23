context("select_vars()")

test_that("select_vars can rename variables", {
  vars <- c("a", "b")
  expect_equal(select_vars(vars, b = a, a = b), c("b" = "a", "a" = "b"))
})

test_that("last rename wins", {
  vars <- c("a", "b")

  expect_equal(select_vars(vars, b = a, c = a), c("c" = "a"))
})

test_that("negative index removes values", {
  vars <- letters[1:3]

  expect_equal(select_vars(vars, -c), c(a = "a", b = "b"))
  expect_equal(select_vars(vars, a:c, -c), c(a = "a", b = "b"))
  expect_equal(select_vars(vars, a, b, c, -c), c(a = "a", b = "b"))
  expect_equal(select_vars(vars, -c, a, b), c(a = "a", b = "b"))
})

test_that("can select with character vectors", {
  expect_identical(select_vars(letters, "b", !! "z", c("b", "c")), set_names(c("b", "z", "c")))
})

test_that("abort on unknown columns", {
  expect_error(select_vars(letters, "foo"), "must match column names")
  expect_error(select_vars(letters, c("a", "bar", "foo", "d")), "bar, foo")
})
