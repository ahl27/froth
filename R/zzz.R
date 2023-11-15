### internal hooks

froth.env <- new.env(hash=TRUE, parent=emptyenv())
FROTH_MIN_VALUE <- 1L

.onLoad <- function(libname, pkgname){

}

.onUnload <- function(libpath){
  # this should ensure no stacks exist,
  # and destroy them if necessary

  library.dynam.unload("froth", libpath)
}

.onAttach <- function(libname, pkgname){
  # This should set up the stack used
  message("Welcome to froth!")
  message("Initializing froth stack...")
  l <- vector('list', 100L)
  fs <- vector('list', 100L)
  i <- 1L
  assign("Objects", l, envir=froth.env)
  assign("Dict", fs, envir=froth.env)
  assign("Index", i, envir=froth.env)
  assign("SStart", FROTH_MIN_VALUE, envir=froth.env)
  exptr <- .Call("initFrothStack", froth.env$Stack)
  assign("Stack", exptr, envir=froth.env)
  message("Done!")
}

.onDetach <- function(libname, pkgname){
  # this should spin down the stack
}
