context("rename vars")

test_that("when .strict = FALSE, vars_rename always succeeds", {
  skip("FIXME")
  expect_error(
    vars_rename(c("a", "b"), d = e, .strict = TRUE),
    "object 'e' not found",
    fixed = TRUE
  )

  expect_error(
    vars_rename(c("a", "b"), d = e, f = g, .strict = TRUE),
    "object 'e' not found",
    fixed = TRUE
  )

  expect_equal(
    vars_rename(c("a", "b"), d = e, .strict = FALSE),
    c("a" = "a", "b" = "b")
  )

  expect_identical(
    vars_rename("x", A = x, B = y, .strict = FALSE),
    c(A = "x")
  )

  expect_error(
    vars_rename(c("a", "b"), d = "e", f = "g", .strict = TRUE),
    "Unknown columns `e` and `g`",
    fixed = TRUE
  )

  expect_identical(
    vars_rename("x", A = "x", B = "y", .strict = FALSE),
    c(A = "x")
  )
})

test_that("vars_rename() works with positions", {
  expect_identical(vars_rename(letters[1:4], new1 = 2, new2 = 4), c(a = "a", new1 = "b", c = "c", new2 = "d"))
  expect_error(vars_rename(letters, new = 1.5), class = "tidyselect_error_index_bad_type")
})

test_that("vars_rename() sets variable context", {
  expect_identical(vars_rename(c("a", "b"), B = one_of("b")), c(a = "a", B = "b"))
})

test_that("vars_rename() supports `.data` pronoun", {
  expect_identical(vars_rename(c("a", "b"), B = .data$b), c(a = "a", B = "b"))
})

test_that("vars_rename() unquotes named character vectors", {
  vars <- c(foo = "a", bar = "z")
  expect_identical(vars_rename(letters, !!!vars), vars_rename(letters, foo = a, bar = z))
  expect_identical(vars_rename(letters, !!vars), vars_rename(letters, foo = a, bar = z))
  expect_error(vars_rename(letters, foo = !!vars), class = "tidyselect_error_rename_to_same")
})

test_that("missing values are detected in vars_rename() (#72)", {
  expect_error(vars_rename(letters, A = na_cpl), class = "tidyselect_error_index_bad_type")
  expect_error(
    vars_rename(letters, A = NA, B = na_chr, C = na_int, D = na_dbl),
    glue(
      "* NA
       * na_chr
       * na_int
       * na_dbl"
    ),
    fixed = TRUE
  )
})

test_that("vars_rename() supports named character vectors of length 1 (#77)", {
  expect_identical(vars_rename(letters[1:3], !!c(B = "b")), c(a = "a", B = "b", c = "c"))
})

test_that("vars_rename() allows consecutive renames", {
  expect_identical(vars_rename(c("a", "b", "c"), foo = a, bar = a), c(bar = "a", b = "b", c = "c"))
})

test_that("vars_rename() disallows renaming to same column", {
  expect_error(
    vars_rename(letters, A = 1:2),
    class = "tidyselect_error_rename_to_same"
  )
  expect_error(
    vars_rename(c("a", "b", "c"), foo = a, foo = b),
    class = "tidyselect_error_rename_to_same"
  )
  expect_error(
    vars_rename(c("a", "b", "c"), c = a, c = b),
    class = "tidyselect_error_rename_to_same"
  )

  verify_output(test_path("outputs", "vars-rename-error-rename-to-same.txt"), {
    "New column"
    vars_rename(c("a", "b", "c"), foo = a, foo = b)

    "Existing column"
    vars_rename(c("a", "b", "c"), c = a, c = b)
  })
})

test_that("vars_rename() allows overlapping renames", {
  expect_identical(vars_rename(c("a", "b", "c"), b = c, c = b), c(a = "a", c = "b", b = "c"))
})

test_that("vars_rename() disallows renaming to existing columns (#70)", {
  expect_error(
    vars_rename(c("a", "b", "c"), b = a),
    class = "tidyselect_error_rename_to_existing"
  )
  expect_error(
    vars_rename(c("a", "b", "c", "d"), c = a, d = b),
    class = "tidyselect_error_rename_to_existing"
  )
  expect_error(
    vars_rename(c("a", "b", "c"), b = a, c = b),
    class = "tidyselect_error_rename_to_existing"
  )
  verify_output(test_path("outputs", "vars-rename-error-rename-to-existing.txt"), {
    "One column"
    vars_rename(c("a", "b", "c"), b = a)

    "Multiple columns"
    vars_rename(c("a", "b", "c", "d"), c = a, d = b)

    "Overlapping rename with one duplicate column"
    vars_rename(c("a", "b", "c"), b = a, c = b)
  })
})

test_that("vars_rename() ignores existing duplicates", {
  expect_identical(vars_rename(c("a", "b", "a"), foo = b), c(a = "a", foo = "b", a = "a"))
})

test_that("vars_rename() renames existing duplicates", {
  expect_identical(vars_rename(c("a", "b", "a"), a = b, b = a), c(b = "a", a = "b", b = "a"))
})

test_that("vars_rename() can fix duplicates by supplying positions", {
  # Will be useful when we return indices
  expect_identical(vars_rename(c("a", "b", "a"), c = 3), c(a = "a", b = "b", c = "a"))
})

test_that("vars_rename() handles empty inputs", {
  expect_identical(vars_rename(letters), set_names(letters))
  expect_identical(vars_rename(letters, int()), set_names(letters))
  expect_identical(vars_rename(letters, chr()), set_names(letters))
})

test_that("vars_rename() type-checks arguments", {
  expect_error(vars_rename(letters, A = TRUE), class = "tidyselect_error_index_bad_type")
  expect_error(vars_rename(letters, A = 1.5), class = "tidyselect_error_index_bad_type")
  expect_error(vars_rename(letters, A = !!list()), class = "tidyselect_error_index_bad_type")

  verify_output(test_path("outputs", "vars-rename-type-checking.txt"), {
    vars_rename(letters, A = TRUE)
    vars_rename(letters, A = 1.5)
    vars_rename(letters, A = list())
  })
})

test_that("vars_rename() ignore unknown columns if strict is FALSE", {
  expect_identical(
    vars_rename(letters, foo = bar, .strict = FALSE),
    vars_rename(letters)
  )
})
