.parseLine <- function(l){
  # split the line by characters
  # load onto processing stack in reverse order
  ss <- rev(strsplit(tolower(l), ' ')[[1]])
  for(token in ss){
    push_operation(token)
  }
  .ok()
}

.evalWord <- function(f){
  if(is.null(f))
    return(.ok())
  if(!is.na(suppressWarnings(as.numeric(f)))){
    push(as.numeric(f))
    return(.ok())
  }
  .doword(f)
}

.evalPStack <- function(){
  while(!is.null(f <- pop_op())){
    status <- .evalWord(f)
    if(status != .ok())
      return(status)
  }
  .ok()
}

froth <- function(){
  if(!interactive())
    stop("Froth REPL is only available in interactive mode")
  repeat{
    .parseLine(readline(prompt="fr> "))
    status <- .evalPStack()
    if(status==1L) break
    if(status==.ok())
      message("ok.")
  }
  invisible()
}
