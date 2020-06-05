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
    if (any(is.na(bodyArgs[[i]])) || (inherits(bodyArgs[[i]], what = "list") && length(bodyArgs[[i]]) == 0)) {
      bodyArgs[[i]] <- ""
    }
    if (all(bodyArgs[[i]] != "") || inherits(x = bodyArgs[[i]], what = c("data.frame", "list"))) {
      if (inherits(x = bodyArgs[[i]], what = "character") &&
          length(bodyArgs[[i]]) == 1 &&
          grepl(pattern = "(Classes)|(Genus)|(Ids)|(Links)|(Names)|(Numbers)|(PUIs)|(Species)|(synonyms)|(Terms)|(tions)|(Xrefs)|(ypes)|(markerDbId)|(markerProfileDbId)|(matrixDbId)|(objectives)",
                x = names(bodyArgs[i]))) {
        bodyList[[j]] <- as.array(bodyArgs[[i]])
      } else if (inherits(x = bodyArgs[[i]], what = "character") && length(bodyArgs[[i]]) > 1) {
        bodyList[[j]] <- as.array(bodyArgs[[i]])
      } else if (is.logical(bodyArgs[[i]])) {
        bodyList[[j]] <- tolower(bodyArgs[[i]])
      } else if (names(bodyArgs)[i] == "validValues" && bodyArgs[[i]][["categories"]] == "" ) {
        bodyArgs[[i]][["categories"]] <- as.array(bodyArgs[[i]][["categories"]])
        bodyList[[j]] <- bodyArgs[[i]]
      } else {
        bodyList[[j]] <- bodyArgs[[i]]
      }
      names(bodyList)[j] <- names(bodyArgs)[i]
      j <- j + 1
    }
  }
  return(bodyList)
}
