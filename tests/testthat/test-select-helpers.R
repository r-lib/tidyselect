context("select helpers")

test_that("no set variables throws error", {
  expect_error(starts_with("z"), "`starts_with()` must be used within a *selecting* function", fixed = TRUE)
  expect_error(one_of("z"), "`one_of()` must be used within a *selecting* function", fixed = TRUE)
})

test_that("no set variables throws error from the correct function", {
  expect_error(one_of(starts_with("z")), "`starts_with()` must be used within a *selecting* function", fixed = TRUE)
})


# ZNK 2019-07-08: This is a weird situation where a NULL input gets peek_vars()
# to get its caller. The problem with this is that testthat wraps everything in
# the test environment, so peek_vars() then returns the error message
# `eval()` must be used within a *selecting* function.... which doesn't really
# make a whole lot of sense ಠ_ಠ
#
# These next two tests do two things to actually test the path of the code:
#
# 1. test if the first part of the call is not a symbol
# 2. test if fn is equal to `peek_vars`, which would happen in a
#    global environment setting.
test_that("if the parent call is not a symbol, then return generic", {
  pv <- function() function() peek_vars()
  expect_error(pv()(), "No tidyselect variables were registered.")
})

test_that("if the fn is peek_vars, then return generic", {
  expect_error(peek_vars('peek_vars'), "`peek_vars()` must be used within a *selecting* function", fixed = TRUE)
})


test_that("peek_vars can take a custom function name", {
  expect_error(peek_vars("z"), "`z()` must be used", fixed = TRUE)
})

test_that("failed match removes all columns", {
  scoped_vars(c("x", "y"))

  expect_equal(starts_with("z"), integer(0))
  expect_equal(ends_with("z"), integer(0))
  expect_equal(contains("z"), integer(0))
  expect_equal(matches("z"), integer(0))
  expect_equal(num_range("z", 1:3), integer(0))
})


test_that("matches return integer positions", {
  scoped_vars(c("abc", "acd", "bbc", "bbd", "eee"))

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

  expect_equal(vars_select(vars, starts_with(vars)), c(x = "x"))
  expect_equal(vars_select(vars, ends_with(vars)), c(x = "x"))
  expect_equal(vars_select(vars, contains(vars)), c(x = "x"))
  expect_equal(vars_select(vars, matches(vars)), c(x = "x"))
})

test_that("can use a variable even if it exists in the data (#2266)", {
  vars <- c("x", "y")
  names(vars) <- vars

  y <- "x"
  expected_result <- c(x = "x")

  expect_equal(vars_select(vars, starts_with(y)), expected_result)
  expect_equal(vars_select(vars, ends_with(y)), expected_result)
  expect_equal(vars_select(vars, contains(y)), expected_result)
  expect_equal(vars_select(vars, matches(y)), expected_result)
})

test_that("num_range selects numeric ranges", {
  vars <- c("x1", "x2", "x01", "x02", "x10", "x11")
  names(vars) <- vars

  expect_equal(vars_select(vars, num_range("x", 1:2)), vars[1:2])
  expect_equal(vars_select(vars, num_range("x", 1:2, width = 2)), vars[3:4])
  expect_equal(vars_select(vars, num_range("x", 10:11)), vars[5:6])
  expect_equal(vars_select(vars, num_range("x", 10:11, width = 2)), vars[5:6])
})

test_that("position must resolve to numeric variables throws error", {
  expect_error(
    vars_select(letters, !!list()),
    class = "tidyselect_error_index_bad_type"
  )
  expect_error(
    vars_select(letters, !!function() NULL),
    class = "tidyselect_error_index_bad_type"
  )
})

test_that("order is determined from inputs (#53)", {
  expect_identical(
    vars_select(names(mtcars), starts_with("c"), starts_with("d")),
    c(cyl = "cyl", carb = "carb", disp = "disp", drat = "drat")
  )
  expect_identical(
    vars_select(names(mtcars), one_of(c("carb", "mpg"))),
    c(carb = "carb", mpg = "mpg")
  )
})



# one_of ------------------------------------------------------------------

test_that("one_of gives useful errors", {
  expect_error(
    one_of(1L, .vars = c("x", "y")),
    "Input 1 must be a vector of column names, not an integer vector",
    fixed = TRUE,
    class = "tidyselect_error_incompatible_index_type"
  )
})

test_that("one_of tolerates but warns for unknown columns", {
  vars <- c("x", "y")

  expect_warning(res <- one_of("z", .vars = vars), "Unknown columns: `z`")
  expect_equal(res, integer(0))
  expect_warning(res <- one_of(c("x", "z"), .vars = vars), "Unknown columns: `z`")
  expect_equal(res, 1L)

})

