
# The `sel_` prefixed operations match on both values and names, with
# unnamed elements matching named ones
sel_union <- function(x, y) {
  if (is_null(names(x)) && is_null(names(y))) {
    set_union(x, y)
  } else {
    sel_operation(x, y, set_union)
  }
}
sel_intersect <- function(x, y) {
  if (is_null(names(x)) && is_null(names(y))) {
    set_intersect(x, y)
  } else {
    sel_operation(x, y, set_intersect)
  }
}
sel_unique <- function(x) {
  x <- vctrs::new_data_frame(list(value = x, names = names2(x)))
  x <- propagate_names(x)

  out <- vctrs::vec_unique(x)
  set_names(out$value, out$names)
}

# Set difference and set complement must validate their RHS eagerly,
# otherwise OOB elements might be selected out and go unnoticed
sel_diff <- function(x, y, vars = NULL) {
  if (!is_null(vars)) {
    y <- loc_validate(y, vars)
  }
  if (is_null(names(x)) || is_null(names(y))) {
    set_diff(x, y)
  } else {
    sel_operation(x, y, set_diff)
  }
}
sel_complement <- function(x, vars = NULL) {
  sel_diff(seq_along(vars), x, vars)
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
