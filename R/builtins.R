.initDictionary <- function(){
  ## Initializing the dictionary of builtins

  ## Core functions
  .fdefine('exit', .exit)
  .fdefine('.', \() {print(pop()); .ok()})
  .fdefine('apply1', \(f) {. <- f(pop()); push(.)})
  .fdefine('apply2', \(f) {. <- f(pop(), pop()); push(.)})
  .fdefine('swap', \() dign(1L))
  .fdefine('dig', \() {. <- pop(); dign(.)})
  .fdefine('inspect', \() {print(froth.env$Stack); .ok()})
  .fdefine('lit', \() {. <- pop_op(); push(.)})
  .fdefine('(', \() {. <- ''; while(. != ')' && !is.null(.)) . <- pop_op(); .ok()})
  .fdefine('noop', .ok)

  ## Arithmetic
  .fdefine('+', \() {.doword('apply2', `+`)})
  .fdefine('-', \() {.doword('apply2', `-`)})
  .fdefine('*', \() {.doword('apply2', `*`)})
  .fdefine('/', \() {.doword('apply2', `/`)})
  .fdefine('^', \() {.doword('apply2', `^`)})
  .fdefine('%', \() {.doword('apply2', `%%`)})
  .falias("mod", '%')
  .falias("pow", '^')
  .falias("times", "*")

  ## Unary operators
  .fdefine('not', \() {.doword('apply1', `!`)})
  .fdefine('or', \() {.doword('apply2', `|`)})
  .fdefine('and', \() {.doword('apply2', `&`)})
  .fdefine('xor', \() {.doword('apply2', `xor`)})
  .falias('!', 'not')
  .falias('!', '~')
  .falias('&', 'and')
  .falias('|', 'or')

  ## Comparisons
  .fdefine('<', \() {.doword('apply2', `<`)})
  .fdefine('<=', \() {.doword('apply2', `<=`)})
  .fdefine('>', \() {.doword('apply2', `>`)})
  .fdefine('>=', \() {.doword('apply2', `>=`)})
  .fdefine('==', \() {.doword('apply2', `==`)})
  .fdefine('!=', \() {.doword('apply2', `!=`)})

  ## Control flow
  .fdefine('if', \() {if(!pop()) while(peek(froth.env$PStack) != 'then') pop_op(); .ok()})
  .falias('then', 'noop')
}
