
try2 <- function(what, expr, ...) {
  cat("> #", what, "\n")
  cat(">", deparse(substitute(expr)), "\n")
  cat("Error:", catch_cnd(expr, classes = "error")$message, "\n\n")
}
