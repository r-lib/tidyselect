test_that("no set variables throws error", {
  expect_error(starts_with("z"), "`starts_with()` must be used within a *selecting* function", fixed = TRUE)
})

test_that("failed match removes all columns", {
  local_vars(c("x", "y"))

  expect_equal(starts_with("z"), integer(0))
  expect_equal(ends_with("z"), integer(0))
  expect_equal(contains("z"), integer(0))
  expect_equal(matches("z"), integer(0))
  expect_equal(num_range("z", 1:3), integer(0))
})

test_that("matches return integer locations", {
  local_vars(c("abc", "acd", "bbc", "bbd", "eee"))

  expect_equal(starts_with("a"), c(1L, 2L))
  expect_equal(ends_with("d"),   c(2L, 4L))
  expect_equal(contains("eee"),  5L)
  expect_equal(matches(".b."),   c(1L, 3L, 4L))
  expect_equal(matches("(?<!a)b", perl = TRUE), c(3L, 4L))
})

test_that("throws with empty pattern is provided", {
  # error messages from rlang
  expect_error(starts_with(""))
  expect_error(ends_with(""))
  expect_error(contains(""))
  expect_error(matches(""))
})

test_that("can use a variable", {
  vars <- "x"
  names(vars) <- vars

  expect_equal(select_loc(vars, starts_with(vars)), c(x = 1L))
  expect_equal(select_loc(vars, ends_with(vars)), c(x = 1L))
  expect_equal(select_loc(vars, contains(vars)), c(x = 1L))
  expect_equal(select_loc(vars, matches(vars)), c(x = 1L))
})

test_that("can use a variable even if it exists in the data (#2266)", {
  vars <- c("x", "y")
  names(vars) <- vars

  y <- "x"
  expected_result <- c(x = 1L)

  expect_equal(select_loc(vars, starts_with(y)), expected_result)
  expect_equal(select_loc(vars, ends_with(y)), expected_result)
  expect_equal(select_loc(vars, contains(y)), expected_result)
  expect_equal(select_loc(vars, matches(y)), expected_result)
})

test_that("num_range selects numeric ranges", {
  vars <- c("x1", "x2", "x01", "x02", "x10", "x11")
  names(vars) <- vars

  expect_equal(select_loc(vars, num_range("x", 1:2)), c(x1 = 1L, x2 = 2L))
  expect_equal(select_loc(vars, num_range("x", 1:2, width = 2)), c(x01 = 3L, x02 = 4L))
  expect_equal(select_loc(vars, num_range("x", 10:11)), c(x10 = 5L, x11 = 6L))
  expect_equal(select_loc(vars, num_range("x", 10:11, width = 2)), c(x10 = 5L, x11 = 6L))
})

test_that("num_range can use a suffix (#229)", {
  vars <- set_names(c("x1", "x2", "x1_y", "x2_y"))
  expect_named(select_loc(vars, num_range("x", 1:2, "_y")), c("x1_y", "x2_y"))
})

test_that("num_range recycles with tidyverse rules (#355)", {
  vars <- set_names(c("x1", "y1", "y2", "x2", "x3"))
  expect_snapshot(
    error = TRUE,
    select_loc(vars, num_range(c("x", "y"), 1:3)),
  )
  expect_named(
    select_loc(vars, num_range(c("x", "y"), 1:2)),
    c("x1", "y2")
  )

  vars <- set_names(c("x1_foo", "y1_bar", "y1_foo", "x2_bar", "x3_bar", "y2_bar"))
  expect_named(
    select_loc(vars, num_range(c("x", "y"), 1:2, "_foo")),
    "x1_foo"
  )
  expect_named(
    select_loc(vars, num_range(c("x", "y"), 1:2, c("_foo", "_bar"))),
    c("x1_foo", "y2_bar")
  )
  expect_snapshot(
    error = TRUE,
    select_loc(vars, num_range(c("x", "y"), 1:2, c("_foo", "_bar", "_baz"))),
  )
})

