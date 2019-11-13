
select_pos <- function(x,
                       sel,
                       ...,
                       include = NULL,
                       exclude = NULL,
                       strict = TRUE,
                       name_spec = NULL) {
  ellipsis::check_dots_empty()

  eval_select(
    enquo(sel),
    x,
    include = include,
    exclude = exclude,
    strict = strict,
    name_spec = name_spec
  )
}

rename_pos <- function(x,
                       sel,
                       ...,
                       strict = TRUE,
                       name_spec = NULL) {
  ellipsis::check_dots_empty()
  rename_impl(
    x,
    names(x),
    enquo(sel),
    strict = strict,
    name_spec = name_spec
  )
}
