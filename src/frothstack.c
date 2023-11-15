#include "froth.h"


/*** Called from R ***/
SEXP initFrothStack(SEXP objList){
  Stack* head = allocStack(R_NilValue);
  SEXP retval = PROTECT(R_MakeExternalPtr(head, R_NilValue, objList));
  R_RegisterCFinalizerEx(retval, (R_CFinalizer_t) FreeStack, TRUE);
  UNPROTECT(1);
  return retval;
}

SEXP push(SEXP sPtr, SEXP val){
  Stack *head = safeStackAccess(sPtr);
  Stack *newnode = allocStack(val);
  newnode->next = head;
  R_SetExternalPtrAddr(sPtr, newnode);
  return R_NilValue;
}

SEXP pop(SEXP sPtr){
  Stack *head = safeStackAccess(sPtr);
  if(!head->next){
    // This should only occur at the bottom of the stack
    // in this case, don't destroy the stack, just return NULL
    warning("Stack is empty!");
    return(R_NilValue);
  }

  SEXP v = head->val;
  Stack *newhead = head->next;
  R_SetExternalPtrAddr(sPtr, newhead);
  free(head);
  return(v);
}

SEXP popn(SEXP sPtr, SEXP NUM){
  int n = INTEGER(NUM)[0];
  SEXP outvec = PROTECT(allocVector(VECSXP, n));
  for(int i=0; i<n; i++)
    SET_VECTOR_ELT(outvec, i, pop(sPtr));
  UNPROTECT(1);
  return(outvec);
}


/*** Internal Functions ***/
static Stack* allocStack(SEXP val){
  Stack* head = malloc(sizeof(Stack));
  head->next = NULL;
  head->val = val;
  return(head);
}

static inline Stack* safeStackAccess(SEXP sPtr){
  if (!R_ExternalPtrAddr(sPtr))
      error("External pointer no longer exists!");
  return (Stack *) R_ExternalPtrAddr(sPtr);
}

static void FreeStack(SEXP sPtr){
  if (!R_ExternalPtrAddr(sPtr)) return;
  Stack *head = (Stack *) R_ExternalPtrAddr(sPtr);
  CleanupStack(head);
  R_ClearExternalPtr(sPtr);
  return;
}

static void CleanupStack(Stack *head){
  if(head->next)
    CleanupStack(head->next);
  free(head);
  return;
}

