test_that("eval_*() respects proxy settings", {
  foo <- structure(list(), class = "foo")
  local_bindings(
    tidyselect_data_proxy.foo = function(x) {
      data.frame(x = 1, y = 2)
    },
    tidyselect_data_supports_predicates.foo = function(x) {
      FALSE
    }
  )

  expect_equal(eval_relocate(quote(everything()), foo), c(x = 1, y = 2))
  expect_equal(eval_select(quote(everything()), foo), c(x = 1, y = 2))
  expect_equal(eval_rename(quote(c(x = everything())), foo), c(x1 = 1, x2 = 2))

  expect_snapshot(error = TRUE, {
    eval_relocate(quote(where(is.numeric)), foo)
    eval_select(quote(where(is.numeric)), foo)
    eval_rename(quote(c(x = where(is.numeric))), foo)
  })
})
