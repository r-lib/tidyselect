test_that("`all_of()` fails even if `.strict` is FALSE", {
  expect_snapshot(
    error = TRUE,
    select_loc(letters2, all_of(c("a", "bar", "c")), strict = FALSE)
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
  expect_snapshot({
    (expect_error(select_loc(letters2, all_of(NA))))
    (expect_error(select_loc(letters2, any_of(NA))))

    (expect_error(select_loc(letters2, all_of(TRUE))))
    (expect_error(select_loc(letters2, any_of(TRUE))))

    (expect_error(select_loc(letters2, any_of(is.factor))))
    (expect_error(select_loc(letters2, all_of(is.factor))))
  })
})

test_that("any_of() and all_off() error out of context (#269)", {
  expect_snapshot({
    (expect_error(all_of()))
    (expect_error(any_of()))
  })
})

test_that("any_of generates informative error if ... not empty", {
  local_vars(letters)

  expect_snapshot(error = TRUE, {
    any_of("b", "c", "d")
  })
})

test_that("all_of() returns an integer vector", {
  with_vars(
    letters,
    expect_equal(all_of(c("b", "c", "d")), 2:4)
  )
})
