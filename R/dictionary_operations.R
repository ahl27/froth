.fdefine <- function(tag, value){
  froth.env$Dict[[tag]] <- structure(value, id=tag, class="FrothDictEntry")
}

.falias <- function(tag, tag2){
  froth.env$Dict[[tag]] <- structure(tag2, id=tag, class="FrothAlias")
}

.userdefine <- function(tag, value){
  l <- NULL
  if(tag %in% names(froth.env$Dict)){
    l <- c(list(froth.env$Dict[[tag]][[1L]], class(froth.env$Dict[[tag]])), attr(froth.env$Dict[[tag]], 'prev.defns'))
  }
  froth.env$Dict[[tag]] <- structure(value, id=tag, class="FrothUserEntry", prev.defns=l)
}

.forget <- function(){
  . <- pop_op()
  if(!(. %in% names(froth.env$Dict))) return(.ok())
  if(!is(froth.env$Dict[[.]], 'FrothUserEntry'))
    return(.warning("forgetting a built-in function!"))
  pv <- attr(froth.env$Dict[[.]], 'prev.defns')
  if(is.null(pv)) froth.env$Dict[[.]] <- NULL
  else {
    froth.env$Dict[[.]][[1L]] <- pv[[1L]]
    class(froth.env$Dict[[.]]) <- pv[[2L]]
    if(length(pv) == 2) pv <- NULL else pv <- pv[-c(1L,2L)]
    attr(froth.env$Dict[[.]], 'prev.defns') <- pv
  }
  return(.ok())
}

.doword <- function(word, ...){
  if(word == '') word <- 'noop'
  f <- froth.env$Dict[[word]]
  if(is(f, "FrothUserEntry")){
    .parseLine(f)
    return(.ok())
  }
  while(is(f, "FrothAlias"))
    f <- froth.env$Dict[[f]]
  if(is.null(f)){
    ## handling variable names
    if(word %in% names(froth.env$vars)){
      push(structure(0L, names=word, class='FrothVariableAddress'))
      return(.ok())
    } else if (exists(word, where=1L)){
      push(get(word, pos=1L))
      return(.ok())
    }
    message(word, ' ?')
    return(.warning(NULL))
  }
  f(...)
}

.compile <- function(){
  n <- pop_op()
  while(n == '') n <- pop_op()
  defn <- ''
  while((. <- pop_op(FALSE)) != ';' && !is.null(.))
    defn <- paste(defn, .)
  .userdefine(n, trimws(defn))
  .ok()
}

froth.dictionary <- function(){
  cutoff <- 8L
  p <- vapply(froth.env$Dict, \(entry){
    if(is(entry, "FrothDictEntry")) return(0L)
    else if(is(entry, "FrothAlias")) return(1L)
    return(2L)
  }, integer(1L))
  np <- names(froth.env$Dict)
  p[np==''] <- 3L
  message("Built-in Words:")
  biw <- np[p==0L]
  l <- ''
  for(i in seq_along(biw)){
    l <- paste(l, biw[i])
    if(i %% cutoff == 0 || i == length(biw)){
      message(substring(l, 2))
      l <- ''
    }
  }
  cat('\n')
  message("Aliases:")
  amp <- np[p==1L]
  l <- ''
  amp <- paste0(amp, ' (', unlist(froth.env$Dict[p==1L]), ')')
  for(i in seq_along(amp)){
    l <- paste(l, amp[i])
    if(i %% floor(cutoff/2) == 0 || i == length(amp)){
      message(substring(l, 2L))
      l <- ''
    }
  }
  cat('\n')
  message("User Definitions:")
  for(i in which(p==2L)){
    l <- paste(np[i], ' (', froth.env$Dict[[i]], ')', collapse='')
    message(l)
  }
  cat('\n')
  invisible(0L)
}
