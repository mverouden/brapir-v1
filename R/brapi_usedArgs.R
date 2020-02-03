### Internal function to obtain all used arguments within a function definition
### Originally the following code was used within a function definition:
### ## Create a list of used arguments
### usedArgs <- lapply(X = as.list(match.call()),
###                    FUN = eval,
###                    envir = parent.frame(n = 1))
### ## Remove function name from usedArgs list
### usedArgs[[1]] <- NULL
brapi_usedArgs <- function(origValues = FALSE) {
  # get formals for parent function
  parentFormals <- formals(sys.function(sys.parent(n = 1)))

  # Get names of implied arguments
  fnames <- names(parentFormals)

  # # Remove '...' from list of parameter names if it exists
  # fnames <- fnames[-which(fnames == '...')]

  # Get currently set values for named variables in the parent frame
  args <- evalq(as.list(environment()), envir = parent.frame(n = 1))

  # # Get the list of variables defined in '...'
  # args <- c(args[fnames], evalq(list(...), envir = parent.frame(n = 1)))

  if (origValues) {
    # get default values
    defArgs <- as.list(parentFormals)
    defArgs <- defArgs[unlist(lapply(defArgs, FUN = function(x) {class(x) != "name"}))]
    args[names(defArgs)] <- defArgs
    setArgs <- evalq(as.list(match.call())[-1], envir = parent.frame(n = 1))
    args[names(setArgs)] <- setArgs
  }
  return(args)
}
