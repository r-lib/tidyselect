
test_that("leaves of data expression tree are evaluated in the context", {
  wrapper <- function(x, var) vars_select(x, {{ var }}:length(x))
  expect_identical(wrapper(letters, x), vars_select(letters, x:26))

  wrapper <- function(x, var) vars_select(x, -({{ var }}:length(x)))
  expect_identical(wrapper(letters, x), vars_select(letters, -(x:26)))

  wrapper <- function(x, var1, var2) vars_select(x, c(-{{ var1 }}, -({{ var2 }}:length(x))))
  expect_identical(wrapper(letters, a, c), vars_select(letters, -a, -(c:26)))
})

test_that("dots passed to `c()` are evaluated in their context", {
  wrapper <- function(x, ...) {
    vars_select(x, c(x, length(x), ...))
  }
  f <- function(x, ...) {
    a <- 13
    g(x, ..., identity(a))
  }
  g <- function(x, ...) {
    a <- 15
    wrapper(x, ..., identity(a))
  }
  expect_identical(f(letters, e, 10), vars_select(letters, x, 26, e, 10, 13, 15))
})

test_that("quosures can be used in data expressions", {
  expect_identical(vars_select(letters, !!quo(a)), vars_select(letters, a))
  expect_identical(vars_select(letters, !!quo(a:!!quo(c))), vars_select(letters, a:c))
  expect_identical(vars_select(letters, !!quo(c(!!quo(a)))), vars_select(letters, a))
})

test_that("quosures update the current context", {
  quo <- local({
    `_foo` <- 24
    quo(a:identity(`_foo`))
  })
  expect_identical(vars_select(letters, !!quo(c(-(!!quo)))), vars_select(letters, -(a:24)))
})

test_that("data expressions support character vectors (#78)", {
  expect_identical(vars_select(letters, -identity(letters[2:5])), vars_select(letters, -(2:5)))
  expect_identical(vars_select(letters, identity("a"):identity("c")), vars_select(letters, a:c))
  expect_identical(vars_select(letters, (identity(letters[[1]]))), vars_select(letters, a))
  expect_identical(vars_select(letters, c(identity(letters[[1]]))), vars_select(letters, a))
})

test_that("boolean operators are overloaded", {
  expect_identical(
    vars_select(letters, starts_with("a") & ends_with("a")),
    vars_select(letters, intersect(starts_with("a"), ends_with("a"))),
  )

  expect_identical(
    vars_select(letters, starts_with("a") | ends_with("c")),
    vars_select(letters, c(starts_with("a"), ends_with("c")))
  )

  expect_identical(
    vars_select(letters, starts_with("a") | ends_with("c") | contains("z")),
    vars_select(letters, starts_with("a"), ends_with("c"), contains("z"))
  )

  expect_identical(
    vars_select(letters, (starts_with("a") | ends_with("c")) & contains("a")),
    vars_select(letters, intersect(c(starts_with("a"), ends_with("c")), contains("a")))
  )

  expect_identical(
    vars_select(letters, !(starts_with("a") | ends_with("c"))),
    vars_select(letters, -(starts_with("a") | ends_with("c"))),
  )

  # This pattern is not possible with `intersect()` because its
  # arguments are evaluated in non-data context
  expect_error(
    vars_select(letters, intersect(c(starts_with("a"), ends_with("c")), b:d)),
    "not found"
  )
  expect_identical(
    vars_select(letters, (starts_with("a") | ends_with("c")) & b:d),
    vars_select(letters, c)
  )

  expect_identical(
    vars_select(letters, (starts_with("a") | ends_with("c")) | i:k),
    vars_select(letters, c(starts_with("a"), ends_with("c")), i:k),
  )
})

test_that("scalar boolean operators fail informatively", {
  verify_output(test_path("outputs", "vars-select-bool-scalar-ops.txt"), {
    vars_select(letters, starts_with("a") || ends_with("b"))
    vars_select(letters, starts_with("a") && ends_with("b"))
  })
})

test_that("can't use arithmetic operators in data context", {
  expect_error(vars_select(letters, a + 2), "arithmetic")
  expect_error(vars_select(letters, a * 2), "arithmetic")
  expect_error(vars_select(letters, a / 2), "arithmetic")
  expect_error(vars_select(letters, a^2), "arithmetic")

  verify_output(test_path("outputs", "vars-select-num-ops.txt"), {
    vars_select(letters, a + 2)
    vars_select(letters, a * 2)
    vars_select(letters, a / 2)
    vars_select(letters, a^2)
  })
})

