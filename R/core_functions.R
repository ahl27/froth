.initCoreFunctions <- function(){
  .fdefine('exit', .exit)
  .fdefine('inspect', \() {print(froth.env$Stack); .ok()})
  .fdefine('words', froth.dictionary)
  .fdefine('apply', .apply)
  .fdefine('multiapply', .multiapply)
  .fdefine(':', .compile)
  .fdefine('forget', .forget)
  .fdefine('lit', \() {. <- pop_op(); push(.)})
  .fdefine('(', \() {. <- ''; while(. != ')' && !is.null(.)) . <- pop_op(); .ok()})
  .fdefine('noop', .ok)
  .fdefine('abort"', .abort)
  .fdefine('reset', \() {.onAttach(); .ok()})
  .fdefine("'", .tick)
  .fdefine("execute", .execute)
}

.initCoreAliases <- function(){
  .falias('quit', 'exit')
  .falias('compile', ':')
  .falias(')', 'noop')
  .falias('.s', 'inspect')
  .falias('xx', 'reset')
  .falias(r"(\)", 'noop')
  .falias("[']", "'")
}

.abort <- function(){
  msg <- ''
  while((. <- pop_op()) != '"' && !is.null(.))
    msg <- paste(msg, .)
  if (pop()){
    message("Aborting: ", msg)
    .initPairlist("Stack")
  }
  .warning()
}

## apply a function with a single return
.apply <- function(f, nargs){
  . <- rev(lapply(seq_len(nargs), \(i) pop()))
  push(do.call(f, .))
  .ok()
}

## apply a function with multiple returns
.multiapply <- function(f, nargs){
  . <- rev(lapply(seq_len(nargs), \(i) pop()))
  for(r in rev(do.call(f, .)))
    push(r)
  .ok()
}

# push execution token onto stack
.tick <- function(){
  n <- pop_op()
  while(n == '') n <- pop_op()
  if(!is.null(froth.env$Dict[[n]])){
    push(structure(paste0("executable token < ", n, " >"), word=n, class='FrothExecutionToken'))
    return(.ok())
  }
  .warning(paste("can't find", n))
}

# execute execution token on the stack
.execute <- function(){
  n <- pop()
  if(!is(n, 'FrothExecutionToken'))
    return(.warning("tried to execute non-token"))
  .evalWord(attr(n, 'word'))
  .ok()
}


print.FrothExecutionToken <- function(x, ...){
  v <- attr(x, 'word')
  lookup <- froth.env$Dict[[v]]
  outstring <- unclass(x)
  if(is(lookup, "FrothUserEntry")){
    outstring <- paste0(outstring, " : ", lookup, collapse='')
  } else {
    outstring <- paste0(outstring, " : (built-in)")
  }
  print(outstring)
}
show.FrothExecutionToken <- function(object){
  print(object)
}