test_that("num_range crosses ranges with prefixes and suffixes if requested (#355)", {
  vars <- set_names(c("x1", "y1", "y2", "x2", "x3"))
  expect_named(
    select_loc(vars, num_range(c("x", "y"), 1:3, cross = TRUE)),
    c("x1", "x2", "x3", "y1", "y2")
  )

  vars <- set_names(c("x1_foo", "y1_bar", "y1_foo", "x2_bar", "x3_bar", "y2_bar"))
  expect_named(
    select_loc(vars, num_range(c("x", "y"), 1:3, "_foo", cross = TRUE)),
    c("x1_foo", "y1_foo")
  )
  expect_named(
    select_loc(vars, num_range(c("x", "y"), 1:3, c("_foo", "_bar"), cross = TRUE)),
    c("x1_foo", "x2_bar", "x3_bar", "y1_foo", "y1_bar", "y2_bar")
  )
})

test_that("matchers accept length > 1 vectors (#50)", {
  expect_identical(
    select_loc(iris, starts_with(c("Sep", "Petal"))),
    select_loc(iris, starts_with("Sep") | starts_with("Petal"))
  )
  expect_identical(
    select_loc(iris, ends_with(c("gth", "Width"))),
    select_loc(iris, ends_with("gth") | ends_with("Width"))
  )
  expect_identical(
    select_loc(iris, contains(c("epal", "eta"))),
    select_loc(iris, contains("epal") | contains("eta")),
  )
  expect_identical(
    select_loc(iris, matches(c("epal", "eta"))),
    select_loc(iris, matches("epal") | contains("eta")),
  )
})


test_that("initial (single) selector defaults correctly (issue #2275)", {
  cn <- setNames(nm = c("x", "y", "z"))

  ### Single Column Selected

  # single columns (present), explicit
  expect_equal(select_loc(cn, x), c(x = 1L))
  expect_equal(select_loc(cn, -x), c(y = 2L, z = 3L))

  # single columns (present), matched
  expect_equal(select_loc(cn, contains("x")), c(x = 1L))
  expect_equal(select_loc(cn, -contains("x")), c(y = 2L, z = 3L))

  # single columns (not present), explicit
  expect_error(select_loc(cn, foo), class = "vctrs_error_subscript_oob")
  expect_error(select_loc(cn, -foo), class = "vctrs_error_subscript_oob")

  # single columns (not present), matched
  expect_equal(select_loc(cn, contains("foo")), named(int()))
  expect_equal(select_loc(cn, -contains("foo")), set_names(seq_along(cn), cn))
})

