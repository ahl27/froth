.initCoreFunctions <- function(){
  .fdefine('exit', .exit)
  .fdefine('inspect', \() {print(froth.env$Stack); .ok()})
  .fdefine('words', dictionary)
  .fdefine('apply', .apply)
  .fdefine(':', .compile)
  .fdefine('lit', \() {. <- pop_op(); push(.)})
  .fdefine('(', \() {. <- ''; while(. != ')' && !is.null(.)) . <- pop_op(); .ok()})
  .fdefine('noop', .ok)
  .fdefine('abort"', .abort)
  .fdefine('reset', \() .initPairlist("Stack"))
}

.initCoreAliases <- function(){
  .falias('quit', 'exit')
  .falias('compile', ':')
  .falias(')', 'noop')
  .falias('.s', 'inspect')
  .falias('xx', 'reset')
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

.apply <- function(f, nargs){
  . <- rev(lapply(seq_len(nargs), \(i) pop()))
  push(do.call(f, .))
  .ok()
}
