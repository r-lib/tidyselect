context("select vars")

test_that("vars_select can rename variables", {
  vars <- c("a", "b")
  expect_equal(vars_select(vars, b = a, a = b), c("b" = "a", "a" = "b"))
})

test_that("can rename to multiple columns", {
  expect_equal(vars_select(c("a", "b"), c = a, d = a), c(c = "a", d = "a"))
})

test_that("negative index removes values", {
  vars <- letters[1:3]

  expect_equal(vars_select(vars, -c), c(a = "a", b = "b"))
  expect_equal(vars_select(vars, a:c, -c), c(a = "a", b = "b"))
  expect_equal(vars_select(vars, a, b, c, -c), c(a = "a", b = "b"))
  expect_equal(vars_select(vars, -c, a, b), c(a = "a", b = "b"))
})

test_that("can select with character vectors", {
  expect_identical(vars_select(letters, "b", !! "z", c("b", "c")), set_names(c("b", "z", "c")))
})

test_that("abort on unknown columns", {
  expect_error(vars_select(letters, "foo"), class = "tidyselect_error_index_oob_names")
  expect_error(vars_select(letters, c("a", "bar", "foo", "d")), class = "tidyselect_error_index_oob_names")
})

test_that("data mask is not isolated from context (for now)", {
  foo <- 10
  expect_identical(vars_select(letters, foo), c(j = "j"))
  expect_identical(vars_select(letters, ((foo))), c(j = "j"))
})

test_that("symbol overscope works with parenthesised expressions", {
  expect_identical(vars_select(letters, ((((a)):((w))))), vars_select(letters, a:w))
  expect_identical(vars_select(letters, -((((a)):((y))))), c(z = "z"))
})

test_that("can select with unnamed elements", {
  expect_identical(vars_select(c("a", ""), a), c(a = "a"))
  expect_identical(vars_select(c("a", NA), a), c(a = "a"))
  expect_identical(vars_select(c("", "a"), a), c(a = "a"))
  expect_identical(vars_select(c(NA, "a"), a), c(a = "a"))
})

test_that("can customise error messages", {
  vars <- structure(letters, type = c("variable", "variables"))
  expect_error(vars_select(vars, "foo"), class = "tidyselect_error_index_oob_names")
  expect_warning(vars_select(vars, one_of("bim")), "Unknown variables:")
  expect_error(vars_rename(vars, A = "foo"), class = "tidyselect_error_index_oob_names")
})

test_that("can supply empty inputs", {
  empty_vars <- set_names(chr())
  expect_identical(vars_select(letters), empty_vars)
  expect_identical(vars_select(letters, NULL), empty_vars)
  expect_identical(vars_select(letters, chr()), empty_vars)

  expect_identical(vars_select(letters, a, NULL), c(a = "a"))
  expect_identical(vars_select(letters, a, chr()), c(a = "a"))
})

test_that("empty selection signals a condition", {
  expect_is(catch_cnd(vars_select(letters)), "tidyselect_empty_dots")
  expect_is(catch_cnd(vars_select(letters, starts_with("1"))), "tidyselect_empty")
})

test_that("unknown variables errors are ignored if `.strict` is FALSE", {
  expect_identical(vars_select(letters, `_foo`, .strict = FALSE), set_names(chr()))
  expect_identical(vars_select(letters, a, `_foo`, .strict = FALSE), c(a = "a"))
  expect_identical(vars_select(letters, a, "_foo", .strict = FALSE), c(a = "a"))

  expect_identical(vars_select(letters, a, -`_foo`, .strict = FALSE), c(a = "a"))
  expect_identical(vars_select(letters, a, -"`_foo`", .strict = FALSE), c(a = "a"))

  expect_identical(vars_select(letters, c(a, `_foo`, c), .strict = FALSE), c(a = "a", c = "c"))
  expect_identical(vars_select(letters, c(a, "_foo", c), .strict = FALSE), c(a = "a", c = "c"))
})

