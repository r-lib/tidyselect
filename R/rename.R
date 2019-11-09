
rename_pos <- function(x,
                       sel,
                       ...,
                       strict = TRUE,
                       name_spec = NULL) {
  ellipsis::check_dots_empty()
  vctrs::vec_assert(x)

  rename_impl(
    x,
    names(x),
    {{ sel }},
    strict = strict,
    name_spec = name_spec
  )
}

# Caller must put vars in scope
rename_impl <- function(x,
                        names,
                        sel,
                        strict = TRUE,
                        name_spec = NULL) {
  if (is_null(names)) {
    abort("Can't rename an unnamed vector.")
  }

  pos <- select_impl(
    x,
    names,
    {{ sel }},
    strict = strict,
    name_spec = name_spec
  )

  seq <- set_names(seq_along(names), names)
  names(seq)[pos] <- names(pos)

  # Check for unique names only if input is a data frame
  if (is.data.frame(x) || is_null(x)) {
    subclass_index_errors(
      vctrs::vec_as_names(names(seq), repair = "check_unique")
    )
  }

  seq
}

# Example implementation mainly used for unit tests
rename <- function(.x, ..., .strict = TRUE) {
  pos <- rename_pos(.x, c(...), strict = .strict)
  set_names(.x[pos], names(pos))
}
