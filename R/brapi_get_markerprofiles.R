#' @title
#' get /markerprofiles
#'
#' @description
#' Get the Marker Profiles
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param germplasmDbId character; required: FALSE; The server's internal ids for the Germplasm IDs, as returned by the Find marker profile by Germplasm service.
#' @param studyDbId character; required: FALSE; The server's internal id for the StudyDbId
#' @param sampleDbId character; required: FALSE; The server's internal id for the SampleDbId
#' @param extractDbId character; required: FALSE; The server's internal id for the ExtractDbId
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details For the requested Germplasm Id and/or Extract Id, returns the Markerprofile Id and number of non-missing allele calls (marker/allele pairs).
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Marker%20Profiles/get_markerprofiles}{SwaggerHub}
#'
#' @family brapi_1.3
#' @family Marker Profiles
#'
#' @export
brapi_get_markerprofiles <- function(con = NULL, germplasmDbId = '', studyDbId = '', sampleDbId = '', extractDbId = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/markerprofiles",
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
  class(out) <- c(class(out), "brapi_get_markerprofiles")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
