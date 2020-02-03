### Internal function to create a callURL for a GET call
brapi_GET_callURL <- function(usedArgs, callPath, reqArgs, packageName, callVersion) {
  if (is.null(usedArgs[["con"]])) {return(NULL)}
  ## Preprocess required arguments
  if (grepl(pattern = ", ", x = reqArgs)) {
    reqArgs <- strsplit(x = reqArgs, split = ", ")[[1]]
  }
  ## Check for correct protocol
  if (usedArgs[["con"]][["secure"]]) {usedArgs[["con"]][["protocol"]] <- "https://"}
  ## Assign port
  port <- ifelse(usedArgs[["con"]][["port"]] == 80, "", paste0(":", usedArgs[["con"]][["port"]]))
  ## Add apipath when not  NULL
  if (!is.null(usedArgs[["con"]][["apipath"]])) {
    usedArgs[["con"]][["apipath"]] <- paste0("/", usedArgs[["con"]][["apipath"]])
  }
  ## Add Brapi vesion (now /brapi/v1, in future e.g. /BrAPI-Core/2.0)
  version <- paste0("v", as.character(floor(callVersion))) # yields v1 or v2
  brapiVersion <- paste0("/",
                         tolower(strsplit(x = packageName,
                                          split = "-")[[1]][1]), # yields brapi
                         "/",
                         version)
  ## Correction for multicrop databases when call does not require {commoncropname}
  if (callPath == "/commoncropnames" || callPath == "/calls") {
    usedArgs[["con"]][["multicrop"]] <- FALSE
  }
  ## Create pointbase callurl:
  ## http(s)://db:port/{apipath}/{commoncropname}/brapi/v?
  if (usedArgs[["con"]][["multicrop"]]) {
    if (usedArgs[["con"]][["commoncropname"]] == "") {
      stop('In the connection object there needs to be a commoncropname for a multicrop system.')
    }
    if (length(usedArgs[["con"]][["commoncropname"]]) > 1) {
      stop('In the connection object there can only be one commoncropname be specified for a multicrop system.')
    }
    callurl <- paste0(usedArgs[["con"]][["protocol"]],
                      usedArgs[["con"]][["db"]],
                      port, usedArgs[["con"]][["apipath"]],
                        "/", usedArgs[["con"]][["commoncropname"]], brapiVersion)
  } else {
    callurl <- paste0(usedArgs[["con"]][["protocol"]],
                      usedArgs[["con"]][["db"]],
                      port, usedArgs[["con"]][["apipath"]],
                      brapiVersion)
  }
  ## Extend pointbase callurl with call path to create call url
  pathVector <- strsplit(callPath, split = "\\{|\\}")[[1]]
  for (i in seq_along(pathVector)) {
    if (grepl(pattern = "^/", x = pathVector[i])) {
      callurl <- paste0(callurl, pathVector[i])
    } else {
      callurl <- paste0(callurl, usedArgs[[pathVector[i]]])
    }
  }
  ### Remove con and required arguments from used arguments list
  queryArgs <- usedArgs
  queryArgs[c("con", reqArgs)] <- NULL
  if (length(queryArgs) == 0) {
    return(callurl)
  } else {
    queryNames <- names(queryArgs)
    forbidden <- "[/?&]$"
    ### Add query parameters to call url
    if ("pageSize" %in% queryNames) {
      queryArgs[["pageSize"]] <- ifelse(queryArgs[["pageSize"]] == 1000,
                                        "",
                                        queryArgs[["pageSize"]])
    }
    if ("page" %in% names(queryArgs)) {
      queryArgs[["page"]] <- ifelse(queryArgs[["page"]] == 0,
                                    "",
                                    queryArgs[["page"]])
    }
    queryParams <- list()
    j <- 1
    for (i in seq_along(queryArgs)) {
      if (nchar(names(queryArgs)[[i]]) == 0) {
        base::stop("All parameters must have a name.")
      }
      if (is.logical(queryArgs[[i]])) {
        queryArgs[[i]] <- tolower(queryArgs[[i]])
      }
      if (length(queryArgs[[i]]) == 1) {
        if (is.na(queryArgs[[i]])) {queryArgs[[i]] <- ""}
      }
      if (!is.null(queryArgs[[i]]) && queryArgs[[i]] != "") {
        queryArgs[[i]] <- sub(forbidden, "", queryArgs[[i]])
        queryParams[[j]] <- paste0(queryNames[i], "=", paste(queryArgs[[i]], collapse = ","))
        j <- j + 1
      }
    }
    callurl <- gsub(pattern = " ",
                    replacement = "%20",
                    x = paste0(callurl, "?", paste(queryParams, collapse = "&")))
    return(sub(pattern = forbidden,
               replacement = "",
               x = callurl))
  }
}
