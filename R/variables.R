.initVariableFunctions <- function(){
  .fdefine('variable', \(){
    l <- list(0L)
    froth.env$vars[[pop_op()]] <- l
    .ok()
  })
  .fdefine('!', \(){
    var <- pop()
    if(!.isValidVar(var)) return(.warning("invalid variable specified!"))
    if(length(froth.env$vars[[names(var)]]) >= (var+1L))
      froth.env$vars[[names(var)]][[var+1L]] <- pop()
    else
      return(.warning("array accessed out of bounds!"))
    .ok()
  })
  .fdefine('@', \(){
    var <- pop()
    if(!.isValidVar(var)) return(.warning("invalid variable specified!"))
    if(length(froth.env$vars[[names(var)]]) >= (var+1L))
      push(froth.env$vars[[names(var)]][[var+1L]])
    else
      return(.warning("array accessed out of bounds!"))
    .ok()
  })
  .fdefine('length', \(){
    var <- pop()
    if(!.isValidVar(var)) return(.warning("invalid variable specified!"))
    push(length(froth.env$vars[[names(var)]]))
    .ok()
  })
  .fdefine('length?', \() .parseLine('length .'))
  .fdefine('+!', \(){
    var <- pop()
    if(!.isValidVar(var)) return(.warning("invalid variable specified!"))
    if(length(froth.env$vars[[names(var)]]) >= (var+1L))
      froth.env$vars[[names(var)]][[var+1L]] <- froth.env$vars[[names(var)]][[var+1L]] + pop()
    else
      return(.warning("array accessed out of bounds!"))
    .ok()
  })
  .fdefine('?', \(){r <- .doword("@"); if(r!=.warning()) .doword('.') else r})
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
    . <- pop()-1L
    if(. <= 0) return(.warning("invalid allot size specified"))
    var <- names(froth.env$vars)[length(froth.env$vars)]
    froth.env$vars[[var]] <- c(froth.env$vars[[var]], rep(list(0L), .))
    .ok()
  })
  .fdefine('extend', \(){
    . <- pop()
    var <- pop()
    if(!.isValidVar(var)) return(.warning("invalid variable specified!"))
    froth.env$vars[[names(var)]] <- c(froth.env$vars[[names(var)]], rep(list(0L), .))
    .ok()
  })
  .fdefine('reallot', \(){
    . <- pop()
    var <- pop()
    if(!.isValidVar(var)) return(.warning("invalid variable specified!"))
    l <- rep(list(0L), .)
    lp <- length(froth.env$vars[[names(var)]])
    for(i in seq_len(min(.,lp))) l[[i]] <- froth.env$vars[[names(var)]][[i]]
    froth.env$vars[[names(var)]] <- l
    .ok()
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
  .fdefine('create', \(){
    l <- vector('list', 0L)
    froth.env$vars[[pop_op()]] <- l
    .ok()
  })
  .fdefine(',', \(){
    lastarray <- names(froth.env$vars)[length(froth.env$vars)]
    froth.env$vars[[lastarray]][[length(froth.env$vars[[lastarray]])+1L]] <- pop()
    .ok()
  })
}

.initVariableAliases <- function(){
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
