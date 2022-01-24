test_that("errors for bad inputs", {
  expect_error(
    vars_pull(letters, letters),
    class = "vctrs_error_subscript_type"
  )

  # FIXME
  expect_error(
    vars_pull(letters, aa),
    "object 'aa' not found",
    fixed = TRUE
  )
  expect_error(
    vars_pull(letters, "foo"),
    class = "vctrs_error_subscript_oob"
  )

  expect_error(
    vars_pull(letters, 0),
    class = "vctrs_error_subscript_type"
  )
  expect_error(
    vars_pull(letters, 100),
    class = "vctrs_error_subscript_oob"
  )
  expect_error(
    vars_pull(letters, -100),
    class = "vctrs_error_subscript_oob"
  )
  expect_error(
    vars_pull(letters, -Inf),
    class = "vctrs_error_subscript_type"
  )

  expect_error(
    vars_pull(letters, TRUE),
    class = "vctrs_error_subscript_type"
  )
  expect_error(
    vars_pull(letters, NA),
    class = "vctrs_error_subscript_type"
  )
  expect_error(
    vars_pull(letters, na_int),
    class = "vctrs_error_subscript_type"
  )

  expect_error(
    vars_pull(letters, !!c("a", "b")),
    class = "vctrs_error_subscript_type"
  )

  expect_snapshot(error = TRUE, {
    vars_pull(letters, letters)
    vars_pull(letters, aa)
    vars_pull(letters, 0)
    vars_pull(letters, 100)
    vars_pull(letters, -100)
    vars_pull(letters, -Inf)
    vars_pull(letters, TRUE)
    vars_pull(letters, NA)
    vars_pull(letters, na_int)
    vars_pull(letters, "foo")
    vars_pull(letters, !!c("a", "b"))
  })
})

test_that("can pull variables with missing elements", {
  expect_identical(vars_pull(c("a", ""), a), "a")
  expect_identical(vars_pull(c("a", NA), a), "a")
})

test_that("missing values are detected in vars_pull() (#72)", {
  lapply(list(NA_character_, NA_integer_, NA_real_, NA, NA_complex_), function(x) {
    expect_error(vars_pull(c("a", "b"), !!x), class = "vctrs_error_subscript_type")
  })
})

test_that("can pull with strings", {
  expect_identical(vars_pull(letters, "b"), vars_pull(letters, b))
  expect_error(vars_pull(letters, "foo"), class = "vctrs_error_subscript_oob")
})

test_that("can pull with negative values", {
  expect_identical(vars_pull(letters, -1), "z")
  expect_identical(vars_pull(letters, -3), "x")
})

test_that("vars_pull() has informative errors", {
  expect_snapshot({
    "# vars_pull() instruments base errors"
    (expect_error(vars_pull(letters, foobar), ""))
  })
})

test_that("vars_pull() errors mention correct calls", {
  f <- function() stop("foo")
  expect_snapshot((expect_error(vars_pull(letters, f()))))
})

test_that("vars_pull() produces correct backtraces", {
  f <- function(base) g(base)
  g <- function(base) h(base)
  h <- function(base) if (base) stop("foo") else abort("foo")

  local_options(
    rlang_trace_trop_env = current_env(),
    rlang_trace_format_srcrefs = FALSE
  )

  expect_snapshot({
    print(expect_error(vars_pull(letters, f(base = TRUE))))
    print(expect_error(vars_pull(letters, f(base = FALSE))))
  })
})
