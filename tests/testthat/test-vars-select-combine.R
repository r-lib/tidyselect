context("vars-select-combine")

# This is the low C++ function which works on integer indices

test_that("empty index gives empty output", {
  vars <- inds_combine(letters, list())
  expect_equal(length(vars), 0)

  vars <- inds_combine(letters, list(numeric()))
  expect_equal(length(vars), 0)
})

test_that("positive indexes kept", {
  expect_equal(inds_combine(letters, list(1)), c(a = 1))
  expect_equal(inds_combine(letters, list(1, 26)), c(a = 1, z = 26))
  expect_equal(inds_combine(letters, list(c(1, 26))), c(a = 1, z = 26))
})

test_that("indexes returned in order they appear", {
  expect_equal(inds_combine(letters, list(26, 1)), c(z = 26, a = 1))
})


test_that("negative index in first position includes all others", {
  expect_equal(inds_combine(letters[1:3], list(-1)), c(b = 2, c = 3))
})

test_that("named inputs rename outputs", {
  expect_equal(inds_combine(letters[1:3], list(d = 1)), c(d = 1))
  expect_equal(inds_combine(letters[1:3], list(c(d = 1))), c(d = 1))
})

test_that("if multiple names, last kept", {
  expect_equal(
    expect_warning(
      inds_combine(letters[1:3], list(d = 1, e = 1)),
      "single choice"
    ),
    c(e = 1)
  )
  expect_equal(
    expect_warning(
      inds_combine(letters[1:3], list(c(d = 1, e = 1))),
      "single choice"
    ),
    c(e = 1)
  )

  wrn <- catch_cnd(inds_combine(letters[1:3], list(d = 1, e = 1)))
  expect_is(wrn, "tidyselect_warning_duplicate_renaming")
  expect_identical(wrn$var, c(d = 1L, e = 1L))
})

test_that("combine names if one name for multiple vars", {
  expect_identical(
    inds_combine(letters[1:3], list(x = 1:3)),
    c(x1 = 1L, x2 = 2L, x3 = 3L)
  )
})

test_that("select(0) corner case #82", {
  expect_equal(inds_combine(names(mtcars), 0), set_names(integer(), character()))
  expect_equal(
    inds_combine(names(mtcars), list(0, 1:3)),
    inds_combine(names(mtcars), list(1:3))
  )
  expect_equal(
    inds_combine(names(mtcars), list(0, -(1:3))),
    inds_combine(names(mtcars), list(integer(), -(1:3)))
  )
})

test_that("invalid inputs raise error", {
  expect_error(
    inds_combine(names(mtcars), list(12, 30, 50)),
    class = "tidyselect_error_index_oob_positions"
  )
})

test_that("can mix negative and positive indices", {
  # Start with negative
  expect_identical(
    inds_combine(letters[1:3], list(c(-1, 1))),
    c(b = 2L, c = 3L)
  )
  # Start with positive
  expect_identical(
    inds_combine(letters[1:3], list(c(1, -1))),
    set_names(integer(), character())
  )
})
