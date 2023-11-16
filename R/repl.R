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
    f <- pop_op()
    if(is.null(f))
      return(0L)
    if(!is.na(suppressWarnings(as.numeric(f)))){
      push(as.numeric(f))
      next
    }
    status <- .doword(f)
    if(status!=0L)
      return(status)
  }
}

froth <- function(){
  if(!interactive())
    stop("Froth REPL is only available in interactive mode")
  repeat{
    .parseLine(readline(prompt="fr> "))
    status <- .evalPStack()
    if(status==1L) break
    if(status==0L)
      message("ok.")
  }
  invisible()
}
