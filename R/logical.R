.initLogicalFunctions <- function(){
  ## Unary
  .fdefine('invert', \() {.doword('apply', `!`, 1L)})
  .fdefine('or', \() {.doword('apply', `|`, 2L)})
  .fdefine('and', \() {.doword('apply', `&`, 2L)})
  .fdefine('xor', \() {.doword('apply', `xor`, 2L)})
  .fdefine('0=', \() {.doword('apply', \(x) x==0, 1L)})
  .fdefine('0<', \() {.doword('apply', \(x) x>0, 1L)})
  .fdefine('0>', \() {.doword('apply', \(x) x<0, 1L)})

  ## Binary
  .fdefine('<', \() {.doword('apply', `<`, 2L)})
  .fdefine('<=', \() {.doword('apply', `<=`, 2L)})
  .fdefine('>', \() {.doword('apply', `>`, 2L)})
  .fdefine('>=', \() {.doword('apply', `>=`, 2L)})
  .fdefine('=', \() {.doword('apply', `==`, 2L)})
  .fdefine('<>', \() {.doword('apply', `!=`, 2L)})
}

.initLogicalAliases <- function(){
  ## Unary
  .falias('not', 'invert')
  .falias('~', 'invert')
  .falias('&', 'and')
  .falias('|', 'or')

  ## Binary
  .falias('equal', '=')
  .falias('eq', '=')
  .falias('!=', '<>')
  .falias('neq', '<>')
  .falias('gr', '<')
  .falias('lt', '>')
  .falias('geq', '<=')
  .falias('leq', '>=')
}
