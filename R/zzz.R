### internal hooks

froth.env <- new.env(hash=TRUE, parent=emptyenv())

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
  fs <- vector("list", 100L)
  assign("Dict", fs, envir=froth.env)
  assign("Stack", .Call("initFrothStack", PACKAGE = 'froth'), envir=froth.env)
  message("Done!")
}

.onDetach <- function(libname, pkgname){
  # this should spin down the stack
}
