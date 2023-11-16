.ok <- function(msg=NULL){
  if(!is.null(msg))
    message(msg)
  invisible(0L)
}

.exit <- function(){
  message("Goodbye!")
  invisible(1L)
}

.warning <- function(w){
  message("Warning:", w)
  invisible(2L)
}
