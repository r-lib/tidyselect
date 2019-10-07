context("select vars")

test_that("vars_select can rename variables", {
  vars <- c("a", "b")
  expect_equal(vars_select(vars, b = a, a = b), c("b" = "a", "a" = "b"))
})

test_that("last rename wins", {
  vars <- c("a", "b")
  expect_equal(
    expect_warning(
      vars_select(vars, c = a, d = a),
      "being renamed to \`c\` and \`d\`",
      fixed = TRUE
    ),
    c("d" = "a")
  )
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
  expect_error(vars_select(letters, "foo"), "Unknown column `foo`")
  expect_error(vars_select(letters, c("a", "bar", "foo", "d")), "`bar`")
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

  expect_error(vars_select(vars, "foo"), "Unknown variable `foo`")
  expect_warning(vars_select(vars, one_of("bim")), "Unknown variables:")
  expect_error(vars_rename(vars, A = "foo"), "Unknown variable `foo`")
  expect_error(vars_pull(vars, !! c("a", "b")), "or a variable name")
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
  expect_error(vars_select(letters, "b":"Z"), "Unknown column `Z`")
})

test_that("`-` handles strings", {
  expect_identical(vars_select(letters, -"c"), vars_select(letters, -c))
})

test_that("`-` handles positions", {
  expect_identical(vars_select(letters, 10 - 7), vars_select(letters, 3))
})

test_that("`-` handles character vectors (#35)", {
  expect_identical(vars_select(letters, - (!! letters[1:20])), vars_select(letters, -(1:20)))
  expect_error(vars_select(letters, - c("foo", "z", "bar")), "Unknown column `foo`")
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
  expect_error(vars_select("foo", NA), "detected missing elements")

  expect_error(
    vars_select(letters, c(1, NA), !!na_chr, !!na_int, !!na_dbl, !!na_cpl),
    glue(
      "* c(1, NA)
       * NA_character_
       * NA_integer_
       * NA_real_
       * NA_complex_"
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

  expect_error(
    vars_select(letters, structure(1:3, class = "tidysel_foobar")),
    class = "tidyselect_error_incompatible_index_type"
  )
})

test_that("can rename and select at the same time", {
  expect_identical(vars_select(letters, c(1, a = 1, 1)), c(a = "a"))
})

test_that("vars_select() supports redundantly named vectors", {
  expect_identical(vars_select(c("a", "b", "a"), b), c(b = "b"))
  expect_identical(vars_select(c("a", "b", "a"), a), c(a = "a", a = "a"))
  expect_identical(vars_select(c("a", "b", "a"), a, b), c(a = "a", a = "a", b = "b"))
  expect_identical(vars_select(c("a", "b", "a"), b, a), c(b = "b", a = "a", a = "a"))
  expect_identical(vars_select(c("a", "b", "a"), c(b, a)), c(b = "b", a = "a", a = "a"))
  expect_identical(vars_select(c("a", "b", "a"), !!c(2, 1, 3)), c(b = "b", a = "a", a = "a"))
})

test_that("select helpers support redundantly named vectors", {
  expect_identical(vars_select(c("a", "b", "a"), everything()), c(a = "a", b = "b", a = "a"))
  expect_identical(vars_select(c("a", "b", "a"), starts_with("a")), c(a = "a", a = "a"))
  expect_identical(vars_select(c("a", "b", "a"), one_of(c("b", "a"))), c(b = "b", a = "a", a = "a"))
  expect_identical(vars_select(c("a1", "b", "a1", "a2"), b, num_range("a", 1:2)), c(b = "b", a1 = "a1", a1 = "a1", a2 = "a2"))
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

test_that("vars_select() can rename existing duplicates", {
  expect_identical(vars_select(c("a", "b", "a"), b = a, a = b), c(b = "a", b = "a", a = "b"))
  expect_identical(vars_select(c("a", "b", "a"), a = b, b = a), c(a = "b", b = "a", b = "a"))
})

test_that("vars_select() fails when renaming to existing name", {
  expect_error(vars_select(letters[1:2], a, a = b), class = "tidyselect_error_rename_to_existing")
})

test_that("vars_select() fails when renaming to same name", {
  expect_error(vars_select(letters[1:3], a = b, a = c), class = "tidyselect_error_rename_to_same")
  expect_error(vars_select(letters[1:2], A = a, A = b), class = "tidyselect_error_rename_to_same")
})

test_that("vars_select() fails informatively when renaming to same", {
  verify_output(test_path("outputs", "vars-select-renaming-to-same.txt"), {
    "Renaming to same:"
    vars_select(letters, foo = a, bar = b, foo = c, ok = d, bar = e)

    "Renaming to existing:"
    vars_select(letters, a = b, ok = c, d = e, everything())
  })
})

test_that("vars_select() has consistent position errors", {
  expect_error(vars_select(letters, foo), class = "vctrs_error_index_oob_names")
  expect_error(vars_select(letters, -foo), class = "vctrs_error_index_oob_names")

  verify_output(test_path("outputs", "vars-select-oob-errors.txt"), {
    "Bare names"
    vars_select(letters, foo)
    vars_select(letters, -foo)
  })
})
