.initDictionary <- function(){
  ## Initializing the dictionary of builtins

  ## Core functions
  .fdefine('exit', .exit)
  .falias('quit', 'exit')
  .fdefine('.', \() {print(pop()); .ok()})
  .fdefine('apply', \(f, nargs){
    . <- rev(lapply(seq_len(nargs), \(i) pop()))
    push(do.call(f, .))
    .ok()
  })
  .fdefine('swap', \() dign(1L))
  .fdefine('dig', \() {. <- pop(); dign(.)})
  .fdefine('inspect', \() {print(froth.env$Stack); .ok()})
  .fdefine('lit', \() {. <- pop_op(); push(.)})
  .fdefine('(', \() {. <- ''; while(. != ')' && !is.null(.)) . <- pop_op(); .ok()})
  .fdefine('noop', .ok)

  ## Arithmetic
  .fdefine('+', \() {.doword('apply', `+`, 2L)})
  .fdefine('sum', \() {.doword('apply', `+`, 2L)})
  .fdefine('-', \() {.doword('apply', `-`, 2L)})
  .fdefine('*', \() {.doword('apply', `*`, 2L)})
  .fdefine('/', \() {.doword('apply', `/`, 2L)})
  .fdefine('^', \() {.doword('apply', `^`, 2L)})
  .fdefine('%', \() {.doword('apply', `%%`, 2L)})
  .falias("mod", '%')
  .falias("pow", '^')
  .falias("times", "*")

  ## Unary operators
  .fdefine('not', \() {.doword('apply', `!`, 1L)})
  .fdefine('or', \() {.doword('apply', `|`, 2L)})
  .fdefine('and', \() {.doword('apply', `&`, 2L)})
  .fdefine('xor', \() {.doword('apply', `xor`, 2L)})
  .falias('!', 'not')
  .falias('!', '~')
  .falias('&', 'and')
  .falias('|', 'or')

  ## Comparisons
  .fdefine('<', \() {.doword('apply', `<`, 2L)})
  .fdefine('<=', \() {.doword('apply', `<=`, 2L)})
  .fdefine('>', \() {.doword('apply', `>`, 2L)})
  .fdefine('>=', \() {.doword('apply', `>=`, 2L)})
  .fdefine('==', \() {.doword('apply', `==`, 2L)})
  .fdefine('!=', \() {.doword('apply', `!=`, 2L)})

  ## Control flow
  .fdefine('if', .if)
  .falias('then', 'noop')
}
