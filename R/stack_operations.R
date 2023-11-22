#### Basic Stack operations
.initStackFunctions <- function(){
  .fdefine('clear', \() {.initPairlist("Stack"); .ok()})
  .fdefine('swap', \() dign(1L))
  .fdefine('2swap', \() {dign(3L); dign(3L); .ok()})
  .fdefine('dup',\() {push(peek(froth.env$Stack)); .ok()})
  .fdefine('2dup', \() .parseLine('swap dup rot swap dup rot'))
  .fdefine('dig', \() {. <- pop(); dign(.)})
  .fdefine('over', \() .parseLine('swap dup 2 dig swap'))
  .fdefine('2over', \() .parseLine('2swap 2dup 5 dig 5 dig 2swap'))
  .fdefine('2drop', \() .parseLine('drop drop'))
  .fdefine('rot', \(){dign(2L); .ok()})
  .fdefine('drop', \(){pop(); .ok()})
  .fdefine('?dup', \(){. <- peek(); if(. != 0) push(.); .ok()})
  .fdefine('>r', \(){. <- pop(); push(., "RStack")})
  .fdefine('r>', \(){. <- pop('RStack'); push(.)})
  .fdefine('r@', \() push(peek(froth.env$RStack)))
}

.initStackAliases <- function(){

}

push <- function(obj, stackname="Stack"){
  assign(stackname,
         .Call("push", froth.env[[stackname]], obj, PACKAGE='froth'),
         envir=froth.env)
  .ok()
}

peek <- function(stack=froth.env$Stack){
  .Call("peek", stack)
}

pop <- function(stackname='Stack'){
  v <- peek(froth.env[[stackname]])
  if(is.null(v)){
    stop("stack ", stackname, " is empty.", call.=FALSE)
    return(v)
  }
  assign(stackname,
         .Call("pop", froth.env[[stackname]], PACKAGE='froth'),
         envir=froth.env)
  v
}

popn <- function(n){
  l <- vector('list', n)
  for(i in seq_len(n)){
    l[[i]] <- pop()
  }
  l
}

tx_cstack <- function(){
  v <- pop()
  push(v, "CStack")
  .ok()
}

pop_op <- function(lowercase=TRUE){
  v <- peek(froth.env$PStack)
  if(!is.null(v)){
    assign("PStack",
           .Call("pop", froth.env$PStack, PACKAGE='froth'),
           envir=froth.env)
  }
  if(lowercase && !is.null(v)) v <- tolower(v)
  v
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
         envir=froth.env)
  .ok()
}
