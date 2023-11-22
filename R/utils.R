.ok <- function(msg=NULL){
  if(!is.null(msg))
    message(msg)
  invisible(0L)
}

.exit <- function(){
  message("Goodbye!")
  invisible(1L)
}

.warning <- function(w=NULL){
  if(!is.null(w))
    message("Error: ", w)
  invisible(2L)
}

.finishedloop <- function(normal=TRUE){
  ## normal=FALSE is for early termination like LEAVE or WHILE
  invisible(ifelse(normal, 3L, 4L))
}

.initPairlist <- function(n){
  assign(n, .Call("initFrothStack", PACKAGE = 'froth'), envir=froth.env)
}
