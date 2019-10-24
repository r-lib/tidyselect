
inds_combine <- function(vars, inds) {
  first_negative <- length(inds) && length(inds[[1]]) && inds[[1]][[1]] < 0

  # Don't suffix existing duplicate with a sequential suffix
  dups <- purrr::map_lgl(inds, is_data_dups)
  spec <- function(outer, inner) {
    if (dups[[outer[[1]]]]) {
      outer
    } else {
      paste0(outer, inner)
    }
  }

  inds <- vctrs::vec_c(!!!inds, .ptype = integer(), .name_spec = spec)
  inds <- subclass_index_errors(
    vctrs::vec_as_index(inds, length(vars), vars, convert_values = NULL)
  )

  dir <- vec_group_pos_direction(inds)
  pos <- match("pos", dir$key)
  neg <- match("neg", dir$key)

  if (first_negative) {
    incl <- seq_along(vars)
  } else if (!is.na(pos)) {
    incl <- inds[dir$pos[[pos]]]
    incl <- vctrs::vec_as_index(incl, length(vars))
    incl <- inds_unique(incl, vars)
  } else {
    incl <- integer()
  }

  if (!is.na(neg)) {
    excl <- -inds[dir$pos[[neg]]]
    excl <- vctrs::vec_as_index(excl, length(vars))
    incl <- set_diff(incl, excl)
  }

  names(incl) <- names2(incl)
  unrenamed <- names(incl) == ""
  unrenamed_vars <- vars[incl[unrenamed]]

  rename_check(
    to = names(incl)[!unrenamed],
    vars = unrenamed_vars,
    orig = vars,
    incl = incl,
    dups = dups
  )

  names(incl)[unrenamed] <- unrenamed_vars
  incl
}

vec_group_pos_direction <- function(x) {
  direction <- ifelse(x < 0L, 1L, 2L)
  direction <- factor(direction, 1:2, c("neg", "pos"))
  vctrs::vec_group_pos(direction)
}

inds_unique <- function(x, vars) {
  # Remove duplicates but keep last name of duplicates
  split <- vctrs::vec_split(x, x)
  out <- split$key

  # Keep last name of duplicates
  if (length(out) < length(x)) {
    names(out) <- map_chr(split$val, ind_last_name, vars = vars)
  }

  out
}

ind_last_name <- function(x, vars) {
  names <- str_compact(names(x))

  if (length(names) == 0) {
    return("")
  }
  if (length(names) == 1) {
    return(names)
  }

  if (!all(vctrs::vec_duplicate_detect(names))) {
    dups <- encodeString(names, quote = "`")
    var <- encodeString(vars[[x[[1]]]], quote = "`")
    kept <- last(dups)
    dups <- glue::glue_collapse(dups, ", ", last = " and ")
    msg <- glue::glue(
      "Must rename variables to a single choice: {var} is being renamed to {dups}.
       Renaming {var} to {kept} instead."
    )
    warn(msg, "tidyselect_warning_duplicate_renaming", var = x)
  }

  last(names)
}

rename_check <- function(to, vars, orig, incl, dups) {
  # We check that variables are renamed to a unique name but we also
  # want to allow renaming existing duplicates. We remove those from
  # the checking set here.
  if (any(dups)) {
    to <- to[!to %in% names(dups)[dups]]
  }

  if (vctrs::vec_duplicate_any(to)) {
    dups <- vctrs::vec_duplicate_detect(to)
    dups <- vctrs::vec_unique(to[dups])

    probs <- map_chr(dups, function(dup) {
      cols <- orig[incl[names(incl) == dup]]
      cols <- glue::backtick(cols)
      cols <- glue::glue_collapse(cols, sep = ", ", last = " and ")
      glue::glue("* Columns {cols} are being renamed to `{dup}`.")
    })
    msg <- paste_line(
      "Must use unique names when renaming columns.",
      !!!probs
    )

    abort(msg, "tidyselect_error_rename_to_same")
  }

  if (any(vctrs::vec_in(to, vars))) {
    dups <- vars[match(to, vars, 0L)]

    probs <- map_chr(dups, function(dup) {
      col <- orig[[incl[[dup]]]]
      glue::glue("* Column `{col}` is being renamed to existing column `{dup}`.")
    })
    msg <- paste_line(
      "Must use unique name when renaming columns.",
      !!!probs
    )

    abort(msg, "tidyselect_error_rename_to_existing")
  }
}
