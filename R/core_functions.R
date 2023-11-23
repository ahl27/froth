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
}

.initCoreAliases <- function(){
  .falias('quit', 'exit')
  .falias('compile', ':')
  .falias(')', 'noop')
  .falias('.s', 'inspect')
  .falias('xx', 'reset')
  .falias(r"(\)", 'noop')
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
