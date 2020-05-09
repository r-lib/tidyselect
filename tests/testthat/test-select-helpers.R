
test_that("no set variables throws error", {
  expect_error(starts_with("z"), "`starts_with()` must be used within a *selecting* function", fixed = TRUE)
  expect_error(one_of("z"), "`one_of()` must be used within a *selecting* function", fixed = TRUE)
})

test_that("no set variables throws error from the correct function", {
  expect_error(one_of(starts_with("z")), "`one_of()` must be used within a *selecting* function", fixed = TRUE)
})

test_that("generic error message is thrown if `fn` is not supplied", {
  expect_error(peek_vars(), "Selection helpers must be used")
})

test_that("custom error message is thrown if `fn` is supplied", {
  expect_error(peek_vars(fn = "z"), "`z()` must be used", fixed = TRUE)
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


# one_of ------------------------------------------------------------------

test_that("one_of gives useful errors", {
  expect_error(
    one_of(1L, .vars = c("x", "y")),
    "Input 1 must be a vector of column names, not an integer vector",
    fixed = TRUE,
    class = "vctrs_error_incompatible_index_type"
  )
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


# first-selector ----------------------------------------------------------

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

test_that("last_col() selects last argument with offset", {
  vars <- letters[1:3]
  expect_identical(last_col(0, vars), 3L)
  expect_identical(last_col(2, vars), 1L)

  expect_error(last_col(3, vars), "`offset` must be smaller than the number of columns")
  expect_error(last_col(vars = chr()), "Can't select last column when input is empty")
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
