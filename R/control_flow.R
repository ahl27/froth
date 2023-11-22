.initControlFunctions <- function(){
  # most of these functions aren't defined inline just for clarity

  ## Branching
  .fdefine('if', .if)
  .fdefine('else', .else)

  ## Loop startwords
  .fdefine('do', .do)
  .fdefine('begin', .begin)

  ## Loop endwords
  .fdefine('loop', .loop)
  .fdefine('+loop', \(){. <- pop(); .loop(.)})

  ## Other loop controls
  .fdefine('while', \() if(as.logical(pop())) return(.ok()) else return(.finishedloop(FALSE)))
  .fdefine('leave', \() .finishedloop(FALSE))
  .fdefine('until', .until)
  .fdefine('repeat', .repeat)
  .fdefine('i', \() .loopcountval(0L))
  .fdefine('j', \() .loopcountval(1L))
  .fdefine('k', \() .loopcountval(2L))
  .fdefine('loopcounter', \() {. <- pop(); .loopcountval(.)})
  .fdefine('loopend', .finishedloop)
}

.initControlAliases <- function(){
  .falias('then', 'noop')

  ## unconditional branches
  .falias('again', 'repeat')
}

.if <- function(shortcirc=FALSE){
  if(!shortcirc)
    tx_cstack()
  if(shortcirc || !as.logical(peek(froth.env$CStack))){
    while((. <- pop_op()) != 'then' && !is.null(.))
      if(.=='if') .if(TRUE) else if(!shortcirc && .=='else') break
  }

  .ok()
}

.else <- function(shortcirc=FALSE){
  if(shortcirc || as.logical(pop("CStack"))){
    while((.<-pop_op()) != 'then' && !is.null(.))
      next
  }
  .ok()
}

.do <- function(){
  s <- pop()
  e <- pop()

  ## This is an INTENDED difference according to the manual
  ## -10 0 DO I . -1 +LOOP ; prints -10
  ## 10 0 DO I .  1 +LOOP ; does not print 10
  if(s <= e)
    .setupLoop(s, e, `<`, 'do', endwords=c('loop', '+loop'))
  else
    .setupLoop(s, e, `>=`, 'do', endwords=c('loop', '+loop'))

  .evalLoop()
  .ok()
}

.loop <- function(amt=1L){
  l <- length(froth.env$ts)
  if(l==0){
    return(.warning("LOOP call outside loop body"))
  }
  attr(froth.env$ts[[l]], 'cur') <- attr(froth.env$ts[[l]], 'cur') + amt
  .ok()
}

.begin <- function(){
  .setupLoop(FALSE, TRUE, `!=`, 'begin', c('again', 'repeat', 'until'))
  .evalLoop()
  .ok()
}

.until <- function(){
  . <- pop()
  attr(froth.env$ts[[length(froth.env$ts)]], 'cur') <- as.logical(.)
  .ok()
}

.repeat <- function(){
  l <- length(froth.env$ts)
  if(l==0){
    return(.warning("LOOP call outside loop body"))
  }
  attr(froth.env$ts[[l]], 'cur') <- !attr(froth.env$ts[[l]], 'end')
  .ok()
}

.loopcountval <- function(offset){
  l <- length(froth.env$ts)
  push(attr(froth.env$ts[[l-offset]], 'cur'))
  .ok()
}

.setupLoop <- function(s,e, compfxn, startword, endwords){
  ## This function loads the words in the outermost loop
  ## into a temporary stack to be executed later.
  l <- length(froth.env$ts) + 1L
  ts <- .Call("initFrothStack", PACKAGE = 'froth')

  ## This construction is to handle nested loop structures
  seenloop <- 1L
  while(seenloop != 0 && !is.null(. <- pop_op(FALSE))){
    ts <- .Call("push", ts, ., PACKAGE='froth')
    if(tolower(.) == startword) seenloop <- seenloop + 1L
    if(tolower(.) %in% endwords) seenloop <- seenloop - 1L
  }

  if(seenloop != 0L) return(.warning("loop terminated unexpectedly"))
  froth.env$ts[[l]] <- structure(ts, cur=s, end=e, f=compfxn, class='tempstack')

  .ok()
}

.evalLoop <- function(){
  context <- length(froth.env$ts)
  f <- attr(froth.env$ts[[context]], 'f')
  while(f(attr(froth.env$ts[[context]], 'cur'), attr(froth.env$ts[[context]], 'end'))){
    argline <- paste(rev(unlist(froth.env$ts[[context]])), collapse=' ')
    .parseLine(paste(argline, 'loopend', sep=' '))
    status <- .evalPStack()
    if(status == .finishedloop(FALSE)){ # early termination
      while((. <- pop_op()) != 'loopend') next
      return(.endloop())
    }
    if(status != .finishedloop())
      return(.endloop(status))
  }
  .endloop(.ok())
}

.endloop <- function(status=.ok()){
  froth.env$ts[[length(froth.env$ts)]] <- NULL
  return(status)
}
