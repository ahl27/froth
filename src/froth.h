#ifndef FROTH_H
#define FROTH_H

#include <stdlib.h>
#include <Rdefines.h>
#include <R_ext/Rdynload.h>

/*** Structs and Enums ***/

/*** Callable Functions ***/

// frothstack.c
SEXP initFrothStack(void);
SEXP push(SEXP stack, SEXP val);
SEXP pop(SEXP stack);
SEXP peek(SEXP stack);
SEXP dign(SEXP stack, SEXP n);

/*** Internal Functions ***/

// R_init_froth.c
void R_init_froth(DllInfo *info);

#endif
