#### Basic Stack operations
.initStackFunctions <- function(){
  .fdefine('swap', \() dign(1L))
  .fdefine('2swap', \() {dign(3L); dign(3L); .ok()})
  .fdefine('dup',\() {push(peek(froth.env$Stack)); .ok()})
  .fdefine('2dup', \() .parseLine('swap dup rot swap dup rot'))
  .fdefine('dig', \() {. <- pop(); dign(.)})
  .fdefine('over', \(){.doword('dup'); dign(2L); dign(1L); .ok()})
  .fdefine('2over', \() .parseLine('2dup 5 dig 5 dig 2swap'))
  .fdefine('2drop', \() .parseLine('drop drop'))
  .fdefine('rot', \(){dign(2L); dign(2L); .ok()})
  .fdefine('drop', \(){pop(); .ok()})
  .fdefine('>R', \(){. <- pop(); push_operation(.)})
  .fdefine('R>', \(){. <- pop_op(); push(.)})
  .fdefine('R@', \() push(peek(froth.env$PStack)))
}

.initStackAliases <- function(){

}

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
  if(is.null(v)){
    .warning("stack is empty.")
    return(v)
  }
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
  if(is.null(n) || !is.numeric(n) || n < 0)
    return(.warning("invalid input to dig!"))
  n <- as.integer(n)
  if(n >= length(froth.env$Stack))
    return(.warning("stack underflow!"))
  if(n == 0) return(.ok())

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
