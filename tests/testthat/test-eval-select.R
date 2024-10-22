test_that("select() is generic", {
  expect_identical(
    select(set_names(letters), b:c),
    c(b = "b", c = "c")
  )
  expect_identical(
    select(as.list(set_names(letters)), b:c),
    list(b = "b", c = "c")
  )
})

test_that("select() supports existing duplicates", {
  x <- list(a = 1, b = 2, a = 3)
  expect_identical(select(x, A = a), list(A = 1, A = 3))
})

test_that("absent `sel` leads to empty selection", {
  expect_identical(select_loc(mtcars), named(int()))
  expect_identical(select_loc(data.frame()), named(int()))
})

test_that("zero-length vector `sel` leads to empty selection (#214)", {
  expect_identical(select_loc(mtcars, character()), named(int()))
  expect_identical(select_loc(data.frame(), character()), named(int()))
})

test_that("can specify inclusion and exclusion", {
  x <- list(a = 1, b = 2, c = 3)
  expect_identical(select_loc(x, int(), include = "b"), c(b = 2L))
  expect_identical(select_loc(x, -int(), exclude = c("a", "c")), c(b = 2L))

  # Can exclude variables that don't exist
  expect_identical(select_loc(x, 2, exclude = "d"), c(b = 2L))
})

test_that("included variables added to front", {
  x <- list(a = 1, b = 2, c = 3)
  expect_named(select_loc(x, "a", include = "b"), c("b", "a"))
  expect_named(select_loc(x, "c", include = "b"), c("b", "c"))

  # but only if not already present
  expect_named(select_loc(x, c("a", "b"), include = "b"), c("a", "b"))
  expect_named(select_loc(x, c("b", "a"), include = "b"), c("b", "a"))

  state <- 0L
  fn <- fn <- function() {
    state <<- state + 1L
    "b"
  }

  select_loc(x, c("a", fn()), include = "b")
  expect_equal(state, 1)
})

test_that("include and exclude validate their inputs", {
  expect_snapshot({
    x <- list(a = 1, b = 2, c = 3)
    (expect_error(select_loc(x, "a", include = 1)))
    (expect_error(select_loc(x, "a", include = "d")))
    (expect_error(select_loc(x, "a", exclude = 1)))
  })
})

test_that("variables are excluded with non-strict `any_of()`", {
  expect_identical(
    select_loc(iris, 1:3, exclude = "foo"),
    select_loc(iris, 1:3)
  )
})

test_that("select_loc() checks inputs", {
  expect_error(select_loc(function() NULL), class = "vctrs_error_scalar_type")
})

test_that("select_loc() accepts name spec", {
  expect_identical(
    select_loc(mtcars, c(foo = c(mpg, cyl)), name_spec = "{outer}_{inner}"),
    c(foo_1 = 1L, foo_2 = 2L)
  )
})

test_that("result is named even with constant inputs (#173)", {
  expect_identical(
    eval_select("Sepal.Width", iris),
    c(Sepal.Width = 2L)
  )
})

test_that("can forbid rename syntax (#178)", {
  expect_snapshot({
    (expect_error(select_loc(mtcars, c(foo = cyl), allow_rename = FALSE)))
    (expect_error(select_loc(mtcars, c(cyl, foo = cyl), allow_rename = FALSE)))
    (expect_error(select_loc(mtcars, c(cyl, foo = mpg), allow_rename = FALSE)))
    (expect_error(select_loc(mtcars, c(foo = mpg, cyl), allow_rename = FALSE)))
  })

  expect_named(select_loc(mtcars, starts_with("c") | all_of("am"), allow_rename = FALSE), c("cyl", "carb", "am"))
})

test_that("can forbid empty selections", {
  expect_snapshot(error = TRUE, {
    select_loc(mtcars, allow_empty = FALSE)
    select_loc(mtcars, integer(), allow_empty = FALSE)
    select_loc(mtcars, starts_with("z"), allow_empty = FALSE)
  })
})

test_that("can forbid empty selections with informative error", {
  expect_snapshot(error = TRUE, {
    select_loc(mtcars, allow_empty = FALSE,  error_arg = "cols")
    select_loc(mtcars, integer(), allow_empty = FALSE, error_arg = "x")
    select_loc(mtcars, starts_with("z"), allow_empty = FALSE, error_arg = "y")
  })
})

test_that("eval_select() errors mention correct calls", {
  f <- function() stop("foo")
  expect_snapshot((expect_error(select_loc(mtcars, f()))))
})

test_that("predicate outputs are type-checked", {
  expect_snapshot({
    (expect_error(select_loc(mtcars, function(x) "")))
  })
})

test_that("eval_select() produces correct backtraces", {
  f <- function(base) g(base)
  g <- function(base) h(base)
  h <- function(base) if (base) stop("foo") else abort("foo")

  local_options(
    rlang_trace_trop_env = current_env(),
    rlang_trace_format_srcrefs = FALSE
  )

  expect_snapshot({
    print(expect_error(select_loc(mtcars, f(base = TRUE))))
    print(expect_error(select_loc(mtcars, f(base = FALSE))))
  })
})

test_that("eval_select() produces correct chained errors", {
  expect_snapshot({
    (expect_error(select_loc(mtcars, 1 + "")))

    f <- function() 1 + ""
    (expect_error(select_loc(mtcars, f())))
  })
})

test_that("can select with predicate when `allow_rename` is `FALSE` (#225)", {
  sel <- eval_select(
    expr(where(is.numeric)),
    mtcars,
    allow_rename = FALSE
  )
  expect_equal(sel, set_names(seq_along(mtcars), names(mtcars)))
})

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

test_that("selecting with predicate + rename doesn't duplicate", {
  x <- list(a = "x", b = "y", c = 1, d = 2)
  expect_equal(select_loc(x, c(where(is.numeric), C = c)), c(C = 3, d = 4))
  expect_equal(select_loc(x, c(where(is.numeric), A = a)), c(c = 3, d = 4, A = 1))
})
