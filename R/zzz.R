### internal hooks

.onLoad <- function(libname, pkgname){

}

.onUnload <- function(libpath){
  # this should ensure no stacks exist,
  # and destroy them if necessary

  library.dynam.unload("froth", libpath)
}

froth.env <- new.env(hash=TRUE, parent=parent.frame())
.onAttach <- function(libname, pkgname){
  # This should set up the stack used
  message("Welcome to froth!")
  message("Initializing froth stack...")
  l <- vector('list', 100L)
  fs <- vector('list', 100L)
  i <- 0L
  assign("Froth.Objects", l, envir=froth.env)
  assign("Froth.Dict", fs, envir=froth.env)
  assign("Froth.Index", i, envir=froth.env)
  exptr <- .Call("initFrothStack", get("Froth.Objects", envir=froth.env))
  assign("Froth.Stack", exptr, envir=froth.env)
  message("Done!")
}

.onDetach <- function(libname, pkgname){
  # this should spin down the stack
}
