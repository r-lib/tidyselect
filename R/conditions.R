
subclass_index_errors <- function(expr, allow_scalar_location = TRUE, type = "select") {
  tryCatch(
    sanitise_base_errors(expr),
    vctrs_error_subscript_oob_name = function(cnd) {
      stop_subscript_oob(
        tidyselect_type = type,
        parent = cnd,
        .subclass = "tidyselect_error_subscript_oob_name"
      )
    },
    vctrs_error_subscript_oob_location = function(cnd) {
      stop_subscript_oob(
        tidyselect_type = type,
        parent = cnd,
        .subclass = "tidyselect_error_subscript_oob_location"
      )
    },
    vctrs_error_subscript = function(cnd) {
      stop_subscript_bad_type(
        tidyselect_type = type,
        parent = cnd,
        allow_scalar_location = allow_scalar_location
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

stop_subscript_bad_type <- function(..., allow_scalar_location = TRUE, .subclass = NULL) {
  stop_subscript(
    allow_scalar_location = allow_scalar_location,
    ...,
    .subclass = c(.subclass, "tidyselect_error_subscript_bad_type")
  )
}
stop_subscript_oob <- function(..., .subclass = NULL) {
  stop_subscript(
    ...,
    .subclass = c(.subclass, "tidyselect_error_subscript_oob")
  )
}
stop_subscript <- function(..., .subclass = NULL) {
  abort(
    ...,
    .subclass = c(.subclass, "tidyselect_error_subscript")
  )
}

#' @export
cnd_header.tidyselect_error_subscript_bad_type <- function(cnd, ...) {
  switch(tidyselect_type(cnd),
    select = cnd_header_index_bad_type_select(cnd, ...),
    rename = cnd_header_index_bad_type_rename(cnd, ...)
  )
}
cnd_header_index_bad_type_select <- function(cnd, ...) {
  if (cnd$allow_scalar_location) {
    "Must select with column names or locations."
  } else {
    "Must select with column names."
  }
}
cnd_header_index_bad_type_rename <- function(cnd, ...) {
  if (cnd$allow_scalar_location) {
    "Must rename with column names or locations."
  } else {
    "Must rename with column names."
  }
}

#' @export
cnd_body.tidyselect_error_subscript_bad_type <- function(cnd, ...) {
  cnd_body(cnd$parent)
}

#' @export
cnd_header.tidyselect_error_subscript_oob <- function(cnd, ...) {
  switch(tidyselect_type(cnd),
    select = "Must select existing columns.",
    rename = "Must rename existing columns."
  )
}
#' @export
cnd_body.tidyselect_error_subscript_oob <- function(cnd, ...) {
  cnd_body(cnd$parent)
}

stop_names_must_be_unique <- function(..., class = NULL) {
  abort(
    .subclass = c(class, "tidyselect_error_names_must_be_unique"),
    ...
  )
}
#' @export
cnd_header.tidyselect_error_names_must_be_unique <- function(cnd, ...) {
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
