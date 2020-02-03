brapi_serverinfo_pagination <- function(cont) {
  if (jsonlite::validate(txt = cont)) {
    contList <- jsonlite::fromJSON(txt = cont)
  } else {
    return()
  }
  if (is.null(contList[["metadata"]])) {
    return()
  } else{
    pagination <- contList[["metadata"]][["pagination"]]
    if (!is.null(pagination)) {
      brapi_message(msg = paste0("Returning page ",
                                 pagination[["currentPage"]],
                                 " (max. ",
                                 ifelse(as.integer(pagination[["totalPages"]]) == 0, 0, as.integer(pagination[["totalPages"]]) - 1),
                                 ") with max. ",
                                 pagination[["pageSize"]],
                                 " items (out of a total of ",
                                 pagination[["totalCount"]],
                                 ")."))
    }
  }
}
