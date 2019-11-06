
# The `sel_` prefixed operations match on both values and names, with
# unnamed elements matching named ones
sel_union <- function(x, y) {
  if (is_null(names(x)) && is_null(names(y))) {
    return(set_union(x, y))
  }

  x <- tibble::as_tibble(list(value = x, names = names2(x)))
  y <- tibble::as_tibble(list(value = y, names = names2(y)))

  x <- propagate_names(x, y)
  y <- propagate_names(y, x)

  out <- set_union(x, y)
  set_names(out$value, out$names)
}

sel_diff <- function(x, y) {
  x_nms <- names(x)
  y_nms <- names(y)

  if (is_null(x_nms) || is_null(y_nms)) {
    return(set_diff(x, y))
  }

  x <- tibble::as_tibble(list(value = x, names = x_nms))
  y <- tibble::as_tibble(list(value = y, names = y_nms))

  x <- propagate_names(x, y)
  y <- propagate_names(y, x)

  out <- set_diff(x, y)
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
  vctrs::vec_slice(x, match(y, x, 0))
}
set_union <- function(x, y) {
  vctrs::vec_unique(vctrs::vec_c(x, y))
}
