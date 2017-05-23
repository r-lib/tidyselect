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


# combine_vars ------------------------------------------------------------
# This is the low C++ function which works on integer indices

test_that("empty index gives empty output", {
  vars <- combine_vars(letters, list())
  expect_equal(length(vars), 0)

  vars <- combine_vars(letters, list(numeric()))
  expect_equal(length(vars), 0)
})

test_that("positive indexes kept", {
  expect_equal(combine_vars(letters, list(1)), c(a = 1))
  expect_equal(combine_vars(letters, list(1, 26)), c(a = 1, z = 26))
  expect_equal(combine_vars(letters, list(c(1, 26))), c(a = 1, z = 26))
})

test_that("indexes returned in order they appear", {
  expect_equal(combine_vars(letters, list(26, 1)), c(z = 26, a = 1))
})


test_that("negative index in first position includes all others", {
  vars <- combine_vars(letters[1:3], list(-1))
  expect_equal(vars, c(b = 2, c = 3))
})

test_that("named inputs rename outputs", {
  expect_equal(combine_vars(letters[1:3], list(d = 1)), c(d = 1))
  expect_equal(combine_vars(letters[1:3], list(c(d = 1))), c(d = 1))
})

test_that("if multiple names, last kept", {
  expect_equal(combine_vars(letters[1:3], list(d = 1, e = 1)), c(e = 1))
  expect_equal(combine_vars(letters[1:3], list(c(d = 1, e = 1))), c(e = 1))
})

test_that("if one name for multiple vars, use integer index", {
  expect_equal(combine_vars(letters[1:3], list(x = 1:3)), c(x1 = 1, x2 = 2, x3 = 3))
})

test_that("invalid inputs raise error", {
  expect_error(
    combine_vars(names(mtcars), list(0)),
    "Each argument must yield either positive or negative integers",
    fixed = TRUE
  )
  expect_error(
    combine_vars(names(mtcars), list(c(-1, 1))),
    "Each argument must yield either positive or negative integers",
    fixed = TRUE
  )
  expect_error(
    combine_vars(names(mtcars), list(12)),
    "Position must be between 0 and n",
    fixed = TRUE
  )
})
