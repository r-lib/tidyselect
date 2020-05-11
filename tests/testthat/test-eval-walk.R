
test_that("leaves of data expression tree are evaluated in the context", {
  wrapper <- function(x, var) select_loc(x, {{ var }}:length(x))
  expect_identical(wrapper(letters2, x), select_loc(letters2, x:26))

  wrapper <- function(x, var) select_loc(x, -({{ var }}:length(x)))
  expect_identical(wrapper(letters2, x), select_loc(letters2, -(x:26)))

  wrapper <- function(x, var1, var2) select_loc(x, c(-{{ var1 }}, -({{ var2 }}:length(x))))
  expect_identical(wrapper(letters2, a, c), select_loc(letters2, c(-a, -(c:26))))
})

test_that("dots passed to `c()` are evaluated in their context", {
  wrapper <- function(x, ...) {
    select_loc(x, c(x, length(x), ...))
  }
  f <- function(x, ...) {
    a <- 13
    g(x, ..., identity(a))
  }
  g <- function(x, ...) {
    a <- 15
    wrapper(x, ..., identity(a))
  }
  expect_identical(f(letters2, e, 10), select_loc(letters2, c(x, 26, e, 10, 13, 15)))
})

test_that("quosures can be used in data expressions", {
  expect_identical(select_loc(letters2, !!quo(a)), select_loc(letters2, a))
  expect_identical(select_loc(letters2, !!quo(a:!!quo(c))), select_loc(letters2, a:c))
  expect_identical(select_loc(letters2, !!quo(c(!!quo(a)))), select_loc(letters2, a))
})

test_that("quosures update the current context", {
  quo <- local({
    `_foo` <- 24
    quo(a:identity(`_foo`))
  })
  expect_identical(select_loc(letters2, !!quo(c(-(!!quo)))), select_loc(letters2, -(a:24)))
})

test_that("data expressions support character vectors (#78)", {
  expect_identical(select_loc(letters2, -identity(letters2[2:5])), select_loc(letters2, -(2:5)))
  expect_identical(select_loc(letters2, identity("a"):identity("c")), select_loc(letters2, a:c))
  expect_identical(select_loc(letters2, (identity(letters2[[1]]))), select_loc(letters2, a))
  expect_identical(select_loc(letters2, c(identity(letters2[[1]]))), select_loc(letters2, a))
})

test_that("boolean operators are overloaded", {
  expect_identical(
    select_loc(letters2, starts_with("a") & ends_with("a")),
    select_loc(letters2, intersect(starts_with("a"), ends_with("a"))),
  )

  expect_identical(
    select_loc(letters2, starts_with("a") | ends_with("c")),
    select_loc(letters2, c(starts_with("a"), ends_with("c")))
  )

  expect_identical(
    select_loc(letters2, starts_with("a") | ends_with("c") | contains("z")),
    select_loc(letters2, c(starts_with("a"), ends_with("c"), contains("z")))
  )

  expect_identical(
    select_loc(letters2, (starts_with("a") | ends_with("c")) & contains("a")),
    select_loc(letters2, intersect(c(starts_with("a"), ends_with("c")), contains("a")))
  )

  expect_identical(
    select_loc(letters2, !(starts_with("a") | ends_with("c"))),
    select_loc(letters2, -(starts_with("a") | ends_with("c"))),
  )

  # This pattern is not possible with `intersect()` because its
  # arguments are evaluated in non-data context
  expect_error(
    select_loc(letters2, intersect(c(starts_with("a"), ends_with("c")), b:d)),
    "not found"
  )
  expect_identical(
    select_loc(letters2, (starts_with("a") | ends_with("c")) & b:d),
    select_loc(letters2, c)
  )

  expect_identical(
    select_loc(letters2, (starts_with("a") | ends_with("c")) | i:k),
    select_loc(letters2, c(c(starts_with("a"), ends_with("c")), i:k)),
  )
})

test_that("scalar boolean operators fail informatively", {
  verify_output(test_path("outputs", "vars-select-bool-scalar-ops.txt"), {
    select_loc(letters2, starts_with("a") || ends_with("b"))
    select_loc(letters2, starts_with("a") && ends_with("b"))
  })
})

test_that("can use `+` in env context", {
  foo <- 1
  expect_identical(select_loc(letters2, foo + 2), c(c = 3L))
  expect_error(select_loc(letters2, a + 2), "not found")
})

test_that("can use `-` in env context", {
  expect_identical(
    select_loc(iris, 1:(ncol(iris) - 2)),
    select_loc(iris, 1:3)
  )
})

