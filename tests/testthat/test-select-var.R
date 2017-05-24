context("select var")

test_that("errors for bad inputs", {
  expect_error(
    select_var(letters, letters),
    "`var` must evaluate to a single number",
    fixed = TRUE
  )

  expect_error(
    select_var(letters, aa),
    "object 'aa' not found",
    fixed = TRUE
  )

  expect_error(
    select_var(letters, 0),
    "`var` must be a value between -26 and 26 (excluding zero), not 0",
    fixed = TRUE
  )
  expect_error(
    select_var(letters, 100),
    "`var` must be a value between -26 and 26 (excluding zero), not 100",
    fixed = TRUE
  )
  expect_error(
    select_var(letters, -Inf),
    "`var` must be a value between -26 and 26 (excluding zero), not NA",
    fixed = TRUE
  )
  expect_error(
    select_var(letters, NA_integer_),
    "`var` must be a value between -26 and 26 (excluding zero), not NA",
    fixed = TRUE
  )
})
