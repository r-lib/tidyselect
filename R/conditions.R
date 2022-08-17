with_subscript_errors <- function(expr,
                                  type = "select",
                                  call = caller_env()) {
  try_fetch(
    expr,
    vctrs_error_subscript = function(cnd) {
      cnd$subscript_action <- subscript_action(type)
      cnd$subscript_elt <- "column"
      cnd_signal(cnd)
    }
  )
}

with_chained_errors <- function(expr, action, call, eval_expr = NULL) {
  try_fetch(
    expr,
    error = function(cnd) {
      eval_expr <- quo_squash(eval_expr)
      # Only display a message if there's useful context to add
      if (!is_call(eval_expr) || identical(cnd[["call"]], call2(eval_expr[[1]])) ) {
        msg <- ""
      } else {
        code <- as_label(eval_expr)
        msg <- cli::format_inline("Problem while evaluating {.code {code}}.")
      }
      abort(msg, call = call, parent = cnd)
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
    cli::cli_abort("Unexpected value for {.arg tidyselect_type}.", .internal = TRUE)
  }
  type
}