test_that("one_of converts names to positions", {
  expect_equal(one_of("a", "z", .vars = letters), c(1L, 26L))
})

test_that("one_of works with variables", {
  vars <- c("x", "y")
  expected_result <- c(x = "x")
  var <- "x"
  expect_equal(vars_select(vars, one_of(var)), expected_result)
  # error messages from rlang
  expect_error(vars_select(vars, one_of(`_x`)), "not found")
  expect_error(vars_select(vars, one_of(`_y`)), "not found")
})

test_that("one_of works when passed variable name matches the column name (#2266)", {
  vars <- c("x", "y")
  expected_result <- c(x = "x")
  x <- "x"
  y <- "x"
  expect_equal(vars_select(vars, one_of(!! x)), expected_result)
  expect_equal(vars_select(vars, one_of(!! y)), expected_result)
  expect_equal(vars_select(vars, one_of(y)), expected_result)
})

test_that("one_of() supports S3 vectors", {
  expect_identical(vars_select(letters, one_of(factor(c("a", "c")))), c(a = "a", c = "c"))
})

test_that("one_of() compacts inputs (#110)", {
  expect_identical(
    vars_select(letters, -one_of()),
    set_names(letters)
  )
  expect_identical(
    vars_select(letters, -one_of(NULL)),
    set_names(letters)
  )
})


# first-selector ----------------------------------------------------------

test_that("initial (single) selector defaults correctly (issue #2275)", {
  cn <- setNames(nm = c("x", "y", "z"))

  ### Single Column Selected

  # single columns (present), explicit
  expect_equal(vars_select(cn, x), cn["x"])
  expect_equal(vars_select(cn, -x), cn[c("y", "z")])

  # single columns (present), matched
  expect_equal(vars_select(cn, contains("x")), cn["x"])
  expect_equal(vars_select(cn, -contains("x")), cn[c("y", "z")])

  # single columns (not present), explicit
  expect_error(vars_select(cn, foo), class = "tidyselect_error_index_oob_names")
  expect_error(vars_select(cn, -foo), class = "tidyselect_error_index_oob_names")

  # single columns (not present), matched
  expect_equal(vars_select(cn, contains("foo")), cn[integer()])
  expect_equal(vars_select(cn, -contains("foo")), cn)
})

test_that("initial (of multiple) selectors default correctly (issue #2275)", {
  cn <- setNames(nm = c("x", "y", "z"))

  ### Multiple Columns Selected

  # explicit(present) + matched(present)
  expect_equal(vars_select(cn, x, contains("y")), cn[c("x", "y")])
  expect_equal(vars_select(cn, x, -contains("y")), cn["x"])
  expect_equal(vars_select(cn, -x, contains("y")), cn[c("y", "z")])
  expect_equal(vars_select(cn, -x, -contains("y")), cn["z"])

  # explicit(present) + matched(not present)
  expect_equal(vars_select(cn, x, contains("foo")), cn["x"])
  expect_equal(vars_select(cn, x, -contains("foo")), cn["x"])
  expect_equal(vars_select(cn, -x, contains("foo")), cn[c("y", "z")])
  expect_equal(vars_select(cn, -x, -contains("foo")), cn[c("y", "z")])

  # matched(present) + explicit(present)
  expect_equal(vars_select(cn, contains("x"), y), cn[c("x", "y")])
  expect_equal(vars_select(cn, contains("x"), -y), cn["x"])
  expect_equal(vars_select(cn, -contains("x"), y), cn[c("y", "z")])
  expect_equal(vars_select(cn, -contains("x"), -y), cn["z"])

  # matched(not present) + explicit(not present)
  expect_error(vars_select(cn, contains("foo"), bar), class = "tidyselect_error_index_oob_names")
  expect_error(vars_select(cn, contains("foo"), -bar), class = "tidyselect_error_index_oob_names")
  expect_error(vars_select(cn, -contains("foo"), bar), class = "tidyselect_error_index_oob_names")
  expect_error(vars_select(cn, -contains("foo"), -bar), class = "tidyselect_error_index_oob_names")

  # matched(present) + matched(present)
  expect_equal(vars_select(cn, contains("x"), contains("y")), cn[c("x", "y")])
  expect_equal(vars_select(cn, contains("x"), -contains("y")), cn["x"])
  expect_equal(vars_select(cn, -contains("x"), contains("y")), cn[c("y", "z")])
  expect_equal(vars_select(cn, -contains("x"), -contains("y")), cn["z"])

  # matched(present) + matched(not present)
  expect_equal(vars_select(cn, contains("x"), contains("foo")), cn["x"])
  expect_equal(vars_select(cn, contains("x"), -contains("foo")), cn["x"])
  expect_equal(vars_select(cn, -contains("x"), contains("foo")), cn[c("y", "z")])
  expect_equal(vars_select(cn, -contains("x"), -contains("foo")), cn[c("y", "z")])

  # matched(not present) + matched(present)
  expect_equal(vars_select(cn, contains("foo"), contains("x")), cn["x"])
  expect_equal(vars_select(cn, contains("foo"), -contains("x")), cn[integer()])
  expect_equal(vars_select(cn, -contains("foo"), contains("x")), cn)
  expect_equal(vars_select(cn, -contains("foo"), -contains("x")), cn[c("y", "z")])

  # matched(not present) + matched(not present)
  expect_equal(vars_select(cn, contains("foo"), contains("bar")), cn[integer()])
  expect_equal(vars_select(cn, contains("foo"), -contains("bar")), cn[integer()])
  expect_equal(vars_select(cn, -contains("foo"), contains("bar")), cn)
  expect_equal(vars_select(cn, -contains("foo"), -contains("bar")), cn)
})

