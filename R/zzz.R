### internal hooks

froth.env <- new.env(hash=TRUE, parent=emptyenv())

.onLoad <- function(libname, pkgname){
}

.onUnload <- function(libpath){
  library.dynam.unload("froth", libpath)
}

.onAttach <- function(libname, pkgname){
  # This should set up the stack used
  packageStartupMessage("Welcome to froth!")
  packageStartupMessage("Initializing froth stack...")
  assign("PStack", .Call("initFrothStack", PACKAGE = 'froth'), envir=froth.env)
  assign("Dict", .Call("initFrothStack", PACKAGE = 'froth'), envir=froth.env)
  assign("Stack", .Call("initFrothStack", PACKAGE = 'froth'), envir=froth.env)
  packageStartupMessage("Done!")
  packageStartupMessage("Initializing dictionary...")
  .initDictionary()
  .initAliases()
  packageStartupMessage("Done!")
}

.onDetach <- function(libname, pkgname){
}
