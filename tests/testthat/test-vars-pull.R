context("pull var")

test_that("errors for bad inputs", {
  expect_error(
    vars_pull(letters, letters),
    "`letters` must evaluate to a single number",
    fixed = TRUE
  )

  expect_error(
    vars_pull(letters, aa),
    "object 'aa' not found",
    fixed = TRUE
  )

  expect_error(
    vars_pull(letters, 0),
    "`0` must be a value between -26 and 26 (excluding zero), not 0",
    fixed = TRUE
  )
  expect_error(
    vars_pull(letters, 100),
    "`100` must be a value between -26 and 26 (excluding zero), not 100",
    fixed = TRUE
  )
  expect_error(
    vars_pull(letters, -Inf),
    "`-Inf` must be a value between -26 and 26 (excluding zero), not NA",
    fixed = TRUE
  )
})

test_that("can pull variables with missing elements", {
  expect_identical(vars_pull(c("a", ""), a), "a")
  expect_identical(vars_pull(c("a", NA), a), "a")
})

test_that("missing values are detected in vars_pull() (#72)", {
  lapply(list(NA_character_, NA_integer_, NA_real_, NA, NA_complex_), function(x) {
    expect_error(vars_pull(c("a", "b"), NA_character_), "can't be a missing value")
  })
})
