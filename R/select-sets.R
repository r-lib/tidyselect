
# The `sel_` prefixed operations match on both values and names, with
# unnamed elements matching named ones
sel_union <- function(x, y) {
  if (is_null(names(x)) && is_null(names(y))) {
    set_union(x, y)
  } else {
    sel_operation(x, y, set_union)
  }
}
sel_diff <- function(x, y) {
  if (is_null(names(x)) || is_null(names(y))) {
    set_diff(x, y)
  } else {
    sel_operation(x, y, set_diff)
  }
}
sel_intersect <- function(x, y) {
  if (is_null(names(x)) && is_null(names(y))) {
    set_intersect(x, y)
  } else {
    sel_operation(x, y, set_intersect)
  }
}

sel_operation <- function(x, y, sel_op) {
  x <- tibble::as_tibble(list(value = x, names = names2(x)))
  y <- tibble::as_tibble(list(value = y, names = names2(y)))

  x <- propagate_names(x, y)
  y <- propagate_names(y, x)

  out <- sel_op(x, y)
  set_names(out$value, out$names)
}
propagate_names <- function(x, y) {
  x_unnamed <- x$names == ""

  if (any(x_unnamed)) {
    matches <- match(
      x$value[x_unnamed],
      y$value[y$names != ""],
      nomatch = 0L
    )
    x$names[x_unnamed][matches != 0L] <- y$names[matches]
  }

  x
}

# https://github.com/r-lib/vctrs/issues/548
set_diff <- function(x, y) {
  vctrs::vec_slice(x, !vctrs::vec_in(x, y))
}
set_intersect <- function(x, y) {
  vctrs::vec_slice(x, na.omit(vctrs::vec_match(y, x)))
}
set_union <- function(x, y) {
  vctrs::vec_unique(vctrs::vec_c(x, y))
}
