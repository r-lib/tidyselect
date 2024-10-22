test_that("`before` and `after` relocates the selection", {
  x <- list(x = 1, a = "a", y = 2, b = "a")

  expect_identical(
    relocate_loc(x, x, after = y),
    c(a = 2L, y = 3L, x = 1L, b = 4L)
  )
  expect_identical(
    relocate_loc(x, y, before = x),
    c(y = 3L, x = 1L, a = 2L, b = 4L)
  )
  expect_identical(
    relocate_loc(x, where(is.character), before = x),
    c(a = 2L, b = 4L, x = 1L, y = 3L)
  )
})

test_that("works with `before` and `after` `everything()`", {
  x <- c(w = 1, x = 2, y = 3, z = 4)

  expect_identical(
    relocate_loc(x, c(y, z), before = everything()),
    c(y = 3L, z = 4L, w = 1L, x = 2L)
  )
  expect_identical(
    relocate_loc(x, c(y, z), after = everything()),
    c(w = 1L, x = 2L, y = 3L, z = 4L)
  )
})

test_that("moves columns to the front when neither `before` nor `after` are specified", {
  x <- c(x = 1, y = 2, z = 3)

  expect_identical(
    relocate_loc(x, c(z, y)),
    c(z = 3L, y = 2L, x = 1L)
  )
})

test_that("empty `before` selection moves columns to front", {
  x <- c(x = 1, y = 2, z = 3)

  expect_identical(
    relocate_loc(x, y, before = where(is.character)),
    c(y = 2L, x = 1L, z = 3L)
  )
})

test_that("empty `after` selection moves columns to end", {
  x <- c(x = 1, y = 2, z = 3)

  expect_identical(
    relocate_loc(x, y, after = where(is.character)),
    c(x = 1L, z = 3L, y = 2L)
  )
})

test_that("minimum of the `before` selection is used", {
  x <- c(a = 1, b = 1, c = 1, d = 1, e = 1)
  expect_named(relocate_loc(x, e, before = c(b, d)), c("a", "e", "b", "c", "d"))
})

test_that("maximum of the `after` selection is used", {
  x <- c(a = 1, b = 1, c = 1, d = 1, e = 1)
  expect_named(relocate_loc(x, b, after = c(a, c, e)), c("a", "c", "d", "e", "b"))
})

test_that("works with zero column data frames (tidyverse/dplyr#6167)", {
  expect_identical(relocate_loc(data.frame(), any_of("b")), named(int()))
  expect_identical(relocate_loc(data.frame(), any_of("b"), before = where(is.character)), named(int()))
  expect_identical(relocate_loc(data.frame(), any_of("b"), after = where(is.character)), named(int()))
})

test_that("retains the last duplicate when renaming while moving (tidyverse/dplyr#6209)", {
  # To enforce the invariant that relocating can't change the number of columns
  x <- c(x = 1)
  expect_identical(
    relocate_loc(x, c(a = x, b = x)),
    c(b = 1L)
  )

  x <- c(x = 1, y = 2)
  expect_identical(
    relocate_loc(x, c(a = x, b = y, c = x)),
    c(b = 2L, c = 1L)
  )
})

test_that("respects order specified by `...` (tidyverse/dplyr#5328)", {
  x <- c(a = 1, x = 1, b = 1, z = 1, y = 1)

  expect_named(
    relocate_loc(x, c(x, y, z), before = x),
    c("a", "x", "y", "z", "b")
  )
  expect_named(
    relocate_loc(x, c(x, y, z), after = last_col()),
    c("a", "b", "x", "y", "z")
  )
  expect_named(
    relocate_loc(x, c(x, a, z)),
    c("x", "a", "z", "b", "y")
  )
})

test_that("allows for renaming (tidyverse/dplyr#5569)", {
  x <- c(a = 1, b = 1, c = 1)

  expect_named(
    relocate_loc(x, c(new = b)),
    c("new", "a", "c")
  )
  expect_named(
    relocate_loc(x, c(new = b), after = c),
    c("a", "c", "new")
  )
})

test_that("can't supply both `before` and `after`", {
  expect_snapshot(error = TRUE, {
    relocate_loc(c(x = 1), before = 1, after = 1)
  })
  expect_snapshot(error = TRUE, {
    relocate_loc(c(x = 1), before = 1, after = 1, before_arg = ".before", after_arg = ".after")
  })
})

test_that("can't relocate with out-of-bounds variables by default", {
  x <- c(a = 1, b = 2)

  expect_snapshot({
    (expect_error(relocate_loc(x, c)))
    (expect_error(relocate_loc(x, c(1, 3))))
    (expect_error(relocate_loc(x, a, before = c)))
    (expect_error(relocate_loc(x, a, after = c)))
  })
})

test_that("can relocate with out-of-bounds variables in `expr` if `strict = FALSE`", {
  x <- c(a = 1, b = 2)

  expect_identical(relocate_loc(x, c, strict = FALSE), c(a = 1L, b = 2L))
  expect_identical(relocate_loc(x, c(d = b, e = c), strict = FALSE), c(d = 2L, a = 1L))

  # But still not with OOB variables in `before` or `after`
  expect_snapshot({
    (expect_error(relocate_loc(x, a, before = c, strict = FALSE)))
    (expect_error(relocate_loc(x, a, after = c, strict = FALSE)))
  })
})

test_that("accepts name spec", {
  x <- c(a = 1, b = 2, c = 3)

  expect_identical(
    relocate_loc(x, c(foo = c(c, a)), name_spec = "{outer}_{inner}"),
    c(foo_1 = 3L, foo_2 = 1L, b = 2L)
  )
  expect_identical(
    relocate_loc(x, c(foo = c(bar = c, baz = a)), name_spec = "{outer}_{inner}"),
    c(foo_bar = 3L, foo_baz = 1L, b = 2L)
  )
})

test_that("can forbid rename syntax", {
  x <- c(a = 1, b = 2, c = 3)

  expect_snapshot({
    (expect_error(relocate_loc(x, c(foo = b), allow_rename = FALSE)))
    (expect_error(relocate_loc(x, c(b, foo = b), allow_rename = FALSE)))
  })

  expect_named(relocate_loc(x, c(c, b), allow_rename = FALSE), c("c", "b", "a"))
})

test_that("can forbid empty selections", {
  x <- c(a = 1, b = 2, c = 3)

  expect_snapshot({
    (expect_error(relocate_loc(x, allow_empty = FALSE)))
    (expect_error(relocate_loc(mtcars, integer(), allow_empty = FALSE)))
    (expect_error(relocate_loc(mtcars, starts_with("z"), allow_empty = FALSE)))
  })
})

test_that("can forbid empty selections", {
  x <- c(a = 1, b = 2, c = 3)
  
  expect_snapshot(
    error = TRUE, {
    relocate_loc(mtcars, before = integer(), allow_empty = FALSE)
    relocate_loc(mtcars, starts_with("z"), allow_empty = FALSE)
  }, cnd_class = TRUE)
})


test_that("`before` and `after` forbid renaming", {
  x <- c(a = 1, b = 2, c = 3)

  expect_snapshot({
    (expect_error(relocate_loc(x, b, before = c(new = c))))
    (expect_error(relocate_loc(x, b, before = c(new = c), before_arg = ".before")))

    (expect_error(relocate_loc(x, b, after = c(new = c))))
    (expect_error(relocate_loc(x, b, after = c(new = c), after_arg = ".after")))
  })
})
