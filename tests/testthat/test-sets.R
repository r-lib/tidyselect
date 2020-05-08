
test_that("`sel_union()` matches named elements", {
  expect_identical(sel_union(1L, c(foo = 1L)), c(foo = 1L))
  expect_identical(sel_union(named(1L), c(foo = 1L)), c(foo = 1L))
  expect_identical(sel_union(c(foo = 1L), 1L), c(foo = 1L))
  expect_identical(sel_union(c(foo = 1L), named(1L)), c(foo = 1L))

  expect_identical(sel_union(named(c(1L, 2L, 1L)), c(foo = 1L, 1L)), c(foo = 1L, 2L))
})

test_that("`sel_diff()` matches named elements", {
  expect_identical(sel_diff(named(1L), named(1L)), named(int()))
  expect_identical(sel_diff(named(1L), c(foo = 1L)), named(int()))
  expect_identical(sel_diff(named(1L), c(foo = 1L, bar = 1L)), named(int()))

  expect_identical(sel_diff(c(foo = 1L), named(1L)), named(int()))
  expect_identical(sel_diff(c(foo = 1L), c(foo = 1L)), named(int()))
  expect_identical(sel_diff(c(foo = 1L), c(bar = 1L)), c(foo = 1L))

  expect_identical(sel_diff(c(foo = 1L), c(bar = 1L)), c(foo = 1L))
})

test_that("sel_intersect() matches named elements", {
  expect_identical(sel_intersect(1L, c(foo = 1L)), c(foo = 1L))
  expect_identical(sel_intersect(c(foo = 1L), 1L), c(foo = 1L))
  expect_identical(sel_intersect(c(foo = 1L), c(bar = 1L)), named(int()))
})

test_that("sel_unique() returns unique elements", {
  expect_identical(sel_unique(c(1L, foo = 1L, bar = 1L)), c(foo = 1L, bar = 1L))
})

test_that("unique elements are returned", {
  expect_identical(sel_union(c(1L, 1L), 2L), c(1L, 2L))
  expect_identical(sel_diff(c(1L, 1L), 2L), 1L)
  expect_identical(sel_intersect(c(foo = 1L), c(foo = 1L, foo = 1L)), c(foo = 1L))
})

test_that("order is preserved", {
  expect_identical(sel_union(c(1L, bar = 1L), c(1L, foo = 1L)), c(bar = 1L, foo = 1L))
  expect_identical(sel_union(c(1L, foo = 1L), c(1L, bar = 1L)), c(foo = 1L, bar = 1L))
  expect_identical(sel_union(c(1L, foo = 1L), c(1L, foo = 1L)), c(foo = 1L))

  expect_identical(sel_intersect(c(1L, foo = 1L, bar = 1L), c(1L, bar = 1L, foo = 1L)), c(foo = 1L, bar = 1L))
  expect_identical(sel_intersect(c(1L, bar = 1L, foo = 1L), c(1L, foo = 1L, bar = 1L)), c(bar = 1L, foo = 1L))

  expect_identical(sel_diff(c(1L, foo = 1L, bar = 1L), c(1L, bar = 1L)), c(foo = 1L))
  expect_identical(sel_diff(c(1L, bar = 1L, foo = 1L), c(1L, foo = 1L)), c(bar = 1L))
})

