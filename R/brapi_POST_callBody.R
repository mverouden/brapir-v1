### Internal function to create a call body for a POST call
brapi_POST_callBody <- function(usedArgs, reqArgs) {
  if (is.null(usedArgs[["con"]])) {return(NULL)}
  ## Preprocess required arguments
  if (grepl(pattern = ", ", x = reqArgs)) {
    reqArgs <- strsplit(x = reqArgs, split = ", ")[[1]]
  }
  ### Remove con and required arguments from used arguments list
  bodyArgs <- usedArgs
  bodyArgs[c("con", reqArgs)] <- NULL
  bodyList <- list()
  j <- 1

  for (i in seq_along(bodyArgs)) {
    if (any(is.null(bodyArgs[[i]]))) {
      bodyArgs[[i]] <- ""
    }
    if (any(is.na(bodyArgs[[i]]))) {
      bodyArgs[[i]] <- ""
    }
    if (all(bodyArgs[[i]] != "")) {
      if (inherits(x = bodyArgs[[i]], what = "character") && length(bodyArgs[[i]]) > 1) {
        bodyList[[j]] <- as.array(bodyArgs[[i]])
      } else {
        bodyList[[j]] <- bodyArgs[[i]]
      }
      names(bodyList)[j] <- names(bodyArgs)[i]
      j <- j + 1
    }
  }
  return(bodyList)
}
