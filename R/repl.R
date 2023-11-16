.parseLine <- function(l){
  # split the line by characters
  # load onto processing stack in reverse order
  ss <- rev(strsplit(tolower(l), ' ')[[1]])
  for(token in ss){
    push_operation(token)
  }
}

.evalPStack <- function(){
  repeat{
    f <- pop_operation()
    if(is.null(f))
      return(0)
    if(!is.na(suppressWarnings(as.numeric(f)))){
      push(as.numeric(f))
      next
    }
    status <- .doword(f)
    if(status==1L)
      return(status)
  }
}

froth <- function(){
  if(!interactive())
    stop("Froth REPL is only available in interactive mode")
  repeat{
    .parseLine(readline(prompt="fr> "))
    status <- .evalPStack()
    message("ok.")
    if(status==1L) break
  }
  invisible()
}
