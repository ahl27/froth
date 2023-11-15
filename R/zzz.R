### internal hooks

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
}

.onDetach <- function(libname, pkgname){
  # this should spin down the stack
}
