### Internal function to check required and used arguments
brapi_checkArgs <- function(usedArgs, reqArgs) {
  ## Remove con list (connection object) from used arguments
  usedArgs[["con"]] <- NULL

  ## Check for the required arguments
  if (reqArgs != "") {
    ## Split when there is more than one required argument
    if (grepl(pattern = ", ", x = reqArgs)) {
      reqArgs <- strsplit(x = reqArgs, split = ", ")[[1]]
    }
    if (!all(reqArgs %in% names(usedArgs))) {
      stop('Required argument(s): "', paste(reqArgs[!reqArgs %in% names(usedArgs)], collapse = ", "), '" is/are undefined!')
    }
    reqArgs <- usedArgs[c(reqArgs)]
    for (i in names(reqArgs)) {
      ## Check if required argument is of type character
      if (!is.character(reqArgs[[i]])) {
        stop('Required argument: "', i, '" should be of type character, e.g. ', i, ' = "text".')
      }
      ## Check if required argument has more than zero characters
      if (!(nchar(reqArgs[[i]]) > 0)) {
        stop('Required argument: "', i, '" should at least have length one.')
      }
      if (i == "Accept" && !(usedArgs[[i]] %in% c("application/json", "text/csv", "text/tsv", "application/flapjack"))) {
        stop('Required argument: "', i, '" should be one of: "application/json"|"text/csv"|"text/tsv"|"application/flapjack".')
      }
    }
    ## Delete required arguments from used arguments
    usedArgs[names(reqArgs)] <- NULL
  }

  ## Argument matching for certain character strings with limited options
  reqMatch <- c("dataType",
                "format",
                "listType",
                "sortBy",
                "sortOrder")
  if (any(reqMatch %in% names(usedArgs))) {
    reqMatch <- reqMatch[reqMatch %in% names(usedArgs)]
    for (i in reqMatch) {
      switch(i,
             "dataType" = {
               brapi_matchArg(arg = usedArgs[[i]],
                          choices =  c("",
                                       "application/json",
                                       "text/csv",
                                       "text/tsv",
                                       "application/flapjack"))},
             "format" = {
               brapi_matchArg(arg = usedArgs[[i]],
                          choices =  c(as.character(NA),
                                       "csv",
                                       "tsv",
                                       "flapjack"))},
             "listType" = {
               brapi_matchArg(arg = usedArgs[[i]],
                          choices =  c("",
                                       "germplasm",
                                       "markers",
                                       "observations",
                                       "observationUnits",
                                       "observationVariables",
                                       "programs",
                                       "samples",
                                       "studies",
                                       "trials"))},
             "sortBy" = {
               brapi_matchArg(arg = usedArgs[[i]],
                          choices =  c("",
                                       "endDate",
                                       "locationDbId",
                                       "programDbId",
                                       "programName",
                                       "seasonDbId",
                                       "startDate",
                                       "studyDbId",
                                       "studyLocation",
                                       "studyName",
                                       "studyTypeDbId",
                                       "trialDbId",
                                       "trialName"))},
             "sortOrder" = {
               brapi_matchArg(arg = usedArgs[[i]],
                          choices =  c("",
                                       "asc",
                                       "ASC",
                                       "desc",
                                       "DESC"))})
    }
    ## Delete matched arguments from used arguments
    usedArgs[reqMatch] <- NULL
  }

  ## Check if there are still used arguments
  if (length(usedArgs) > 0) {
    ## Checking used arguments
    for (i in names(usedArgs)) {
      ## Check for arguments which are of type integer
      if (i %in% c("page", "pageSize", "min", "max")) {
        if (!is.numeric(usedArgs[[i]])) {
          stop('Argument: "', i, '" should be of type integer.')
        }
        if (i == "page" && usedArgs[[i]] < 0) {
          stop('Argument: "', i, '" should be >= 0 (0 is the default, meaning page number 1).')
        }
        if (i == "pageSize" && usedArgs[[i]] < 1) {
          stop('Argument: "', i, '" should be > 0.')
        }
        if ((i == "min" | i == "max") && ifelse(is.na(usedArgs[[i]]), FALSE, usedArgs[[i]] < 0)) {
          stop('Argument: "', i, '" should be >= 0.')
        }
        if (i == "page" | i == "pageSize") {
          usedArgs[[i]] <- NULL
        }
        next()
      }
      ## Check for arguments which are of type logical
      if (i %in% c("active", "expandHomozygotes", "includeSiblings", "includeSynonyms")) {
        if (!is.logical(usedArgs[[i]])) {
          stop('Argument: "', i, '" should be of type logical e.g. NA, TRUE or FALSE.')
        }
        usedArgs[[i]] <- NULL
        next()
      }
      ## Check any other argument to be of type character
      if (!is.character(usedArgs[[i]])) {
        stop('Argument: "', i, '" should be of type character e.g. "text".')
      }
      usedArgs[[i]] <- NULL
    }
    ## Check, when both min and max are present in used arguments and both are
    ## not NA, that min is smaller than or equal to max
    if (ifelse(all(c("min", "max") %in% names(usedArgs)), (!is.na(usedArgs[["min"]]) && !is.na(usedArgs[["max"]])), FALSE)) {
      if (!usedArgs[["min"]] <= usedArgs[["max"]]) {
        stop('Argument: "min" can never be larger than argument: "max".')
      }
    }
  }
}
