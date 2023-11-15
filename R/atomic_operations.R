#### Basic Stack operations

push <- function(obj){
  i <- froth.env$Index + 1L
  froth.env$Objects[[i]] <- obj
  froth.env$Index <- as.integer(i)
  .Call("push", froth.env$Stack,
        froth.env$Objects[[i]],
        PACKAGE='froth')
  invisible(TRUE)
}

pop <- function(){
  minv <- froth.env$SStart
  iv <- froth.env$Index
  i <- max(iv - 1L, minv)
  if(iv!=minv)
    froth.env$Objects[[iv]] <- NULL
  froth.env$Index <- as.integer(i)
  .Call("pop", froth.env$Stack,
        PACKAGE='froth')
  invisible(TRUE)
}

popn <- function(n){
  minv <- froth.env$SStart
  iv <- froth.env$Index
  i <- max(iv - n, minv)
  if(iv!=minv){
    for(j in seq(i+1L,iv,by=1L)){
      froth.env$Objects[[j]] <- NULL
    }
  }
  froth.env$Index <- as.integer(i)
  .Call("popn", froth.env$Stack,
        as.integer(n),
        PACKAGE='froth')
  invisible(TRUE)
}
