
test_that("leaves of data expression tree are evaluated in the context", {
  wrapper <- function(x, var) select_pos(x, {{ var }}:length(x))
  expect_identical(wrapper(letters2, x), select_pos(letters2, x:26))

  wrapper <- function(x, var) select_pos(x, -({{ var }}:length(x)))
  expect_identical(wrapper(letters2, x), select_pos(letters2, -(x:26)))

  wrapper <- function(x, var1, var2) select_pos(x, c(-{{ var1 }}, -({{ var2 }}:length(x))))
  expect_identical(wrapper(letters2, a, c), select_pos(letters2, c(-a, -(c:26))))
})

test_that("dots passed to `c()` are evaluated in their context", {
  wrapper <- function(x, ...) {
    select_pos(x, c(x, length(x), ...))
  }
  f <- function(x, ...) {
    a <- 13
    g(x, ..., identity(a))
  }
  g <- function(x, ...) {
    a <- 15
    wrapper(x, ..., identity(a))
  }
  expect_identical(f(letters2, e, 10), select_pos(letters2, c(x, 26, e, 10, 13, 15)))
})

test_that("quosures can be used in data expressions", {
  expect_identical(select_pos(letters2, !!quo(a)), select_pos(letters2, a))
  expect_identical(select_pos(letters2, !!quo(a:!!quo(c))), select_pos(letters2, a:c))
  expect_identical(select_pos(letters2, !!quo(c(!!quo(a)))), select_pos(letters2, a))
})

test_that("quosures update the current context", {
  quo <- local({
    `_foo` <- 24
    quo(a:identity(`_foo`))
  })
  expect_identical(select_pos(letters2, !!quo(c(-(!!quo)))), select_pos(letters2, -(a:24)))
})

test_that("data expressions support character vectors (#78)", {
  expect_identical(select_pos(letters2, -identity(letters2[2:5])), select_pos(letters2, -(2:5)))
  expect_identical(select_pos(letters2, identity("a"):identity("c")), select_pos(letters2, a:c))
  expect_identical(select_pos(letters2, (identity(letters2[[1]]))), select_pos(letters2, a))
  expect_identical(select_pos(letters2, c(identity(letters2[[1]]))), select_pos(letters2, a))
})

test_that("boolean operators are overloaded", {
  expect_identical(
    select_pos(letters2, starts_with("a") & ends_with("a")),
    select_pos(letters2, intersect(starts_with("a"), ends_with("a"))),
  )

  expect_identical(
    select_pos(letters2, starts_with("a") | ends_with("c")),
    select_pos(letters2, c(starts_with("a"), ends_with("c")))
  )

  expect_identical(
    select_pos(letters2, starts_with("a") | ends_with("c") | contains("z")),
    select_pos(letters2, c(starts_with("a"), ends_with("c"), contains("z")))
  )

  expect_identical(
    select_pos(letters2, (starts_with("a") | ends_with("c")) & contains("a")),
    select_pos(letters2, intersect(c(starts_with("a"), ends_with("c")), contains("a")))
  )

  expect_identical(
    select_pos(letters2, !(starts_with("a") | ends_with("c"))),
    select_pos(letters2, -(starts_with("a") | ends_with("c"))),
  )

  # This pattern is not possible with `intersect()` because its
  # arguments are evaluated in non-data context
  expect_error(
    select_pos(letters2, intersect(c(starts_with("a"), ends_with("c")), b:d)),
    "not found"
  )
  expect_identical(
    select_pos(letters2, (starts_with("a") | ends_with("c")) & b:d),
    select_pos(letters2, c)
  )

  expect_identical(
    select_pos(letters2, (starts_with("a") | ends_with("c")) | i:k),
    select_pos(letters2, c(c(starts_with("a"), ends_with("c")), i:k)),
  )
})

test_that("scalar boolean operators fail informatively", {
  verify_output(test_path("outputs", "vars-select-bool-scalar-ops.txt"), {
    select_pos(letters2, starts_with("a") || ends_with("b"))
    select_pos(letters2, starts_with("a") && ends_with("b"))
  })
})

test_that("can't use arithmetic operators in data context", {
  expect_error(select_pos(letters2, a + 2), "arithmetic")
  expect_error(select_pos(letters2, a * 2), "arithmetic")
  expect_error(select_pos(letters2, a / 2), "arithmetic")
  expect_error(select_pos(letters2, a^2), "arithmetic")

  verify_output(test_path("outputs", "vars-select-num-ops.txt"), {
    select_pos(letters2, a + 2)
    select_pos(letters2, a * 2)
    select_pos(letters2, a / 2)
    select_pos(letters2, a^2)
  })
})

test_that("can use arithmetic operators in non-data context", {
  expect_identical(select_pos(letters2, identity(2 * 2 + 2 ^ 2 / 2)), c(f = 6L))
})

test_that("symbol lookup outside data informs caller about better practice", {
  scoped_options(tidyselect_verbosity = "verbose")

  vars1 <- c("a", "b")
  expect_message(select_pos(letters2, vars1))

  vars2 <- c("a", "b") # To force a message the second time
  verify_output(test_path("outputs", "vars-select-context-lookup.txt"), {
    select_pos(letters2, vars2)
  })
})

test_that("symbol evaluation only informs once", {
  scoped_options(tidyselect_verbosity = "verbose")
  `_identifier` <- 1
  expect_message(select_pos(iris, `_identifier`), "brittle")
  expect_message(select_pos(iris, `_identifier`), regexp = NA)
})

test_that("symbol evaluation informs from global environment but not packages", {
  fn <- function(name, select_pos) {
    assign(name, 1L)
    eval(bquote(select_pos(iris, .(as.symbol(name)))))
  }

  environment(fn) <- env(global_env())
  expect_message(fn("from-global-env", select_pos), "brittle")

  environment(fn) <- ns_env("rlang")
  expect_message(fn("from-ns-env", select_pos), NA)
})

test_that("selection helpers are in the context mask", {
  out <- local(envir = baseenv(), {
    letters2 <- rlang::set_names(letters)
    tidyselect::eval_select(quote(all_of("a")), letters2)
  })
  expect_identical(out, c(a = 1L))
})

test_that("non-strict evaluation allows unknown variables", {
  expect_identical(
    select_pos(letters2, identity("foo"), strict = FALSE),
    select_pos(letters2, int())
  )
  expect_identical(
    select_pos(letters2, identity(100), strict = FALSE),
    select_pos(letters2, int())
  )
  expect_identical(
    select_pos(letters2, -identity("foo"), strict = FALSE),
    select_pos(letters2, -int())
  )
  expect_identical(
    select_pos(letters2, -identity(100), strict = FALSE),
    select_pos(letters2, -int())
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

test_that("selections provide informative errors", {
  verify_output(test_path("outputs", "eval-errors.txt"), {
    "Foreign errors during evaluation"
    select_pos(iris, eval_tidy(foobar))
  })
})

test_that("can select with .data pronoun (#2715)", {
  expect_identical(select_pos(c(foo = "foo"), .data$foo), c(foo = 1L))
  expect_identical(select_pos(c(foo = "foo"), .data[["foo"]]), c(foo = 1L))
  expect_identical(select_pos(letters2, .data$a : .data$b), c(a = 1L, b = 2L))
  expect_identical(select_pos(letters2, .data[["a"]] : .data[["b"]]), c(a = 1L, b = 2L))
})
