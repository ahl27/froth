#include "froth.h"

/*** Called from R ***/
inline SEXP initFrothStack(void){
  return CONS(R_NilValue, R_NilValue);
}

inline SEXP push(SEXP stack, SEXP val){
  return CONS(val, stack);
}

inline SEXP peek(SEXP stack){
  return(CAR(stack));
}

SEXP dign(SEXP stack, SEXP n){
  int depth = INTEGER(n)[0];
  SEXP cur = stack;
  for(int i=0; i<depth-1; i++){
    if(CAR(cur) == R_NilValue)
      return(R_NilValue);
    cur = CDR(cur);
  }

  SEXP tmp = PROTECT(CADR(cur));
  SETCDR(cur, CDDR(cur));
  stack = PROTECT(CONS(tmp, stack));
  UNPROTECT(2);
  return(stack);
}

SEXP pop(SEXP stack){
  SEXP top = PROTECT(CAR(stack));
  if(top == R_NilValue){
    // This should only occur at the bottom of the stack
    // in this case, don't destroy the stack, just return NULL
    warning("Stack is empty!");
    UNPROTECT(1);
    return(stack);
  }
  UNPROTECT(1);
  return(CDR(stack));
}
