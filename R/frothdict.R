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
