### Internal function for parsing the result part of the response content into
### a flattened data.frame object
#' @importFrom utils as.relistable read.csv read.delim
brapi_result2df <- function(cont, usedArgs) {
  ## Helper functions
  jointDetail <- function(detailDat, colName) {
    detailDatCol <- data.frame(detailDat[[colName]],
                               stringsAsFactors = FALSE)
    if (!colName %in% c("taxonIds", "seasons", "studies")) {
      names(detailDatCol) <- paste(colName, names(detailDatCol), sep = ".")
    }
    detailDat[[colName]] <- NULL
    if (nrow(detailDatCol) > 0) {
      detailDat <-  detailDat[rep(seq_len(nrow(detailDat)), each = nrow(detailDatCol)), ]
      df <- cbind(detailDat, detailDatCol)
    } else {# nrow(detailDatCol) == 0
      df <- detailDat
    }
    row.names(df) <- seq_len(nrow(df))
    df <- jsonlite::flatten(df)
    return(df)
  }
  if ("format" %in% names(usedArgs) && is.na(usedArgs[["format"]])) {
    usedArgs[["format"]] <- NULL
  }
  ## Process result to data.frame
  if ("format" %in% names(usedArgs)) {
    ## three possibilities "csv", "tsv" and "flapjack"
    switch(usedArgs[["format"]],
           "csv" = {
             dat <- read.csv(file = textConnection(cont),
                             stringsAsFactors = FALSE)
             colnames(dat) <- gsub(pattern = "\\.",
                                   replacement = ":",# or "|",
                                   x = colnames(dat))},
           "tsv" = {
             dat <- read.delim(file = textConnection(cont),
                               stringsAsFactors = FALSE)
             colnames(dat) <- gsub(pattern = "\\.",
                                   replacement = ":",# or "|",
                                   x = colnames(dat))},
           "flapjack" = {
             dat <- read.delim(file = textConnection(cont),
                               stringsAsFactors = FALSE)})
  } else {
    ## Parse JSON content into a list that consists of a metadata and result
    ## element
    contList <- jsonlite::fromJSON(txt = cont)
    ## Use only the result element from the content list (contList)
    resultList <- contList[["result"]]
    ## resultList can consist of:
    ## 1) master (no pagination only one line)
    ## 2) detail (only a "data" element)
    ## 3) master/detail (parse "data" element and repeat master part to match dimensions)
    if ("data" %in% names(resultList)) {
      payload <- ifelse(test = length(resultList) == 1,
                        yes = "detail",
                        no =  "master/detail")
    } else {
      payload <- "master"
    }
    switch(payload,
           "master" = {
             if (all(lengths(resultList) <= 1)) {
               ## use only lengths == 1
               master <- as.data.frame(resultList[lengths(resultList) == 1],
                                       stringsAsFactors = FALSE)
               dat <- master
             } else {
               master <- as.data.frame(resultList[lengths(resultList) == 1],
                                       stringsAsFactors = FALSE)
               tempmaster <- list()
               for (l1name in names(which(lengths(resultList) > 1))) {
                 switch(class(resultList[[l1name]]),
                        "character" = {
                          tempmaster[[l1name]] <- paste(resultList[[l1name]],
                                                        collapse = ", ")
                        },
                        "data.frame" = {
                          for (i in seq_len(nrow(resultList[[l1name]]))) {
                            for (j in seq_along(resultList[[l1name]])) {
                              tempmaster[[paste(l1name,
                                                colnames(resultList[[l1name]][j]),
                                                i,
                                                sep = ".")]] <- resultList[[l1name]][i, j]
                            }
                          }
                        },
                        "list" = {
                          templist <- as.list(data.frame(t(as.matrix(unlist(as.relistable(resultList[[l1name]])))),
                                                         stringsAsFactors = FALSE))
                          names(templist) <- paste(l1name, names(templist), sep = ".")
                          tempmaster <- c(tempmaster, templist)
                        })
               }
               if (length(master) == 0) {
                 dat <- as.data.frame(tempmaster, stringsAsFactors = FALSE)
               } else {
                 dat <- cbind(master, as.data.frame(tempmaster, stringsAsFactors = FALSE))
               }
             }
           },
           "detail" = {
             if (inherits(resultList[["data"]], what = "data.frame")) {
               detail <- as.data.frame(x = jsonlite::flatten(resultList[["data"]],
                                                             recursive = TRUE),
                                       stringsAsFactors = FALSE)
             } else {
               detail <- as.data.frame(x = resultList[["data"]],
                                       stringsAsFactors = FALSE)
             }
             namesListCols <- names(which(sapply(X = detail,
                                                 FUN = inherits,
                                                 what = "list")))
             for (colName in namesListCols) {
               ## list of data.frame
               if (all(sapply(X = detail[[colName]],
                              FUN = inherits,
                              what = "data.frame"))) {
                 ## Determine rows with non-empty data.frames
                 nonEmptyDetailRows <- which(lengths(detail[[colName]]) != 0)
                 ## Create an empty data.frame with columnnames
                 tempColNames <- names(jointDetail(detail[nonEmptyDetailRows[1], ], colName))
                 tempDetail <- data.frame(matrix(ncol = length(tempColNames), nrow = 0))
                 names(tempDetail) <- tempColNames
                 nrows <- nrow(detail)
                 if (nrows >= 1) {
                   for (i in seq_len(nrows)) {
                     if (i %in% nonEmptyDetailRows) {
                       nextRow <- jointDetail(detail[i, ], colName)
                       tempDetail <- dplyr::bind_rows(tempDetail, nextRow)
                       rm(nextRow)
                     } else {# i %in% emptyDetailRows
                       partRowDetail <- detail[i, -c(which(names(detail) == colName))]
                       extColNames <- setdiff(names(tempDetail), names(partRowDetail))
                       partRowExt <- data.frame(matrix(data = NA, nrow = 1, ncol = length(extColNames)))
                       names(partRowExt) <- extColNames
                       nextRow <- dplyr::bind_cols(partRowDetail, partRowExt)
                       tempDetail <- dplyr::bind_rows(tempDetail, nextRow)
                       rm(partRowDetail, partRowExt, extColNames, nextRow)
                     }
                   }
                 }
                 tempDetail[[colName]] <- NULL
                 ## Remove duplicated rows
                 tempDetail <- tempDetail[!duplicated(tempDetail), ]
                 ## Row renumbering
                 rownames(tempDetail) <- seq_len(nrow(tempDetail))
               }
               ## list of character
               if (all(sapply(X = detail[[colName]],
                              FUN = inherits,
                              what = "character"))) {
                 detail[[colName]] <- sapply(X = detail[[colName]],
                                             FUN = paste,
                                             collapse = "; ")
               }
               ## list of list
               if (all(sapply(X = detail[[colName]],
                              FUN = inherits, what = "list"))) {
                 if (all(lengths(detail[[colName]]) == 0)) {
                   ## list of empty lists
                   detail[[colName]] <- NULL
                 }
               }
               if (exists("tempDetail")) {
                 detail <- tempDetail
                 rm(tempDetail)
               }
             }
             dat <- detail
           },
           "master/detail" = {##headerRow! e.g. /search/observationtables/{searchResultsDbId}
             ## Process master part
             masterList <- resultList[!names(resultList) %in% "data"]
             if (all(c("headerRow", "observationVariableDbIds", "observationVariableNames") %in% names(masterList))) {
               headerRow <- c(masterList[["headerRow"]],
                              paste(masterList[["observationVariableNames"]],
                                    masterList[["observationVariableDbIds"]],
                                    sep = "|"))
             } else {
               if (!all(lengths(masterList) <= 1)) {
                 master <- masterList[lengths(masterList) == 1]
                 tempmaster <- list()
                 for (l1name in names(which(lengths(masterList) > 1))) {
                   switch(class(masterList[[l1name]]),
                          "character" = {
                            tempmaster[[l1name]] <- paste(masterList[[l1name]],
                                                          collapse = ", ")
                          },
                          "data.frame" = {
                            for (i in seq_len(nrow(masterList[[l1name]]))) {
                              for (j in seq_along(masterList[[l1name]])) {
                                tempmaster[[paste(l1name,
                                                  colnames(masterList[[l1name]][j]),
                                                  i,
                                                  sep = ".")]] <- masterList[[l1name]][i, j]
                              }
                            }
                          },
                          "list" = {
                            templist <- as.list(data.frame(t(as.matrix(unlist(as.relistable(masterList[[l1name]])))),
                                                           stringsAsFactors = FALSE))
                            names(templist) <- paste(l1name, names(templist), sep = ".")
                            tempmaster <- c(tempmaster, templist)
                          })
                 }
                 if (length(master) == 0) {
                   master <- tempmaster
                 } else {
                   master <- c(master, tempmaster)
                 }
               } else {
                 master <-  masterList[lengths(masterList) == 1]
               }
             }
             ## Process detail part
             if (inherits(resultList[["data"]], what = "data.frame")) {
               detail <- as.data.frame(x = jsonlite::flatten(resultList[["data"]],
                                                             recursive = TRUE),
                                       stringsAsFactors = FALSE)
             } else {
               detail <- as.data.frame(x = resultList[["data"]],
                                       stringsAsFactors = FALSE)
             }
             if (exists("headerRow")) {
               colnames(detail) <- headerRow
               namesListCols <- names(detail)
             } else {
               namesListCols <- names(which(sapply(X = detail,
                                                   FUN = inherits,
                                                   what = "list")))
             }
             for (colName in namesListCols) {
               ## list of data.frame
               if (all(sapply(X = detail[[colName]],
                              FUN = inherits,
                              what = "data.frame"))) {
                 ## Determine rows with non-empty data.frames
                 nonEmptyDetailRows <- which(lengths(detail[[colName]]) != 0)
                 ## Create an empty data.frame with columnnames
                 tempColNames <- names(jointDetail(detail[nonEmptyDetailRows[1], ], colName))
                 tempDetail <- data.frame(matrix(ncol = length(tempColNames), nrow = 0))
                 names(tempDetail) <- tempColNames
                 nrows <- nrow(detail)
                 if (nrows >= 1) {
                   for (i in seq_len(nrows)) {
                     if (i %in% nonEmptyDetailRows) {
                       nextRow <- jointDetail(detail[i, ], colName)
                       tempDetail <- dplyr::bind_rows(tempDetail, nextRow)
                       rm(nextRow)
                     } else {# i %in% emptyDetailRows
                       partRowDetail <- detail[i, -c(which(names(detail) == colName))]
                       extColNames <- setdiff(names(tempDetail), names(partRowDetail))
                       partRowExt <- data.frame(matrix(data = NA, nrow = 1, ncol = length(extColNames)))
                       names(partRowExt) <- extColNames
                       nextRow <- dplyr::bind_cols(partRowDetail, partRowExt)
                       tempDetail <- dplyr::bind_rows(tempDetail, nextRow)
                       rm(partRowDetail, partRowExt, extColNames, nextRow)
                     }
                   }
                 }
                 tempDetail[[colName]] <- NULL
                 ## Remove duplicated rows
                 tempDetail <- tempDetail[!duplicated(tempDetail), ]
                 ## Row renumbering
                 rownames(tempDetail) <- seq_len(nrow(tempDetail))
               }
               ## list of character
               if (all(sapply(X = detail[[colName]],
                              FUN = inherits,
                              what = "character"))) {
                 detail[[colName]] <- sapply(X = detail[[colName]],
                                             FUN = paste,
                                             collapse = "; ")
               }
               ## list of list
               if (all(sapply(X = detail[[colName]],
                              FUN = inherits,
                              what = "list"))) {
                 if (all(lengths(detail[[colName]]) == 0)) {
                   ## list of empty lists
                   detail[[colName]] <- NULL
                 }
               }
               if (exists("tempDetail")) {
                 detail <- tempDetail
                 rm(tempDetail)
               }
             }
             if (exists("headerRow")) {
               dat <- detail
             } else {
               dat <- cbind(as.data.frame(master, stringsAsFactors = FALSE), detail)
             }
           })
  }
  return(dat)
}
