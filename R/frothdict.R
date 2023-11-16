.fdefine <- function(tag, value){
  froth.env$Dict[[tag]] <- structure(value, id=tag, class="FrothDictEntry")
}

.doword <- function(word, ...){
  f <- froth.env$Dict[[word]]
  if(is.null(f))
    return(0)
  f(...)
}

.initDictionary <- function(){
  ## Initializing the dictionary of builtins
  .fdefine('exit', \() return(1L))
  .fdefine('.', \() {print(pop()); invisible(0L)})
  .fdefine('apply2', \(f) {. <- f(pop(), pop()); push(.)})
  .fdefine('+', \() {.doword('apply2', `+`)})
  .fdefine('-', \() {.doword('apply2', `-`)})
  .fdefine('*', \() {.doword('apply2', `*`)})
  .fdefine('/', \() {.doword('apply2', `/`)})
  .fdefine('^', \() {.doword('apply2', `^`)})
}