test_that("can use arithmetic operators in non-data context", {
  expect_identical(vars_select(letters, identity(2 * 2 + 2 ^ 2 / 2)), c(f = "f"))
})

test_that("symbol lookup outside data informs caller about better practice", {
  vars1 <- c("a", "b")
  vars2 <- c("a", "b") # To force a message the second time
  expect_message(vars_select(letters, vars1))
  verify_output(test_path("outputs", "vars-select-context-lookup.txt"), {
    vars_select(letters, vars2)
  })
})

test_that("symbol evaluation only informs once", {
  idx <- 1
  expect_message(select_pos(iris, idx), "brittle")
  expect_message(select_pos(iris, idx), regexp = NA)
})

test_that("selection helpers are in the context mask", {
  out <- local(envir = baseenv(), {
    tidyselect::vars_select(letters, all_of("a"))
  })
  expect_identical(out, c(a = "a"))
})

test_that("non-strict evaluation allows unknown variables", {
  expect_identical(
    vars_select(letters, identity("foo"), .strict = FALSE),
    vars_select(letters, int())
  )
  expect_identical(
    vars_select(letters, identity(100), .strict = FALSE),
    vars_select(letters, int())
  )
  expect_identical(
    vars_select(letters, -identity("foo"), .strict = FALSE),
    vars_select(letters, -int())
  )
  expect_identical(
    vars_select(letters, -identity(100), .strict = FALSE),
    vars_select(letters, -int())
  )
})

test_that("can use predicates in selections", {
  expect_identical(select_pos(iris, is.factor), c(Species = 5L))
  expect_identical(select_pos(iris, is.numeric), set_names(1:4, names(iris)[1:4]))
  expect_identical(select_pos(iris, is.numeric & is.factor), set_names(int(), chr()))
  expect_identical(select_pos(iris, is.numeric | is.factor), set_names(1:5, names(iris)))
})

test_that("inline functions are allowed", {
  expect_identical(
    select_pos(iris, !!is.numeric),
    select_pos(iris, is.numeric),
  )
  expect_identical(
    select_pos(iris, function(x) is.numeric(x)),
    select_pos(iris, is.numeric),
  )
})

test_that("predicates have access to the full data", {
  p <- function(x) is.numeric(x) && mean(x) > 5
  expect_identical(select_pos(iris, p), c(Sepal.Length = 1L))
})

test_that("informative error with legacy tidyselect", {
  expect_error(
    vars_select(letters, is.numeric),
    "doesn't support predicates yet"
  )
})

test_that("unary `-` is alias for `!`", {
  expect_identical(select_pos(mtcars, -(cyl:carb)), c(mpg = 1L))
})

test_that("empty inputs return empty indices", {
  expect_identical(select_pos(mtcars, int()), named(int()))
  expect_identical(select_pos(mtcars, !!int()), named(int()))
})

test_that("indices are returned in order of evaluation", {
  expect_identical(select_pos(mtcars, cyl | mpg), c(cyl = 2L, mpg = 1L))
  expect_identical(select_pos(mtcars, c(cyl | mpg)), c(cyl = 2L, mpg = 1L))
})

test_that("0 is ignored", {
  expect_identical(select_pos(mtcars, 0), named(int()))
  expect_identical(select_pos(mtcars, identity(0)), named(int()))
  expect_identical(select_pos(mtcars, 0L | 0L), named(int()))
  expect_identical(select_pos(mtcars, c(0L, -1L)), named(int()))
})

test_that("negative indices are disallowed", {
  expect_error(select_pos(mtcars, identity(c(-1, 1))), "negative")
  expect_error(select_pos(mtcars, !!c(-1, 1)), "negative")
  expect_error(select_pos(mtcars, cyl | !!c(-1, 1)), "negative")
})

test_that("unique elements are returned", {
  x <- list(a = 1L, b = 2L)
  expect_identical(select_pos(x, !!c(1L, 1L)), named(1L))
  expect_identical(select_pos(x, !!c(1L, foo = 1L)), c(foo = 1L))
  expect_identical(select_pos(x, !!c(foo = 1L, 1L)), c(foo = 1L))
  expect_identical(select_pos(x, !!c(foo = 1L, 1L, bar = 1L)), c(foo = 1L, bar = 1L))
})
