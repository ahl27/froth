.initIOFunctions <- function(){
  .fdefine('.', \() {cat(pop(), ''); .ok()})
  .fdefine('.R', \() {print(pop()); .ok()})
  .fdefine('emit', \() {cat(intToUtf8(pop())); .ok()})
  .fdefine('."', .catString)
  .fdefine('spaces', \() {cat(rep(' ', pop())); .ok()})
  .fdefine('space', \() {cat(' '); .ok()})
  .fdefine('cr', \() {cat('\n'); .ok()})
  .fdefine('u.r', \(){. <- pop(); cat(format(x=pop(), width=.)); .ok()})
}

.initIOAliases <- function(){

}


.catString <- function(){
  while(!is.null(. <- pop_op(FALSE))){
    if(grepl('\"$', .)){
      cat(substring(., 1, nchar(.)-1L), '')
      break
    }
    cat(., '')
  }
  .ok()
}