test_that("`:` handles strings", {
  expect_identical(vars_select(letters, "b":"d"), vars_select(letters, b:d))
  expect_error(vars_select(letters, "b":"Z"), class = "tidyselect_error_index_oob_names")
})

test_that("`-` handles strings", {
  expect_identical(vars_select(letters, -"c"), vars_select(letters, -c))
})

test_that("`-` handles positions", {
  expect_identical(vars_select(letters, 10 - 7), vars_select(letters, 3))
})

test_that("`-` handles character vectors (#35)", {
  expect_identical(vars_select(letters, - (!! letters[1:20])), vars_select(letters, -(1:20)))
  expect_error(vars_select(letters, - c("foo", "z", "bar")), class = "tidyselect_error_index_oob_names")
})

test_that("can select `c` despite overscoped c()", {
  expect_identical(vars_select(letters, c), c(c = "c"))
})

test_that("vars_select() handles named character vectors", {
  expect_identical(vars_select(letters, c("A" = "y", "B" = "z")), vars_select(letters, A = y, B = z))
  expect_identical(vars_select(letters, !! c("A" = "y", "B" = "z")), vars_select(letters, A = y, B = z))
})

test_that("can select with length > 1 double vectors (#43)", {
  expect_identical(vars_select(letters, !!c(1, 2)), c(a = "a", b = "b"))
})

test_that("missing values are detected in vars_select() (#72)", {
  expect_error(vars_select("foo", na_cpl), class = "tidyselect_error_index_bad_type")

  expect_error(
    vars_select(letters, NA, c(1, NA), !!na_chr, !!na_int, !!na_dbl),
    glue(
      "* NA
       * c(1, NA)
       * NA_character_
       * NA_integer_
       * NA_real_"
    ),
    fixed = TRUE
  )
})

test_that("can use helper within c() (#91)", {
  expect_identical(
    vars_select(letters, c(B = z, everything())),
    vars_select(letters, B = z, everything())
  )
})

test_that("vars_select() supports S3 vectors (#109)", {
  expect_identical(vars_select(letters, !!factor(c("a", "c"))), c(a = "a", c = "c"))
})

test_that("vars_select() type-checks inputs", {
  expect_error(
    vars_select(letters, TRUE),
    class = "tidyselect_error_index_bad_type"
  )
  expect_error(
    vars_select(letters, 2.5),
    class = "tidyselect_error_index_bad_type"
  )
  expect_error(
    vars_select(letters, structure(1:3, class = "tidysel_foobar")),
    class = "tidyselect_error_index_bad_type"
  )

  verify_output(test_path("outputs", "vars-select-index-type.txt"), {
    vars_select(letters, TRUE)
    vars_select(letters, 2.5)
    vars_select(letters, structure(1:3, class = "tidysel_foobar"))
  })
})

test_that("can rename and select at the same time", {
  expect_identical(vars_select(letters, c(1, a = 1, 1)), c(a = "a"))
})

test_that("vars_select() supports redundantly named vectors", {
  expect_identical(vars_select(c("a", "b", "a"), b), c(b = "b"))
  expect_error(vars_select(c("a", "b", "a"), a), class = "tidyselect_error_names_must_be_unique")
  expect_error(vars_select(c("a", "b", "a"), a, b), class = "tidyselect_error_names_must_be_unique")
  expect_error(vars_select(c("a", "b", "a"), b, a), class = "tidyselect_error_names_must_be_unique")
  expect_error(vars_select(c("a", "b", "a"), c(b, a)), class = "tidyselect_error_names_must_be_unique")
  expect_error(vars_select(c("a", "b", "a"), !!c(2, 1, 3)), class = "tidyselect_error_names_must_be_unique")
})

