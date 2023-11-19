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
    return(0L)
  }
  while(is(f, "FrothAlias"))
    f <- froth.env$Dict[[f]]
  if(is.null(f)){
    message(word, ' ?')
    return(2L)
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