test_that("initial (of multiple) selectors default correctly (issue #2275)", {
  cn <- setNames(nm = c("x", "y", "z"))

  ### Multiple Columns Selected

  # explicit(present) + matched(present)
  expect_equal(select_loc(cn, c(x, contains("y"))), c(x = 1L, y = 2L))
  expect_equal(select_loc(cn, c(x, -contains("y"))), c(x = 1L))
  expect_equal(select_loc(cn, c(-x, contains("y"))), c(y = 2L, z = 3L))
  expect_equal(select_loc(cn, c(-x, -contains("y"))), c(z = 3L))

  # explicit(present) + matched(not present)
  expect_equal(select_loc(cn, c(x, contains("foo"))), c(x = 1L))
  expect_equal(select_loc(cn, c(x, -contains("foo"))), c(x = 1L))
  expect_equal(select_loc(cn, c(-x, contains("foo"))), c(y = 2L, z = 3L))
  expect_equal(select_loc(cn, c(-x, -contains("foo"))), c(y = 2L, z = 3L))

  # matched(present) + explicit(present)
  expect_equal(select_loc(cn, c(contains("x"), y)), c(x = 1L, y = 2L))
  expect_equal(select_loc(cn, c(contains("x"), -y)), c(x = 1L))
  expect_equal(select_loc(cn, c(-contains("x"), y)), c(y = 2L, z = 3L))
  expect_equal(select_loc(cn, c(-contains("x"), -y)), c(z = 3L))

  # matched(not present) + explicit(not present)
  expect_error(select_loc(cn, c(contains("foo"), bar)), class = "vctrs_error_subscript_oob")
  expect_error(select_loc(cn, c(contains("foo"), -bar)), class = "vctrs_error_subscript_oob")
  expect_error(select_loc(cn, c(-contains("foo"), bar)), class = "vctrs_error_subscript_oob")
  expect_error(select_loc(cn, c(-contains("foo"), -bar)), class = "vctrs_error_subscript_oob")

  # matched(present) + matched(present)
  expect_equal(select_loc(cn, c(contains("x"), contains("y"))), c(x = 1L, y = 2L))
  expect_equal(select_loc(cn, c(contains("x"), -contains("y"))), c(x = 1L))
  expect_equal(select_loc(cn, c(-contains("x"), contains("y"))), c(y = 2L, z = 3L))
  expect_equal(select_loc(cn, c(-contains("x"), -contains("y"))), c(z = 3L))

  # matched(present) + matched(not present)
  expect_equal(select_loc(cn, c(contains("x"), contains("foo"))), c(x = 1L))
  expect_equal(select_loc(cn, c(contains("x"), -contains("foo"))), c(x = 1L))
  expect_equal(select_loc(cn, c(-contains("x"), contains("foo"))), c(y = 2L, z = 3L))
  expect_equal(select_loc(cn, c(-contains("x"), -contains("foo"))), c(y = 2L, z = 3L))

  # matched(not present) + matched(present)
  expect_equal(select_loc(cn, c(contains("foo"), contains("x"))), c(x = 1L))
  expect_equal(select_loc(cn, c(contains("foo"), -contains("x"))), named(int()))
  expect_equal(select_loc(cn, c(-contains("foo"), contains("x"))), c(x = 1L, y = 2L, z = 3L))
  expect_equal(select_loc(cn, c(-contains("foo"), -contains("x"))), c(y = 2L, z = 3L))

  # matched(not present) + matched(not present)
  expect_equal(select_loc(cn, c(contains("foo"), contains("bar"))), named(int()))
  expect_equal(select_loc(cn, c(contains("foo"), -contains("bar"))), named(int()))
  expect_equal(select_loc(cn, c(-contains("foo"), contains("bar"))), c(x = 1L, y = 2L, z = 3L))
  expect_equal(select_loc(cn, c(-contains("foo"), -contains("bar"))), c(x = 1L, y = 2L, z = 3L))
})

test_that("matches() can use stringr patterns", {
  local_vars(c(".", "x", "X"))

  expect_equal(matches(stringr::fixed(".")), 1)
  expect_equal(matches(stringr::coll("x", ignore_case = TRUE)), c(2, 3))
})

test_that("matches() complains about bad stringr pattern usage", {
  local_vars(c("x", "y"))

  expect_snapshot(error = TRUE, {
    matches(stringr::fixed("a"), perl = TRUE)
    matches(stringr::fixed("a"), ignore.case = TRUE)
    matches(stringr::fixed(c("a", "b")))
  })
})

test_that("can supply named vectors to pattern helpers (#250)", {
  exp <- c(cyl = 2L, carb = 11L)

  expect_equal(
    select_loc(mtcars, matches(c(foo = "^c"))),
    exp
  )

  expect_equal(
    select_loc(mtcars, starts_with(c(foo = "c"))),
    exp
  )

  expect_equal(
    select_loc(mtcars, ends_with(c(foo = "l", bar = "b"))),
    exp
  )

  expect_equal(
    select_loc(mtcars, contains(c(foo = "yl", bar = "rb"))),
    exp
  )
})
