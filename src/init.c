#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <stdbool.h>
#include <R_ext/Rdynload.h>

extern SEXP selectr_inds_combine(SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"selectr_inds_combine", (DL_FUNC) &selectr_inds_combine, 2},
  {NULL, NULL, 0}
};

void R_init_selectr(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
