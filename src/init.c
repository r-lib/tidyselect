#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <stdbool.h>
#include <R_ext/Rdynload.h>

extern SEXP selectr_combine_vars(SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"selectr_combine_vars", (DL_FUNC) &selectr_combine_vars, 2},
  {NULL, NULL, 0}
};

void R_init_selectr(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
