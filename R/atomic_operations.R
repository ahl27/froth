#### Basic Stack operations
push <- function(obj){
  assign("Stack",
         .Call("push", froth.env$Stack, obj, PACKAGE='froth'),
         env=froth.env)
  invisible(0)
}
push_operation <- function(obj){
  assign("PStack",
         .Call("push", froth.env$PStack, obj, PACKAGE='froth'),
         env=froth.env)
  invisible(0)
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

pop_operation <- function(){
  v <- peek(froth.env$PStack)
  if(!is.null(v)){
    assign("PStack",
           .Call("pop", froth.env$PStack, PACKAGE='froth'),
           env=froth.env)
  }
  v
}
