% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/doc-tidy-selection.R
\name{args_tidy_select}
\alias{args_tidy_select}
\title{Argument type: tidy-select}
\description{
This page describes the \verb{<tidy-select>} argument modifier which indicates
the argument supports \strong{tidy selections}. Tidy selection provides a concise
dialect of R for selecting variables based on their names or properties.

Tidy selection is a variant of tidy evaluation. This means that inside
functions, tidy-select arguments require special attention, as described in
the \emph{Indirection} section below. If you've never heard of tidy evaluation
before, start with \code{vignette("programming")}.
}
\section{Overview of selection features}{
Tidyverse selections implement a dialect of R where operators make
it easy to select variables:
\itemize{
\item \code{:} for selecting a range of consecutive variables.
\item \code{!} for taking the complement of a set of variables.
\item \code{&} and \code{|} for selecting the intersection or the union of two
sets of variables.
\item \code{c()} for combining selections.
}

In addition, you can use \strong{selection helpers}. Some helpers select specific
columns:
\itemize{
\item \code{\link[=everything]{everything()}}: Matches all variables.
\item \code{\link[=last_col]{last_col()}}: Select last variable, possibly with an offset.
}

Other helpers select variables by matching patterns in their names:
\itemize{
\item \code{\link[=starts_with]{starts_with()}}: Starts with a prefix.
\item \code{\link[=ends_with]{ends_with()}}: Ends with a suffix.
\item \code{\link[=contains]{contains()}}: Contains a literal string.
\item \code{\link[=matches]{matches()}}: Matches a regular expression.
\item \code{\link[=num_range]{num_range()}}: Matches a numerical range like x01, x02, x03.
}

Or from variables stored in a character vector:
\itemize{
\item \code{\link[=all_of]{all_of()}}: Matches variable names in a character vector. All
names must be present, otherwise an out-of-bounds error is
thrown.
\item \code{\link[=any_of]{any_of()}}: Same as \code{all_of()}, except that no error is thrown
for names that don't exist.
}

Or using a predicate function:
\itemize{
\item \code{\link[=where]{where()}}: Applies a function to all variables and selects those
for which the function returns \code{TRUE}.
}
}

\section{Indirection}{
There are two main cases:
\itemize{
\item If you have a character vector of column names, use \code{all_of()}
or \code{any_of()}, depending on whether or not you want unknown variable
names to cause an error, e.g. \code{select(df, all_of(vars))},
\code{select(df, !any_of(vars))}.
\item If you want the user to be able to supply a tidyselect specification in
a function argument, embrace the function argument, e.g.
\code{select(df, {{ vars }})}.
}
}

\keyword{internal}
