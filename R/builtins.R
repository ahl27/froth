.initDictionary <- function(){
  ## Initializing the dictionary of builtins
  .initCoreFunctions()
  .initStackFunctions()
  .initIOFunctions()
  .initArithmeticFunctions()
  .initLogicalFunctions()
  .initControlFunctions()
  .initVariableFunctions()
}

.initAliases <- function(){
  ## Initializing aliases for builtins
  .initCoreAliases()
  .initStackAliases()
  .initIOAliases()
  .initArithmeticAliases()
  .initLogicalAliases()
  .initControlAliases()
  .initVariableAliases()
}
