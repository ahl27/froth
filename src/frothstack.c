#include "froth.h"


/*** Called from R ***/
inline SEXP initFrothStack(){
  return CONS(R_NilValue, R_NilValue);
}

inline SEXP push(SEXP stack, SEXP val){
  return CONS(val, stack);
}

inline SEXP peek(SEXP stack){
  return(CAR(stack));
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
