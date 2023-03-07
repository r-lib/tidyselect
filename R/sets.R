
# The `sel_` prefixed operations match on both values and names, with
# unnamed elements matching named ones
sel_union <- function(x, y) {
  if (any_valid_names(names(x)) || any_valid_names(names(y))) {
    sel_operation(x, y, set_union)
  } else {
    set_union(x, y)
  }
}
sel_intersect <- function(x, y) {
  if (any_valid_names(names(x)) || any_valid_names(names(y))) {
    sel_operation(x, y, set_intersect)
  } else {
    set_intersect(x, y)
  }
}
sel_unique <- function(x) {
  if (any_valid_names(names(x))) {
    x <- vctrs::new_data_frame(list(value = x, names = names2(x)))
    x <- propagate_names(x)
    out <- vctrs::vec_unique(x)
    set_names(out$value, out$names)
  } else {
    vctrs::vec_unique(x)
  }
}

# Set difference and set complement must validate their RHS eagerly,
# otherwise OOB elements might be selected out and go unnoticed
sel_diff <- function(x, y, vars = NULL, error_call = caller_env()) {
  if (!is_null(vars)) {
    y <- loc_validate(y, vars, call = error_call)
  }
  if (any_valid_names(names(x)) && any_valid_names(names(y))) {
    sel_operation(x, y, set_diff)
  } else {
    set_diff(x, y)
  }
}
sel_complement <- function(x, vars = NULL, error_call = caller_env()) {
  sel_diff(seq_along(vars), x, vars, error_call = error_call)
}

sel_operation <- function(x, y, sel_op) {
  x <- vctrs::new_data_frame(list(value = x, names = names2(x)))
  y <- vctrs::new_data_frame(list(value = y, names = names2(y)))

  x <- propagate_names(x, y)
  y <- propagate_names(y, x)

  out <- sel_op(x, y)
  set_names(out$value, out$names)
}
propagate_names <- function(x, from = NULL) {
  unnamed <- x$names == ""
  if (!any(unnamed)) {
    return(x)
  }

  # Match names inside `x` first, so we preserve order
  from <- vctrs::vec_c(x, from)

  # Prevent unnamed elements from matching
  vctrs::vec_slice(from$value, from$names == "") <- NA

  matches <- match(
    x$value[unnamed],
    from$value,
    nomatch = 0L
  )
  x$names[unnamed][matches != 0L] <- from$names[matches]

  x
}

# https://github.com/r-lib/vctrs/issues/548
set_diff <- function(x, y) {
  vctrs::vec_unique(vctrs::vec_slice(x, !vctrs::vec_in(x, y)))
}
set_intersect <- function(x, y) {
  pos <- vctrs::vec_match(y, x)
  pos <- vctrs::vec_unique(pos)
  pos <- vctrs::vec_sort(pos)
  pos <- pos[!is.na(pos)]
  vctrs::vec_slice(x, pos)
}
set_union <- function(x, y) {
  vctrs::vec_unique(vctrs::vec_c(x, y))
}
