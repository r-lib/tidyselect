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
    "Use `all_of(vars)` instead of `vars` to silence",
    fixed = TRUE
  )
  verify_output(test_path("outputs", "vars-select-context-lookup.txt"), {
    vars_select(letters, vars)
  })
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

test_that("can refer to columns in | operands", {
  expect_identical(select_pos(mtcars, cyl | am), c(cyl = 2L, am = 9L))
})

test_that("can refer to columns in & operands", {
  expect_identical(select_pos(mtcars, cyl & contains("am")), set_names(int(), chr()))
  expect_identical(select_pos(mtcars, cyl & is.numeric), c(cyl = 2L))
})

test_that("boolean operators throw relevant errors", {
  expect_error(
    select_pos(mtcars, foobar & contains("am")),
    class = "tidyselect_error_index_oob_names"
  )
  expect_error(
    select_pos(mtcars, contains("am") | foobar),
    class = "tidyselect_error_index_oob_names"
  )
  expect_error(
    select_pos(mtcars, cyl & am),
    "empty selection"
  )

  verify_output(test_path("outputs", "select-eval-boolean-errors.txt"), {
    "Unknown names"
    select_pos(mtcars, foobar & contains("am"))
    select_pos(mtcars, contains("am") | foobar)

    "Empty intersection"
    select_pos(mtcars, cyl & am)
  })
})

test_that("c() interpolates union and setdiff operations (#130)", {
  expect_identical(select_pos(mtcars, c(mpg:disp, -(mpg:cyl))), c(disp = 3L))

  expect_identical(select_pos(mtcars, c(mpg, -mpg)), set_names(int(), chr()))
  expect_identical(select_pos(mtcars, c(mpg, -mpg, mpg)), c(mpg = 1L))
  expect_identical(select_pos(mtcars, c(mpg, -mpg, mpg, -mpg)), set_names(int(), chr()))

  expect_identical(select_pos(mtcars, c(mpg, cyl, -mpg)), c(cyl = 2L))
  expect_identical(select_pos(mtcars, c(mpg, cyl, -mpg, -cyl)), set_names(int(), chr()))
  expect_identical(select_pos(mtcars, c(mpg, cyl, -mpg, mpg, -cyl)), c(mpg = 1L))
})

test_that("c() expands dots", {
  fn <- function(...) select_pos(mtcars, c(...))
  expect_identical(fn(), set_names(int(), chr()))
  expect_identical(fn(mpg), c(mpg = 1L))
  expect_identical(fn(mpg, cyl), c(mpg = 1L, cyl = 2L))
  expect_identical(fn(mpg, cyl, disp), c(mpg = 1L, cyl = 2L, disp = 3L))
})

test_that("c() combines names tidily", {
  expect_identical(select_pos(mtcars, c(foo = mpg)), set_names(1L, "foo"))
  expect_identical(select_pos(mtcars, c(foo = c(bar = mpg))), set_names(1L, "foo...bar"))

  expect_identical(select_pos(mtcars, c(foo = mpg:cyl)), set_names(1:2, c("foo1", "foo2")))
  expect_identical(select_pos(mtcars, c(foo = c(bar = mpg:cyl))), set_names(1:2, c("foo...bar1", "foo...bar2")))
})

test_that("c() renames duplicates", {
  x <- list(a = 1L, b = 2L, a = 3L)
  expect_identical(select(x, foo = a, bar = b), list(foo = 1L, foo = 3L, bar = 2L))
})

test_that("allow named negative selections for consistency even if it has no effect", {
  expect_identical(select_pos(iris, c(foo = -!Species)), c(Species = 5L))
})

test_that("c() handles names consistently", {
  x <- list(a = 1L, b = 2L)
  expect_identical(select(x, a, foo = a), list(foo = 1L))
  expect_identical(select(x, a, foo = a, bar = a), list(foo = 1L, bar = 1L))
  expect_identical(select(x, foo = a, -a), named(list()))
  expect_identical(select(x, foo = a, -c(bar = a)), list(foo = 1L))
})

test_that("with uniquely-named inputs names are propagated with disambiguation", {
  expect_identical(select_pos(mtcars, c(foo = c(mpg, cyl))), c(foo1 = 1L, foo2 = 2L))
  expect_identical(select_pos(mtcars, c(bar = c(foo = c(mpg, cyl)))), c(bar...foo1 = 1L, bar...foo2 = 2L))
})

test_that("with minimally-named inputs names are propagated without disambiguation", {
  expect_identical(select_pos(unclass(mtcars), c(foo = c(mpg, cyl))), c(foo = 1L, foo = 2L))
  expect_identical(select_pos(unclass(mtcars), c(bar = c(foo = c(mpg, cyl)))), c(bar...foo = 1L, bar...foo = 2L))
})

test_that("uniquely-named inputs can't rename duplicates", {
  df <- tibble::new_tibble(list(a = 1, b = 2, a = 3), nrow = 1)

  expect_error(select_pos(df, c(foo = a)), class = "tidyselect_error_names_must_be_unique")
  expect_identical(select_pos(unclass(df), c(foo = a)), c(foo = 1L, foo = 3L))

  verify_output(test_path("outputs", "c-rename-duplicates.txt"), {
    select_pos(df, c(foo = a))
  })
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
