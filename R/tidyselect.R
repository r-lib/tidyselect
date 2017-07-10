#' @import rlang
#' @importFrom glue glue
#' @importFrom Rcpp cppFunction
#' @useDynLib tidyselect, .registration = TRUE
"_PACKAGE"


fns_table <- function() {
  helpers_fns <- list(
    starts_with = starts_with,
    ends_with = ends_with,
    contains = contains,
    matches = matches,
    num_range = num_range,
    one_of = one_of,
    everything = everything
  )

  ui_fns <- list(
    current_vars = current_vars,
    select_vars = vars_select,
    rename_vars = vars_rename,
    select_var = vars_pull
  )

  c(helpers_fns, ui_fns)
}

maybe_overtake_dplyr <- function(...) {
  if (!"dplyr" %in% loadedNamespaces()) {
    return(FALSE)
  }
  if (utils::packageVersion("dplyr") >= "0.7.1.9001") {
    return(FALSE)
  }

  fns <- fns_table()
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
