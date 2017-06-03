#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <stdbool.h>
#include <R_ext/Rdynload.h>

extern SEXP tidyselect_inds_combine(SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"tidyselect_inds_combine", (DL_FUNC) &tidyselect_inds_combine, 2},
  {NULL, NULL, 0}
};

void R_init_tidyselect(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
