
#' @export
#' @rdname vars_select
vars_rename <- function(.vars, ..., .strict = TRUE) {
  pos <- rename_impl(
    NULL,
    .vars,
    c(...),
    strict = .strict
  )

  .vars <- set_names(.vars)
  names(.vars)[pos] <- names(pos)

  .vars
}
