
subclass_index_errors <- function(expr) {
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
      stop_index_bad_type(parent = cnd)
    }
  )
}

stop_index_bad_type <- function(..., .subclass = NULL) {
  stop_index(
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
cnd_issue.tidyselect_error_index_bad_type <- function(c) {
  "Must select with column names or positions."
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
