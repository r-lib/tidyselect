
test_that("rename_pos() requires named vectors", {
  expect_error(
    rename_pos(letters, c(foo = a)),
    "unnamed vector"
  )
})

test_that("rename_pos() partially renames", {
  expect_identical(
    rename_pos(mtcars[1:3], c(foo = cyl, bar = disp)),
    int(mpg = 1, foo = 2, bar = 3)
  )
})

test_that("rename_pos() allows renaming to self", {
  expect_identical(
    rename_pos(mtcars[1:3], c(mpg = mpg, cyl = cyl)),
    int(mpg = 1, cyl = 2, disp = 3)
  )
})

test_that("rename_pos() always preserves order", {
  expect_identical(
    rename_pos(mtcars[1:3], c(disp = disp, cyl = cyl, mpg = mpg)),
    int(mpg = 1, cyl = 2, disp = 3)
  )
})

test_that("rename_pos() partially renames", {
  expect_identical(
    rename_pos(mtcars[1:3], c(foo = cyl, bar = disp)),
    int(mpg = 1, foo = 2, bar = 3)
  )
})

test_that("rename_pos() requires unique names", {
  expect_error(
    rename_pos(mtcars[1:3], c(foo = cyl, foo = disp)),
    class = "tidyselect_error_names_must_be_unique"
  )
  expect_error(
    rename_pos(mtcars[1:3], c(cyl = mpg, foo = disp)),
    class = "tidyselect_error_names_must_be_unique"
  )
})

test_that("rename_pos() disambiguates if necessary", {
  expect_identical(
    rename_pos(mtcars[1:3], c(foo = starts_with(c("c", "d")))),
    int(mpg = 1, foo1 = 2, foo2 = 3)
  )
  expect_identical(
    rename_pos(unclass(mtcars[1:3]), c(foo = starts_with(c("c", "d")))),
    int(mpg = 1, foo = 2, foo = 3)
  )
})

test_that("rename_pos() allows renaming to existing variable that is also renamed", {
  expect_identical(
    rename_pos(mtcars[1:3], c(cyl = mpg, foo = cyl)),
    int(cyl = 1, foo = 2, disp = 3)
  )
})

test_that("rename_pos() allows fixing duplicates by position", {
  dups <- vctrs::new_data_frame(list(x = 1, x = 2))
  expect_identical(
    rename_pos(dups, c(foo = 2L)),
    int(x = 1, foo = 2)
  )
})

test_that("rename_pos() throws helpful errors", {
  verify_output(test_path("outputs", "rename-errors.txt"), {
    "Unnamed vector"
    rename_pos(letters, c(foo = a))

    "Duplicate names (FIXME)"
    rename_pos(mtcars[1:3], c(foo = cyl, foo = disp))
  })
})