test_that("select helpers support redundantly named vectors", {
  expect_error(vars_select(c("a", "b", "a"), everything()), class = "tidyselect_error_names_must_be_unique")
  expect_error(vars_select(c("a", "b", "a"), starts_with("a")), class = "tidyselect_error_names_must_be_unique")
  expect_error(vars_select(c("a", "b", "a"), one_of(c("b", "a"))), class = "tidyselect_error_names_must_be_unique")
  expect_error(vars_select(c("a1", "b", "a1", "a2"), b, num_range("a", 1:2)), class = "tidyselect_error_names_must_be_unique")
})

test_that("vars_select() uses unique name spec", {
  expect_identical(
    vars_select(names(iris), petal = starts_with("Petal")),
    c(petal1 = "Petal.Length", petal2 = "Petal.Width")
  )
  expect_identical(
    vars_select(names(iris), petal = c(foo = starts_with("Petal"))),
    c(petal...foo1 = "Petal.Length", petal...foo2 = "Petal.Width")
  )
})

test_that("vars_select() can drop duplicate names by position (#94)", {
  expect_identical(vars_select(c("a", "b", "a"), 2), c(b = "b"))
  expect_identical(vars_select(c("a", "b", "a"), -3), c(a = "a", b = "b"))
  expect_identical(vars_select(c("a", "b", "a"), -1), c(b = "b", a = "a"))
})

test_that("vars_select() can rename variables", {
  expect_identical(vars_select(letters[1:2], a = b), c(a = "b"))
  expect_identical(vars_select(letters[1:2], a = b, b = a), c(a = "b", b = "a"))
  expect_identical(vars_select(letters[1:2], a = b, a = b), c(a = "b"))
})

test_that("vars_select() can select out existing duplicates", {
  expect_identical(vars_select(c("a", "b", "a"), b), c(b = "b"))
  expect_identical(vars_select(c("a", "b", "a"), a = b), c(a = "b"))
})

test_that("vars_select() cannot rename existing duplicates", {
  expect_error(vars_select(c("a", "b", "a"), b = a, a = b), class = "tidyselect_error_names_must_be_unique")
  expect_error(vars_select(c("a", "b", "a"), a = b, b = a), class = "tidyselect_error_names_must_be_unique")
})

test_that("vars_select() fails when renaming to existing name", {
  expect_error(vars_select(letters[1:2], a, a = b), class = "tidyselect_error_names_must_be_unique")
})

test_that("vars_select() fails when renaming to same name", {
  expect_error(vars_select(letters[1:3], a = b, a = c), class = "tidyselect_error_names_must_be_unique")
  expect_error(vars_select(letters[1:2], A = a, A = b), class = "tidyselect_error_names_must_be_unique")
})

test_that("vars_select() fails informatively when renaming to same", {
  skip("FIXME")
  verify_output(test_path("outputs", "vars-select-renaming-to-same.txt"), {
    "Renaming to same:"
    vars_select(letters, foo = a, bar = b, foo = c, ok = d, bar = e)

    "Renaming to existing:"
    vars_select(letters, a = b, ok = c, d = e, everything())
  })
})

test_that("vars_select() has consistent position errors", {
  expect_error(vars_select(letters, foo), class = "tidyselect_error_index_oob_names")
  expect_error(vars_select(letters, -foo), class = "tidyselect_error_index_oob_names")
  expect_error(vars_select(letters, 100), class = "tidyselect_error_index_oob_positions")
  expect_error(vars_select(letters, -100), class = "tidyselect_error_index_oob_positions")

  verify_output(test_path("outputs", "vars-select-oob-errors.txt"), {
    "Bare names"
    vars_select(letters, foo)
    vars_select(letters, -foo)

    "Names"
    vars_select(letters, "foo")
    vars_select(letters, a:"foo")

    "Positions"
    vars_select(letters, 30, 50, 100)
    vars_select(letters, -100)
  })
})

test_that("vars_select() consistently handles nested negated arguments", {
  expect_identical(
    vars_select(letters, -all_of(chr())),
    set_names(letters)
  )
  expect_identical(
    vars_select(letters, c(-all_of(chr()))),
    set_names(letters)
  )
})
