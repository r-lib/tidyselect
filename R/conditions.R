
subclass_index_errors <- function(expr, allow_positions = TRUE, type = "select") {
  tryCatch(
    sanitise_base_errors(expr),
    vctrs_error_index_oob_names = function(cnd) {
      stop_index_oob(
        tidyselect_type = type,
        parent = cnd,
        .subclass = "tidyselect_error_index_oob_names"
      )
    },
    vctrs_error_index_oob_positions = function(cnd) {
      stop_index_oob(
        tidyselect_type = type,
        parent = cnd,
        .subclass = "tidyselect_error_index_oob_positions"
      )
    },
    vctrs_error_index = function(cnd) {
      stop_index_bad_type(
        tidyselect_type = type,
        parent = cnd,
        allow_positions = allow_positions
      )
    },
    vctrs_error_names_must_be_unique = function(cnd) {
      stop_names_must_be_unique(
        tidyselect_type = type,
        parent = cnd
      )
    }
  )
}
sanitise_base_errors <- function(expr) {
  withCallingHandlers(
    expr,
    simpleError = function(cnd) {
      # Pass `cnd` as parent to ensure proper backtraces
      abort(conditionMessage(cnd), parent = cnd)
    }
  )
}

stop_index_bad_type <- function(..., allow_positions = TRUE, .subclass = NULL) {
  stop_index(
    allow_positions = allow_positions,
    ...,
    .subclass = c(.subclass, "tidyselect_error_index_bad_type")
  )
}
stop_index_oob <- function(..., .subclass = NULL) {
  stop_index(
    ...,
    .subclass = c(.subclass, "tidyselect_error_index_oob")
  )
}
stop_index <- function(..., .subclass = NULL) {
  abort(
    ...,
    .subclass = c(.subclass, "tidyselect_error_index")
  )
}

#' @export
cnd_issue.tidyselect_error_index_bad_type <- function(cnd, ...) {
  switch(tidyselect_type(cnd),
    select = cnd_issue_index_bad_type_select(cnd, ...),
    rename = cnd_issue_index_bad_type_rename(cnd, ...)
  )
}
cnd_issue_index_bad_type_select <- function(cnd, ...) {
  if (cnd$allow_positions) {
    "Must select with column names or positions."
  } else {
    "Must select with column names."
  }
}
cnd_issue_index_bad_type_rename <- function(cnd, ...) {
  if (cnd$allow_positions) {
    "Must rename with column names or positions."
  } else {
    "Must rename with column names."
  }
}

#' @export
cnd_bullets.tidyselect_error_index_bad_type <- function(cnd, ...) {
  cnd_bullets(cnd$parent)
}

#' @export
cnd_issue.tidyselect_error_index_oob <- function(cnd, ...) {
  switch(tidyselect_type(cnd),
    select = "Must select existing columns.",
    rename = "Must rename existing columns."
  )
}
#' @export
cnd_bullets.tidyselect_error_index_oob <- function(cnd, ...) {
  cnd_bullets(cnd$parent)
}

stop_names_must_be_unique <- function(..., class = NULL) {
  abort(
    .subclass = c(class, "tidyselect_error_names_must_be_unique"),
    ...
  )
}
#' @export
cnd_issue.tidyselect_error_names_must_be_unique <- function(cnd, ...) {
  "Names must be unique."
}

tidyselect_type <- function(cnd) {
  type <- cnd$tidyselect_type

  # We might add `recode` in the future
  if (!is_string(type, c("select", "rename"))) {
    abort("Internal error: unexpected value for `tidyselect_type`")
  }

  type
}
