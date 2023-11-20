.initDictionary <- function(){
  ## Initializing the dictionary of builtins
  .initCoreFunctions()
  .initStackFunctions()
  .initIOFunctions()
  .initArithmeticFunctions()
  .initLogicalFunctions()
  .initControlFunctions()
}

.initAliases <- function(){
  ## Initializing aliases for builtins
  .initCoreAliases()
  .initStackAliases()
  .initIOAliases()
  .initArithmeticAliases()
  .initLogicalAliases()
  .initControlAliases()
}
