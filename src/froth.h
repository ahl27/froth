#ifndef FROTH_H
#define FROTH_H

#include <stdlib.h>
#include <Rdefines.h>
#include <R_ext/Rdynload.h>

/*** Structs and Enums ***/

// TODO: Should we just use ints and index the list byref?
struct Stack{
  struct Stack *next;
  SEXP val;
};

typedef struct Stack Stack;

enum ACCESS {
  SAFE,
  UNSAFE
};

/*** Callable Functions ***/

// frothstack.c
SEXP initFrothStack(SEXP objList);
SEXP push(SEXP sPtr, SEXP val);
SEXP pop(SEXP sPtr);
SEXP popn(SEXP sPtr, SEXP NUM);



/*** Internal Functions ***/

// R_init_froth.c
void R_init_froth(DllInfo *info);

// frothstack.c
static Stack* allocStack(SEXP val);
static inline Stack* safeStackAccess(SEXP sPtr);
static void FreeStack(SEXP sPtr);
static void CleanupStack(Stack *head);


#endif
