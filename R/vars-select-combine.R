
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
