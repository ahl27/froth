.initVariableFunctions <- function(){
  .fdefine('variable', \(){
    froth.env$vars[[pop_op()]] <- vector('list', 0L)
    .ok()
  })
  .fdefine('!', \(){
    var <- pop()
    if(!.isValidVar(var)) return(.warning("invalid variable specified!"))
    froth.env$vars[[names(var)]][[var+1L]] <- pop()
    .ok()
  })
  .fdefine('@', \(){
    var <- pop()
    if(!.isValidVar(var)) return(.warning("invalid variable specified!"))
    push(froth.env$vars[[names(var)]][[var+1L]])
    .ok()
  })
  .fdefine('+!', \(){
    var <- pop()
    if(!.isValidVar(var)) return(.warning("invalid variable specified!"))
    froth.env$vars[[names(var)]][[var+1L]] <- froth.env$vars[[names(var)]][[var+1L]] + pop()
    .ok()
  })
  .fdefine('?', \(varname=NULL){.doword("@"); .doword('.')})
  .fdefine('constant', \(){
    . <- pop()
    .fdefine(pop_op(), \() push(.))
    .ok()
  })
  .fdefine('cells', \(){
    . <- pop()
    push(structure(., class="FrothVariableAddress"))
    .ok()
  })
  .fdefine('allot', \(){
    . <- pop()
    var <- pop()
    if(!.isValidVar(var)) return(.warning("invalid variable specified!"))
    froth.env$vars[[names(var)]] <- c(froth.env$vars[[names(var)]], vector('list', .))
  })
  .fdefine('fill', \(){
    . <- pop()
    v1 <- pop()
    v2 <- pop()
    if(!is(v1, 'FrothVariableAddress')) return(.warning("invalid offset specified!"))
    if(!.isValidVar(v2)) return(.warning("invalid variable specified!"))
    for(i in seq(v2+1L, v1+1L))
      froth.env$vars[[names(v2)]][[i]] <- .
    .ok()
  })
  .fdefine('erase', \(){
    v1 <- pop()
    v2 <- pop()
    if(!is(v1, 'FrothVariableAddress')) return(.warning("invalid offset specified!"))
    if(!.isValidVar(v2)) return(.warning("invalid variable specified!"))
    for(i in seq(v2+1L,v1+1L))
      froth.env$vars[[names(v2)]][[i]] <- 0L
    .ok()
  })
  .fdefine(',', \(){
    lastarray <- names(froth.env$vars)[length(froth.env$vars)]
    froth.env$vars[[lastarray]][[length(froth.env$vars[[lastarray]])+1L]] <- pop()
    .ok()
  })
}

.initVariableAliases <- function(){
  .falias('create', 'variable')
}

.isValidVar <- function(var){
  return(is(var,'FrothVariableAddress') && !is.null(names(var)))
}

print.FrothVariableAddress <- function(x, ...){
  outstring <- paste0('addr <', names(x)[1L], ', cell ', x[[1]], ">")
  print(outstring)
}
show.FrothVariableAddress <- function(object){
  print(object)
}
