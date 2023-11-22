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
  .initPairlist("PStack")
  .initPairlist("Dict")
  .initPairlist("Stack")
  .initPairlist("CStack")
  .initPairlist("RStack")
  assign("ts", list(), envir=froth.env)
  assign("vars", list(), envir=froth.env)
  packageStartupMessage("Done!")
  packageStartupMessage("Initializing dictionary...")
  .initDictionary()
  .initAliases()
  packageStartupMessage("Done!")
}
