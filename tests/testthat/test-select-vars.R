context("select vars")

test_that("vars_select can rename variables", {
  vars <- c("a", "b")
  expect_equal(vars_select(vars, b = a, a = b), c("b" = "a", "a" = "b"))
})

test_that("last rename wins", {
  vars <- c("a", "b")

  expect_equal(vars_select(vars, b = a, c = a), c("c" = "a"))
})

test_that("negative index removes values", {
  vars <- letters[1:3]

  expect_equal(vars_select(vars, -c), c(a = "a", b = "b"))
  expect_equal(vars_select(vars, a:c, -c), c(a = "a", b = "b"))
  expect_equal(vars_select(vars, a, b, c, -c), c(a = "a", b = "b"))
  expect_equal(vars_select(vars, -c, a, b), c(a = "a", b = "b"))
})

test_that("can select with character vectors", {
  expect_identical(vars_select(letters, "b", !! "z", c("b", "c")), set_names(c("b", "z", "c")))
})

test_that("abort on unknown columns", {
  expect_error(vars_select(letters, "foo"), "must match column names")
  expect_error(vars_select(letters, c("a", "bar", "foo", "d")), "bar, foo")
})

test_that("symbol overscope is isolated from context", {
  foo <- 10
  expect_error(vars_select(letters, foo), "object 'foo' not found")
  expect_error(vars_select(letters, ((foo))), "object 'foo' not found")
})

test_that("symbol overscope works with parenthesised expressions", {
  expect_identical(vars_select(letters, ((((a)):((w))))), vars_select(letters, a:w))
  expect_identical(vars_select(letters, -((((a)):((y))))), c(z = "z"))
})

test_that("can select with unnamed elements", {
  expect_identical(vars_select(c("a", ""), a), c(a = "a"))
})
