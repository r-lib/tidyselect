

test_that("`all_of()` doesn't fail if `.strict` is FALSE", {
  expect_identical(
    select_loc(letters2, all_of(c("a", "bar", "c")), strict = FALSE),
    c(a = 1L, c = 3L)
  )
})

test_that("`all_of()` and `any_of()` require indices", {
  expect_error(
    select(iris, all_of(is.factor)),
    class = "vctrs_error_subscript_type"
  )
  expect_error(
    select(iris, any_of(is.factor)),
    class = "vctrs_error_subscript_type"
  )
})

test_that("any_of() and all_of() preserve order (#186)", {
  df <- data.frame(x = 1, y = 2)
  expect_identical(select_loc(df, any_of(c("y", "x"))), c(y = 2L, x = 1L))
  expect_identical(select_loc(df, all_of(c("y", "x"))), c(y = 2L, x = 1L))

  df <- data.frame(x = 1, y = 2, z = 3)
  expect_identical(
    select_loc(df, any_of(c("y", "z", "y", "x", "d", "z"))),
    c(y = 2L, z = 3L, x = 1L)
  )
})

test_that("all_of() and any_of() handle named vectors", {
  expect_identical(select_loc(letters2, all_of(c("a", foo = "b"))), c(a = 1L, foo = 2L))
  expect_identical(select_loc(letters2, any_of(c("a", foo = "b", "bar"))), c(a = 1L, foo = 2L))
})

test_that("all_of() is strict", {
  expect_error(select_loc(letters2, all_of(c("a", "foo"))), class = "vctrs_error_subscript_oob")
})

test_that("any_of() is lax", {
  expect_identical(
    select_loc(letters2, any_of(c("a", "foo"))),
    select_loc(letters2, a)
  )
  expect_identical(
    select_loc(letters2, -any_of(c("a", "foo"))),
    select_loc(letters2, -a)
  )
})

test_that("all_of() and any_of() check their inputs", {
  expect_error(select_loc(letters2, all_of(NA)), "missing")
  expect_error(select_loc(letters2, any_of(NA)), "missing")
  expect_error(select_loc(letters2, all_of(na_chr)), "missing")
  expect_error(select_loc(letters2, any_of(na_chr)), "missing")
  expect_error(select_loc(letters2, all_of(TRUE)), class = "vctrs_error_subscript_type")
  expect_error(select_loc(letters2, any_of(TRUE)), class = "vctrs_error_subscript_type")
})
