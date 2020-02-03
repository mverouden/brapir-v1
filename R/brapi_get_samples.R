#' @title
#' brapi_get_samples
#'
#' @description
#' Get the Samples
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param sampleDbId character; required: FALSE; the internal DB id for a sample
#' @param observationUnitDbId character; required: FALSE; the internal DB id for an observation unit where a sample was taken from
#' @param plateDbId character; required: FALSE; the internal DB id for a plate of samples
#' @param germplasmDbId character; required: FALSE; the internal DB id for a germplasm
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Used to retrieve list of Samples from a Sample Tracking system based on some search criteria.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Samples/get_samples}{SwaggerHub}
#'
#' @family brapi_1.3
#' @family Samples
#'
#' @export
brapi_get_samples <- function(con = NULL, sampleDbId = '', observationUnitDbId = '', plateDbId = '', germplasmDbId = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/samples",
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
  class(out) <- c(class(out), "brapi_get_samples")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
