
.if <- function(shortcirc=FALSE){
  if(shortcirc || !pop())
    while((. <- pop_op()) != 'then' && !is.null(.))
      if(.=='if') .if(TRUE) else if(!shortcirc && .=='else') break
  .ok()
}

.else <- function(shortcirc=FALSE){
  if(shortcirc || pop())
    while(!(.<-pop_op()) != 'then' && !is.null(.))
      next
  .ok()
}