test_that("can't use `*` and `^` in data context", {
  expect_error(select_loc(letters2, a * 2), "arithmetic")
  expect_error(select_loc(letters2, a^2), "arithmetic")

  verify_output(test_path("outputs", "vars-select-num-ops.txt"), {
    select_loc(letters2, a * 2)
    select_loc(letters2, a^2)
  })
})

test_that("can use arithmetic operators in non-data context", {
  expect_identical(select_loc(letters2, identity(2 * 2 + 2 ^ 2 / 2)), c(f = 6L))
})

test_that("symbol lookup outside data informs caller about better practice", {
  skip("Non-deterministic failures")
  local_options(tidyselect_verbosity = "verbose")

  vars1 <- c("a", "b")
  expect_message(select_loc(letters2, vars1))

  vars2 <- c("a", "b") # To force a message the second time
  verify_output(test_path("outputs", "vars-select-context-lookup.txt"), {
    select_loc(letters2, vars2)
  })
})

test_that("symbol evaluation only informs once (#184)", {
  verify_output(test_path("outputs", "eval-sym-verbosity.txt"), {
    "Default"
    with_options(tidyselect_verbosity = NULL, {
      `_vars_default` <- "cyl"
      select_loc(mtcars, `_vars_default`)
      select_loc(mtcars, `_vars_default`)
      invisible(NULL)
    })

    "Verbose"
    with_options(tidyselect_verbosity = "verbose", {
      `_vars_verbose` <- "cyl"
      select_loc(mtcars, `_vars_verbose`)
      select_loc(mtcars, `_vars_verbose`)
      invisible(NULL)
    })

    "Quiet"
    with_options(tidyselect_verbosity = "quiet", {
      `_vars_quiet` <- "cyl"
      select_loc(mtcars, `_vars_quiet`)
      select_loc(mtcars, `_vars_quiet`)
      invisible(NULL)
    })
  })
})

test_that("symbol evaluation informs from global environment but not packages", {
  fn <- function(name, select_loc) {
    assign(name, 1L)
    eval(bquote(select_loc(iris, .(as.symbol(name)))))
  }

  environment(fn) <- env(global_env())
  expect_message(fn("from-global-env", select_loc), "ambiguous")

  environment(fn) <- ns_env("rlang")
  expect_message(fn("from-ns-env", select_loc), NA)
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
    select_loc(letters2, identity("foo"), strict = FALSE),
    select_loc(letters2, int())
  )
  expect_identical(
    select_loc(letters2, identity(100), strict = FALSE),
    select_loc(letters2, int())
  )
  expect_identical(
    select_loc(letters2, -identity("foo"), strict = FALSE),
    select_loc(letters2, -int())
  )
  expect_identical(
    select_loc(letters2, -identity(100), strict = FALSE),
    select_loc(letters2, -int())
  )
})

test_that("can use predicates in selections", {
  expect_identical(select_loc(iris, where(is.factor)), c(Species = 5L))
  expect_identical(select_loc(iris, where(is.numeric)), set_names(1:4, names(iris)[1:4]))
  expect_identical(select_loc(iris, where(is.numeric) & where(is.factor)), set_names(int(), chr()))
  expect_identical(select_loc(iris, where(is.numeric) | where(is.factor)), set_names(1:5, names(iris)))
})

test_that("inline functions are allowed", {
  expect_identical(
    select_loc(iris, !!is.numeric),
    select_loc(iris, where(is.numeric)),
  )
  expect_identical(
    select_loc(iris, function(x) is.numeric(x)),
    select_loc(iris, where(is.numeric)),
  )
})

test_that("predicates have access to the full data", {
  p <- function(x) is.numeric(x) && mean(x) > 5
  expect_identical(select_loc(iris, where(p)), c(Sepal.Length = 1L))
})

test_that("unary `-` is alias for `!`", {
  expect_identical(select_loc(mtcars, -(cyl:carb)), c(mpg = 1L))
})

test_that("empty inputs return empty indices", {
  expect_identical(select_loc(mtcars, int()), named(int()))
  expect_identical(select_loc(mtcars, !!int()), named(int()))
})

test_that("indices are returned in order of evaluation", {
  expect_identical(select_loc(mtcars, cyl | mpg), c(cyl = 2L, mpg = 1L))
  expect_identical(select_loc(mtcars, c(cyl | mpg)), c(cyl = 2L, mpg = 1L))
})

test_that("0 is ignored", {
  expect_identical(select_loc(mtcars, 0), named(int()))
  expect_identical(select_loc(mtcars, identity(0)), named(int()))
  expect_identical(select_loc(mtcars, 0L | 0L), named(int()))
  expect_identical(select_loc(mtcars, c(0L, -1L)), named(int()))
})

