
subclass_index_errors <- function(expr, allow_positions = TRUE) {
  tryCatch(
    expr,
    vctrs_error_index_oob = function(cnd) {
      if (inherits(cnd, "vctrs_error_index_oob_names")) {
        subclass <- "tidyselect_error_index_oob_names"
      } else {
        subclass <- "tidyselect_error_index_oob_positions"
      }
      stop_index_oob(parent = cnd, .subclass = subclass)
    },
    vctrs_error_index = function(cnd) {
      stop_index_bad_type(parent = cnd, allow_positions = allow_positions)
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
  if (cnd$allow_positions) {
    "Must select with column names or positions."
  } else {
    "Must select with column names."
  }
}
#' @export
cnd_bullets.tidyselect_error_index_bad_type <- function(c) {
  cnd_bullets(c$parent)
}

#' @export
cnd_issue.tidyselect_error_index_oob <- function(c) {
  "Must select existing columns."
}
#' @export
cnd_bullets.tidyselect_error_index_oob <- function(c) {
  cnd_bullets(c$parent)
}
