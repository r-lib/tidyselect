test_that("one_of gives useful errors", {
  expect_snapshot(error = TRUE, cnd_class = TRUE, {
    one_of(1L, .vars = c("x", "y"))
  })
})

test_that("one_of tolerates but warns for unknown columns", {
  vars <- c("x", "y")

  expect_warning(res <- one_of("z", .vars = vars), "Unknown columns: `z`")
  expect_equal(res, integer(0))
  expect_warning(res <- one_of(c("x", "z"), .vars = vars), "Unknown columns: `z`")
  expect_equal(res, 1L)
})

test_that("one_of converts names to locations", {
  expect_equal(one_of("a", "z", .vars = letters), c(1L, 26L))
})

test_that("one_of works with variables", {
  var <- "x"
  expect_equal(select_loc(letters2, one_of(var)), c(x = 24L))
  # error messages from rlang
  expect_error(select_loc(letters2, one_of(`_x`)), "not found")
  expect_error(select_loc(letters2, one_of(`_y`)), "not found")
})

test_that("one_of works when passed variable name matches the column name (#2266)", {
  x <- "x"
  y <- "x"
  expect_equal(select_loc(letters2, one_of(!!x)), c(x = 24L))
  expect_equal(select_loc(letters2, one_of(!!y)), c(x = 24L))
  expect_equal(select_loc(letters2, one_of(y)), c(x = 24L))
})

test_that("one_of() supports S3 vectors", {
  expect_identical(select_loc(letters2, one_of(factor(c("a", "c")))), c(a = 1L, c = 3L))
})

test_that("one_of() compacts inputs (#110)", {
  letters_seq <- set_names(seq_along(letters2), letters2)
  expect_identical(
    select_loc(letters2, -one_of()),
    letters_seq
  )
  expect_identical(
    select_loc(letters2, -one_of(NULL)),
    letters_seq
  )
})

test_that("no set variables throws error", {
  expect_error(one_of("z"), "`one_of()` must be used within a *selecting* function", fixed = TRUE)
})


test_that("no set variables throws error from the correct function", {
  expect_error(one_of(starts_with("z")), "`one_of()` must be used within a *selecting* function", fixed = TRUE)
})
