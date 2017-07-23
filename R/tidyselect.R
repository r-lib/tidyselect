#' @import rlang
#' @importFrom glue glue
#' @importFrom Rcpp cppFunction
#' @useDynLib tidyselect, .registration = TRUE
"_PACKAGE"


maybe_overtake_dplyr <- function(...) {
  if (!is_installed("dplyr")) {
    return(FALSE)
  }

  # Check whether dplyr already uses tidyselect
  dplyr_contains <- ns_imports_env("dplyr")$contains
  if (!is_null(dplyr_contains) && ns_env_name(dplyr_contains) == "tidyselect") {
    return(FALSE)
  }

  fns <- list(
    current_vars = peek_vars,
    set_current_vars = poke_vars
  )
  env <- ns_env("dplyr")
  nms <- names(fns)

  for (i in seq_along(fns)) {
    overtake_binding(nms[[i]], fns[[i]], env)
  }

  TRUE
}

overtake_binding <- function(binding, fn, env) {
  unlock <- env_get(base_env(), "unlockBinding")
  unlock(binding, env)

  env_bind(env, !! binding := fn)

  lock <- env_get(base_env(), "lockBinding")
  lock(binding, env = env)
}

.onLoad <- function(...) {
  maybe_overtake_dplyr()
  setHook(packageEvent("dplyr", "onLoad"), maybe_overtake_dplyr)
}
