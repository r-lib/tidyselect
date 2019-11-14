#' @import rlang
#' @importFrom glue glue
#' @importFrom purrr discard map map_chr map_if map_lgl map2 map2_chr
#'   detect_index negate walk every compact
#' @keywords internal
"_PACKAGE"


maybe_hotpatch_dplyr <- function(...) {
  if (!isNamespaceLoaded("dplyr")) {
    return(FALSE)
  }
  if (utils::packageVersion("dplyr") > "0.7.4") {
    return(FALSE)
  }

  fns <- list(
    current_vars = peek_vars,
    set_current_vars = poke_vars
  )
  env <- ns_env("dplyr")
  nms <- names(fns)

  for (i in seq_along(fns)) {
    hotpatch_binding(nms[[i]], fns[[i]], env)
  }

  TRUE
}
hotpatch_binding <- function(binding, fn, env) {
  unlock <- env_get(base_env(), "unlockBinding")
  unlock(binding, env)

  env_bind(env, !! binding := fn)

  lock <- env_get(base_env(), "lockBinding")
  lock(binding, env = env)
}

.onLoad <- function(...) {
  maybe_hotpatch_dplyr()
  setHook(packageEvent("dplyr", "onLoad"), maybe_hotpatch_dplyr)
}
