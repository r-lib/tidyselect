
test_that("rename_pos() requires named vectors", {
  expect_error(
    rename_pos(letters, c(foo = a)),
    "unnamed vector"
  )
})

test_that("rename_pos() partially renames", {
  expect_identical(
    rename_pos(mtcars, c(foo = cyl, bar = disp)),
    int(foo = 2, bar = 3)
  )
})

test_that("rename_pos() allows renaming to self", {
  expect_identical(
    rename_pos(mtcars, c(mpg = mpg, cyl = cyl)),
    int(mpg = 1, cyl = 2)
  )
})

test_that("rename() always preserves order", {
  expect_identical(
    rename(mtcars, c(disp = disp, cyl = cyl, mpg = mpg)),
    mtcars
  )
})

test_that("rename_pos() partially renames", {
  expect_identical(
    rename_pos(mtcars, c(foo = cyl, bar = disp)),
    int(foo = 2, bar = 3)
  )
})

test_that("rename_pos() requires unique names", {
  expect_error(
    rename_pos(mtcars, c(foo = cyl, foo = disp)),
    class = "tidyselect_error_names_must_be_unique"
  )
  expect_error(
    rename_pos(mtcars, c(cyl = mpg, foo = disp)),
    class = "tidyselect_error_names_must_be_unique"
  )
})

test_that("rename_pos() disambiguates if necessary", {
  expect_identical(
    rename_pos(mtcars, c(foo = starts_with("d"))),
    int(foo1 = 3, foo2 = 5)
  )
  expect_identical(
    rename_pos(unclass(mtcars), c(foo = starts_with("d"))),
    int(foo = 3, foo = 5)
  )
})

test_that("rename_pos() allows renaming to existing variable that is also renamed", {
  expect_identical(
    rename_pos(mtcars, c(cyl = mpg, foo = cyl)),
    int(cyl = 1, foo = 2)
  )
})

test_that("rename_pos() allows fixing duplicates by position", {
  dups <- vctrs::new_data_frame(list(x = 1, x = 2))
  expect_identical(
    rename_pos(dups, c(foo = 2L)),
    int(foo = 2)
  )
})

test_that("rename_pos() requires named inputs", {
  expect_error(rename_pos(iris, Species), "named")
  expect_error(rename_pos(iris, c(contains("Width"))), "named")
})

test_that("rename_pos() uses names inside c()", {
  expect_identical(rename_pos(iris, c(foo = Species)), c(foo = 5L))
})

test_that("rename_pos() throws helpful errors", {
  verify_output(test_path("outputs", "rename-errors.txt"), {
    "Unnamed vector"
    rename_pos(letters, c(foo = a))

    "Duplicate names (FIXME)"
    rename_pos(mtcars, c(foo = cyl, foo = disp))

    "Unnamed inputs"
    rename_pos(iris, Species)
  })
})
