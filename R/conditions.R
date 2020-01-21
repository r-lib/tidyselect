
with_subscript_errors <- function(expr, type = "select") {
  tryCatch(
    instrument_base_errors(expr),

    vctrs_error_subscript = function(cnd) {
      cnd$subscript_action <- subscript_action(type)
      cnd$subscript_elt <- "column"
      cnd_signal(cnd)
    }
  )
}
instrument_base_errors <- function(expr) {
  withCallingHandlers(
    expr,
    simpleError = function(cnd) {
      # Pass `cnd` as parent to ensure proper backtraces
      abort(conditionMessage(cnd), parent = cnd)
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
