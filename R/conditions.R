with_subscript_errors <- function(expr, type = "select") {
  tryCatch(
    with_entraced_errors(expr),

    vctrs_error_subscript = function(cnd) {
      cnd$subscript_action <- subscript_action(type)
      cnd$subscript_elt <- "column"
      cnd_signal(cnd)
    }
  )
}

with_entraced_errors <- function(expr) {
  try_fetch(
    expr,
    simpleError = function(cnd) {
      # TODO! `parent = NA`
      abort(
        conditionMessage(cnd),
        call = conditionCall(cnd)
      )
    }
  )
}

subscript_action <- function(type) {
  switch(validate_type(type),
    select = "subset",
    rename = "rename",
    pull = "extract"
  )
}
validate_type <- function(type) {
  # We might add `recode` in the future
  if (!is_string(type, c("select", "rename", "pull"))) {
    abort("Internal error: unexpected value for `tidyselect_type`")
  }
  type
}
