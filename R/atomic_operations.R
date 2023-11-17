#### Basic Stack operations
push <- function(obj){
  assign("Stack",
         .Call("push", froth.env$Stack, obj, PACKAGE='froth'),
         env=froth.env)
  .ok()
}
push_operation <- function(obj){
  assign("PStack",
         .Call("push", froth.env$PStack, obj, PACKAGE='froth'),
         env=froth.env)
  .ok()
}

peek <- function(stack=froth.env$Stack){
  .Call("peek", stack)
}

pop <- function(){
  v <- peek()
  assign("Stack",
         .Call("pop", froth.env$Stack, PACKAGE='froth'),
         env=froth.env)
  v
}

popn <- function(n){
  l <- vector('list', n)
  for(i in seq_len(n)){
    l[[i]] <- pop()
  }
  l
}

dign <- function(n){
  if(is.null(n) || !is.numeric(n))
    .warning("invalid input to dig!")
  n <- as.integer(n)
  assign("Stack",
         .Call("dign", froth.env$Stack, n, PACKAGE='froth'),
         env=froth.env)
  .ok()
}

pop_op <- function(){
  v <- peek(froth.env$PStack)
  if(!is.null(v)){
    assign("PStack",
           .Call("pop", froth.env$PStack, PACKAGE='froth'),
           env=froth.env)
  }
  v
}

.if <- function(shortcirc=FALSE){
  if(shortcirc || !pop())
    while((. <- peek(froth.env$PStack)) != 'then' && !is.null(.))
      if(pop_op()=='if') .if(TRUE)
  .ok()
}
