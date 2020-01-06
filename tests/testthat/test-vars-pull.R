context("pull var")

test_that("errors for bad inputs", {
  expect_error(
    vars_pull(letters, letters),
    class = "tidyselect_error_subscript_bad_type"
  )

  # FIXME
  expect_error(
    vars_pull(letters, aa),
    "object 'aa' not found",
    fixed = TRUE
  )
  expect_error(
    vars_pull(letters, "foo"),
    class = "tidyselect_error_subscript_oob_name"
  )

  expect_error(
    vars_pull(letters, 0),
    class = "tidyselect_error_subscript_bad_type"
  )
  expect_error(
    vars_pull(letters, 100),
    class = "tidyselect_error_subscript_oob_location"
  )
  expect_error(
    vars_pull(letters, -100),
    class = "tidyselect_error_subscript_oob_location"
  )
  expect_error(
    vars_pull(letters, -Inf),
    class = "tidyselect_error_subscript_bad_type"
  )

  expect_error(
    vars_pull(letters, TRUE),
    class = "tidyselect_error_subscript_bad_type"
  )
  expect_error(
    vars_pull(letters, NA),
    class = "tidyselect_error_subscript_bad_type"
  )
  expect_error(
    vars_pull(letters, na_int),
    class = "tidyselect_error_subscript_bad_type"
  )

  expect_error(
    vars_pull(letters, !!c("a", "b")),
    class = "tidyselect_error_subscript_bad_type"
  )

  verify_output(test_path("outputs", "vars-pull-input-checking.txt"), {
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
    expect_error(vars_pull(c("a", "b"), !!x), class = "tidyselect_error_subscript_bad_type")
  })
})

test_that("can pull with strings", {
  expect_identical(vars_pull(letters, "b"), vars_pull(letters, b))
  expect_error(vars_pull(letters, "foo"), class = "tidyselect_error_subscript_oob_name")
})

test_that("can pull with negative values", {
  expect_identical(vars_pull(letters, -1), "z")
  expect_identical(vars_pull(letters, -3), "x")
})
