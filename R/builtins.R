.initDictionary <- function(){
  ## Initializing the dictionary of builtins
  .initCoreFunctions()
  .initIOFunctions()
  .initArithmeticFunctions()
  .initLogicalFunctions()
  .initControlFunctions()
}

.initAliases <- function(){
  ## Initializing aliases for builtins
  .initCoreAliases()
  .initIOAliases()
  .initArithmeticAliases()
  .initLogicalAliases()
  .initControlAliases()
}
