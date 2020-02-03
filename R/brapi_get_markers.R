#' @title
#' brapi_get_markers
#'
#' @description
#' Get the Markers
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param markerDbId character; required: FALSE; The database ID of the markers to search for
#' @param markerName character; required: FALSE; The search paramater for a marker name or synonym.
#' @param includeSynonyms logical; required: FALSE; Whether to include synonyms in the output.; default: NA, other possible values: TRUE | FALSE
#' @param type character; required: FALSE; The type of the marker.
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Other service requests use the servers internal `markerDbId`. This service returns marker records that provide the markerDbId. For the requested name or synonym, returns an array (possibly empty) of marker records that match the search criteria.
#'
#' If there is none, an empty array is returned. If there is one or more than one match, returns an array of all marker records that match the search criteria.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Markers/get_markers}{SwaggerHub}
#'
#' @family brapi_1.3
#' @family Markers
#'
#' @export
brapi_get_markers <- function(con = NULL, markerDbId = '', markerName = '', includeSynonyms = NA, type = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/markers",
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
  class(out) <- c(class(out), "brapi_get_markers")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
