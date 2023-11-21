.parseLine <- function(l){
  # split the line by characters
  # load onto processing stack in reverse order
  ss <- rev(strsplit(l, ' ')[[1]])
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
    if(status != .ok()){
      if(status == .warning())
        .clearPStack()
      return(status)
    }
  }
  .ok()
}

.clearPStack <- function(){
  .initPairlist("PStack")
}

froth <- function(){
  if(!interactive())
    stop("Froth REPL is only available in interactive mode")
  assign("ts", list(), envir=froth.env)
  repeat{
    l <- readline(prompt="fr> ")
    while(grepl("\\\\ *$", l))
      l <- trimws(paste(l, readline(prompt="  + ")))
    .parseLine(l)

    status <- .evalPStack()
    if(status==1L) break
    if(status==.ok())
      message("ok.")
  }
  invisible()
}