test_that("negative indices are disallowed", {
  expect_error(select_loc(mtcars, identity(c(-1, 1))), "negative")
  expect_error(select_loc(mtcars, !!c(-1, 1)), "negative")
  expect_error(select_loc(mtcars, cyl | !!c(-1, 1)), "negative")
})

test_that("unique elements are returned", {
  x <- list(a = 1L, b = 2L)
  expect_identical(select_loc(x, !!c(1L, 1L)), c(a = 1L))
  expect_identical(select_loc(x, !!c(1L, foo = 1L)), c(foo = 1L))
  expect_identical(select_loc(x, !!c(foo = 1L, 1L)), c(foo = 1L))
  expect_identical(select_loc(x, !!c(foo = 1L, 1L, bar = 1L)), c(foo = 1L, bar = 1L))
})

test_that("selections provide informative errors", {
  verify_output(test_path("outputs", "eval-errors.txt"), {
    "Foreign errors during evaluation"
    select_loc(iris, eval_tidy(foobar))
  })
})

test_that("can select with .data pronoun (#2715)", {
  expect_identical(select_loc(c(foo = "foo"), .data$foo), c(foo = 1L))
  expect_identical(select_loc(c(foo = "foo"), .data[["foo"]]), c(foo = 1L))
  expect_identical(select_loc(letters2, .data$a : .data$b), c(a = 1L, b = 2L))
  expect_identical(select_loc(letters2, .data[["a"]] : .data[["b"]]), c(a = 1L, b = 2L))
})

test_that(".data in env-expression has the lexical definition", {
  quo <- local({
    .data <- mtcars
    quo({ stopifnot(identical(.data, mtcars)); NULL})
  })
  expect_error(select_loc(mtcars, !!quo), regexp = NA)
})

test_that("binary `/` is short for set difference", {
  expect_identical(
    select_loc(iris, starts_with("Sepal") / ends_with("Width")),
    select_loc(iris, c(starts_with("Sepal"), -ends_with("Width")))
  )
})

test_that("can select names with unrepresentable characters", {
  skip_if_not_installed("rlang", "0.4.2.9000")
  withr::with_locale(c(LC_CTYPE = "C"), {
    name <- "\u4e2d"
    tbl <- setNames(data.frame(a = 1), name)
    expect_identical(
      select_loc(tbl, !!sym(name)),
      set_names(1L, name)
    )
  })
})

test_that("`-1:-2` is syntax for `-(1:2)` for compatibility", {
  expect_identical(
    select_loc(iris, -1:-2),
    select_loc(iris, -(1:2))
  )
  expect_identical(
    select_loc(iris, -Sepal.Length:-Sepal.Width),
    select_loc(iris, -(Sepal.Length:Sepal.Width))
  )
})

test_that("eval_sym() doesn't look for functions in the context", {
  foo <- is.numeric
  expect_error(select_loc(iris, foo), class = "vctrs_error_subscript_oob")
  expect_error(select_loc(iris, data), class = "vctrs_error_subscript_oob")
})

test_that("eval_sym() still supports predicate functions starting with `is`", {
  local_options(tidyselect_verbosity = "quiet")
  expect_identical(select_loc(iris, is_integer), select_loc(iris, where(is_integer)))
  expect_identical(select_loc(iris, is.numeric), select_loc(iris, where(is.numeric)))
  expect_identical(select_loc(iris, isTRUE), select_loc(iris, where(isTRUE)))
})

test_that("formula shorthand must be wrapped", {
  verify_errors({
    expect_error(select_loc(mtcars, ~ is.numeric(.x)))
    expect_error(select_loc(mtcars, ~ is.numeric(.x) || is.factor(.x) || is.character(.x)))
    expect_error(select_loc(mtcars, ~ is.numeric(.x) || is.factor(.x) || is.character(.x) ||
                                      is.numeric(.x) || is.factor(.x) || is.character(.x)))
  })
})

test_that("eval_walk() has informative messages", {
  verify_output(test_path("outputs", "test-helpers-where.txt"), {
    "# Using a predicate without where() warns"
    invisible(select_loc(iris, is_integer))
    invisible(select_loc(iris, is.numeric))
    invisible(select_loc(iris, isTRUE))

    "Warning is not repeated"
    invisible(select_loc(iris, is_integer))

    "formula shorthand must be wrapped"
    select_loc(mtcars, ~ is.numeric(.x))
    select_loc(mtcars, ~ is.numeric(.x) || is.factor(.x) || is.character(.x))
    select_loc(mtcars, ~ is.numeric(.x) || is.factor(.x) || is.character(.x) ||
                         is.numeric(.x) || is.factor(.x) || is.character(.x))
  })
})
