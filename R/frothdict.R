.fdefine <- function(tag, value){
  froth.env$Dict[[tag]] <- structure(value, id=tag, class="FrothDictEntry")
}

.falias <- function(tag, tag2){
  froth.env$Dict[[tag]] <- structure(tag2, id=tag, class="FrothAlias")
}

.doword <- function(word, ...){
  f <- froth.env$Dict[[word]]
  while(is(f, "FrothAlias"))
    f <- froth.env$Dict[[f]]
  if(is.null(f))
    return(2L)
  f(...)
}

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

  ## Functions built from core internals
  .fdefine('+', \() {.doword('apply2', `+`)})
  .fdefine('-', \() {.doword('apply2', `-`)})
  .fdefine('*', \() {.doword('apply2', `*`)})
  .fdefine('/', \() {.doword('apply2', `/`)})
  .fdefine('^', \() {.doword('apply2', `^`)})
  .fdefine('%', \() {.doword('apply2', `%%`)})
  .falias("mod", '%')
  .falias("pow", '^')
  .falias("times", "*")
}
