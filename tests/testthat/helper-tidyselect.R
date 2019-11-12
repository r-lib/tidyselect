
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
