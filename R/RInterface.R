###
### Functions to interact with froth from R
###

froth.reset <- function(){
  .initPairlist("PStack")
  .initPairlist("Dict")
  .initPairlist("Stack")
  assign("ts", list(), envir=froth.env)
  assign("vars", list(), envir=froth.env)
  .initDictionary()
  .initAliases()
}

## Execute a line of froth code
froth.parse <- function(inputline){
  .resetTempStacks()
  .parseLine(inputline)
  invisible(.evalPStack())
}

## Read from a file
froth.source <- function(filepath){
  if(!file.exists(filepath))
    stop("File not found!")
  l <- c(readLines(filepath), '')
  i <- 1L
  while(i < length(l)){
    nl <- l[i]
    while(grepl("\\\\ *$", nl)){
      i <- i+1L
      if(i > length(l)) break
      nl <- trimws(paste(nl, l[i]))
    }
    .parseLine(nl)
    .evalPStack()
    i <- i+1L
  }
}

## define R functions for use in froth
froth.RDefine <- function(name, fun, nargs){
  if(!is(nargs, 'integer')){
    if(is.numeric(nargs)) nargs <- as.integer(nargs)
    else stop("'nargs' must be an integer!")
  }
  if(!is.character(name) || length(name) != 1L) stop("Name must be a character vector of length 1!")
  if(!is.function(fun)) stop("fun must be a function!")
  .fdefine(tolower(name), \() {.doword('multiapply', fun, nargs)})
  invisible(.ok())
}

froth.RPush <- function(object){
  push(object)
}

froth.RPop <- function(nobj=1L){
  lapply(seq_len(nobj), \(i) pop())
}

saveFrothSession <- function(file=NULL, ...){
  d <- froth.env$Dict
  d <- d[vapply(d, is, logical(1L), class2="FrothUserEntry")]

  frothSession <- list(UserEntries=d, UserVars=froth.env$vars)
  saveRDS(frothSession, file=file, ...)
}

loadFrothSession <- function(file=NULL){
  x <- readRDS(file)
  if(!identical(c("UserEntries", "UserVars"), names(x)))
    stop("Invalid froth session loaded")
  .initPairlist("Dict")
  .initDictionary()
  .initAliases()
  froth.env$Dict <- c(froth.env$Dict, x$UserEntries)
  assign("vars", x$UserVars, envir=froth.env)
}

writeFrothDictionary <- function(file="", ...){
  d <- froth.env$Dict
  p <- vapply(d, is, logical(1L), class2="FrothUserEntry")
  d <- d[p]
  n <- names(d)
  for(i in seq_along(d)){
    defn <- d[[i]]
    defn <- strsplit(defn, r"(\)", fixed=TRUE)[[1]]
    defn[1] <- paste(":", toupper(n[i]), defn[1])
    defn[length(defn)] <- paste(defn[length(defn)], ';\n')
    defn <- paste(defn, collapse='\n  ')
    cat(defn, file=file)
  }
}
