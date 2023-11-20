.initCoreFunctions <- function(){
  .fdefine('exit', .exit)
  .fdefine('apply', \(f, nargs){
    . <- rev(lapply(seq_len(nargs), \(i) pop()))
    push(do.call(f, .))
    .ok()
  })
  .fdefine(':', .compile)
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
  .fdefine('inspect', \() {print(froth.env$Stack); .ok()})
  .fdefine('lit', \() {. <- pop_op(); push(.)})
  .fdefine('(', \() {. <- ''; while(. != ')' && !is.null(.)) . <- pop_op(); .ok()})
  .fdefine('noop', .ok)
}

.initCoreAliases <- function(){
  .falias('quit', 'exit')
  .falias('compile', ':')
  .falias('.s', 'inspect')
}
