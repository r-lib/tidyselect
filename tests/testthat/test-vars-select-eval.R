context("vars-select-eval")

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

test_that("can't use boolean operators with symbols", {
  expect_error(vars_select(letters, starts_with("a") & z), "bare variables")
  expect_error(vars_select(letters, starts_with("a") | z), "bare variables")

  verify_output(test_path("outputs", "vars-select-bool-symbols.txt"), {
    vars_select(letters, starts_with("a") & z)
    vars_select(letters, starts_with("a") | z)
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
  vars <- c("a", "b")
  expect_message(
    vars_select(letters, vars),
    "Use `all_of(vars)` to silence",
    fixed = TRUE
  )
  verify_output(test_path("outputs", "vars-select-context-lookup.txt"), {
    vars_select(letters, vars)
  })
})
