.fdefine <- function(tag, value){
  froth.env$Dict[[tag]] <- structure(value, id=tag, class="FrothDictEntry")
}

.falias <- function(tag, tag2){
  froth.env$Dict[[tag]] <- structure(tag2, id=tag, class="FrothAlias")
}

.userdefine <- function(tag, value){
  froth.env$Dict[[tag]] <- structure(value, id=tag, class="FrothUserEntry")
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
    } else if (word %in% names(.GlobalEnv)){
      push(.GlobalEnv[[word]])
      return(.ok())
    }
    message(word, ' ?')
    return(.warning(NULL))
  }
  f(...)
}

.compile <- function(){
  n <- tolower(pop_op())
  defn <- ''
  while((. <- pop_op()) != ';' && !is.null(.))
    defn <- paste(defn, .)
  .userdefine(n, trimws(defn))
  .ok()
}

dictionary <- function(){
  p <- vapply(froth.env$Dict, \(entry){
    if(is(entry, "FrothDictEntry")) return(0L)
    else if(is(entry, "FrothAlias")) return(1L)
    return(2L)
  }, integer(1L))
  np <- names(froth.env$Dict)
  p[np==''] <- 3L
  message("Built-in Words:")
  biw <- paste(np[p==0L], collapse=' ')
  message(biw)
  cat('\n')
  message("Aliases:")
  amp <- np[p==1L]
  amp <- paste0(amp, ' (', unlist(froth.env$Dict[p==1L]), ') ')
  message(amp)
  cat('\n')
  message("User Definitions:")
  for(i in which(p==2L)){
    l <- paste(np[i], ' (', froth.env$Dict[[i]], ')', collapse='')
    message(l)
  }
  cat('\n')
  invisible(0L)
}
