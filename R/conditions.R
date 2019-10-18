
subclass_index_errors <- function(expr) {
  tryCatch(
    expr,
    vctrs_error_index_oob_names = function(cnd) {
      stop_index_oob(parent = cnd, .subclass = "tidyselect_error_index_oob_names")
    },
    vctrs_error_index_oob_positions = function(cnd) {
      stop_index_oob(parent = cnd, .subclass = "tidyselect_error_index_oob_positions")
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
