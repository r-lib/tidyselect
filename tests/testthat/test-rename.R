
test_that("rename_loc() requires named vectors", {
  expect_error(
    rename_loc(letters, c(foo = a)),
    "unnamed vector"
  )
})

test_that("rename_loc() partially renames", {
  expect_identical(
    rename_loc(mtcars, c(foo = cyl, bar = disp)),
    int(foo = 2, bar = 3)
  )
})

test_that("rename_loc() allows renaming to self", {
  expect_identical(
    rename_loc(mtcars, c(mpg = mpg, cyl = cyl)),
    int(mpg = 1, cyl = 2)
  )
})

test_that("rename() always preserves order", {
  expect_identical(
    rename(mtcars, c(disp = disp, cyl = cyl, mpg = mpg)),
    mtcars
  )
})

test_that("rename_loc() partially renames", {
  expect_identical(
    rename_loc(mtcars, c(foo = cyl, bar = disp)),
    int(foo = 2, bar = 3)
  )
})

test_that("rename_loc() requires unique names", {
  expect_error(
    rename_loc(mtcars, c(foo = cyl, foo = disp)),
    class = "vctrs_error_names_must_be_unique"
  )
  expect_error(
    rename_loc(mtcars, c(cyl = mpg, foo = disp)),
    class = "vctrs_error_names_must_be_unique"
  )
})

test_that("rename_loc() disambiguates if necessary", {
  expect_identical(
    rename_loc(mtcars, c(foo = starts_with("d"))),
    int(foo1 = 3, foo2 = 5)
  )
  expect_identical(
    rename_loc(unclass(mtcars), c(foo = starts_with("d"))),
    int(foo = 3, foo = 5)
  )
})

test_that("rename_loc() allows renaming to existing variable that is also renamed", {
  expect_identical(
    rename_loc(mtcars, c(cyl = mpg, foo = cyl)),
    int(cyl = 1, foo = 2)
  )
})

test_that("rename_loc() allows fixing duplicates by locations", {
  dups <- vctrs::new_data_frame(list(x = 1, x = 2))
  expect_identical(
    rename_loc(dups, c(foo = 2L)),
    int(foo = 2)
  )
})

test_that("rename_loc() requires named inputs", {
  expect_error(rename_loc(iris, Species), "named")
  expect_error(rename_loc(iris, c(contains("Width"))), "named")
})

test_that("rename_loc() uses names inside c()", {
  expect_identical(rename_loc(iris, c(foo = Species)), c(foo = 5L))
})

test_that("rename_loc() throws helpful errors", {
  verify_output(test_path("outputs", "rename-errors.txt"), {
    "Unnamed vector"
    rename_loc(letters, c(foo = a))

    "Duplicate names (FIXME)"
    rename_loc(mtcars, c(foo = cyl, foo = disp))

    "Unnamed inputs"
    rename_loc(iris, Species)
  })
})