test_that("middle (no-match) selector should not clear previous selectors (issue #2275)", {
  cn <- setNames(nm = c("x", "y", "z"))

  expect_equal(
    vars_select(cn, contains("x"), contains("foo"), contains("z")),
    cn[c("x", "z")]
  )
  expect_equal(
    vars_select(cn, contains("x"), -contains("foo"), contains("z")),
    cn[c("x", "z")]
  )
})

test_that("can select with c() (#2685)", {
  expect_identical(vars_select(letters, c(a, z)), c(a = "a", z = "z"))
})

test_that("can select with .data pronoun (#2715)", {
  expect_identical(vars_select("foo", .data$foo), c(foo = "foo"))
  expect_identical(vars_select("foo", .data[["foo"]]), c(foo = "foo"))

  expect_identical(vars_select(c("a", "b", "c"), .data$a : .data$b), c(a = "a", b = "b"))
  expect_identical(vars_select(c("a", "b", "c"), .data[["a"]] : .data[["b"]]), c(a = "a", b = "b"))
})

test_that("last_col() selects last argument with offset", {
  vars <- letters[1:3]
  expect_identical(last_col(0, vars), 3L)
  expect_identical(last_col(2, vars), 1L)

  expect_error(last_col(3, vars), "`offset` must be smaller than the number of columns")
  expect_error(last_col(vars = chr()), "Can't select last column when input is empty")
})

test_that("all_of() and any_of() handle named vectors", {
  expect_identical(vars_select(letters, all_of(c("a", foo = "b"))), c(a = "a", foo = "b"))
  expect_identical(vars_select(letters, any_of(c("a", foo = "b", "bar"))), c(a = "a", foo = "b"))
})

test_that("all_of() is strict", {
  expect_error(vars_select(letters, all_of(c("a", "foo"))), class = "tidyselect_error_index_oob_names")
})

test_that("any_of() is lax", {
  expect_identical(
    vars_select(letters, any_of(c("a", "foo"))),
    vars_select(letters, a)
  )
  expect_identical(
    vars_select(letters, -any_of(c("a", "foo"))),
    vars_select(letters, -a)
  )
})

test_that("all_of() and any_of() check their inputs", {
  expect_error(vars_select(letters, all_of(1L)), class = "tidyselect_error_index_bad_type")
  expect_error(vars_select(letters, any_of(1L)), class = "tidyselect_error_index_bad_type")
  expect_error(vars_select(letters, all_of(NA)), "missing")
  expect_error(vars_select(letters, any_of(NA)), "missing")
  expect_error(vars_select(letters, all_of(na_chr)), "missing")
  expect_error(vars_select(letters, any_of(na_chr)), "missing")
})

test_that("matchers accept length > 1 vectors (#50)", {
  expect_identical(
    vars_select(names(iris), starts_with(c("Sep", "Petal"))),
    vars_select(names(iris), starts_with("Sep") | starts_with("Petal"))
  )
  expect_identical(
    vars_select(names(iris), ends_with(c("gth", "Width"))),
    vars_select(names(iris), ends_with("gth") | ends_with("Width"))
  )
  expect_identical(
    vars_select(names(iris), contains(c("epal", "eta"))),
    vars_select(names(iris), contains("epal") | contains("eta")),
  )
  expect_identical(
    vars_select(names(iris), matches(c("epal", "eta"))),
    vars_select(names(iris), matches("epal") | contains("eta")),
  )
})

test_that("`all_of()` doesn't fail if `.strict` is FALSE", {
  expect_identical(
    vars_select(letters, all_of(c("a", "bar", "c")), .strict = FALSE),
    c(a = "a", c = "c")
  )
})
