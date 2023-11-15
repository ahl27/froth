#### Basic Stack operations
push <- function(obj){
  assign("Stack",
         .Call("push", froth.env$Stack, obj, PACKAGE='froth'),
         env=froth.env)
  invisible(TRUE)
}

peek <- function(){
  .Call("peek", froth.env$Stack)
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
