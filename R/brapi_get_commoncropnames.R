#' @title
#' brapi_get_commoncropnames
#'
#' @description
#' Get the Common Crop Names
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details
#' List the common crop names for the crops available in a database server.
#'
#' This call is **required** for multi-crop systems where data from multiple
#' crops may be stored in the same database server. A distinct database server
#' is defined by everything in the URL before &quot;/brapi/v1&quot;, including
#' host name and base path. The call is recommended for single crop systems to
#' be compatible with multi-crop clients. For a single crop system the response
#' should contain an array with exactly 1 element.
#'
#' The common crop name can be used as a search parameter for Programs, Studies,
#' and Germplasm.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Crops/get_commoncropnames}{SwaggerHub}
#'
#' @family brapi_1.3
#' @family Crops
#'
#' @export
brapi_get_commoncropnames <- function(con = NULL, page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/commoncropnames",
                               reqArgs = "",
                               packageName = "BrAPI",
                               callVersion = 1.3)

  try({
    ## Make the call and receive the response
    resp <- brapi_GET(url = callurl, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_get_commoncropnames")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
