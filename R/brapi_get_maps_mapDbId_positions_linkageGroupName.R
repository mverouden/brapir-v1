#' @title
#' brapi_get_maps_mapDbId_positions_linkageGroupName
#'
#' @description
#' Get the positions of Markers inside a specific Linkage Group
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param mapDbId character; required: TRUE; unique id of the map
#' @param linkageGroupName character; required: TRUE; The chromosome identifier or the generic linkage group identifier if the chromosome is not applicable.
#' @param min integer; required: FALSE; minimum position on linkage group
#' @param max integer; required: FALSE; maximum position on linkage group
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details All the markers in a specific Linkage Group (aka Chromasome) inside a particular Map, ordered by position.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Genome%20Maps/get_maps__mapDbId__positions__linkageGroupName_}{SwaggerHub}
#'
#' @family brapi_1.3
#' @family Genome Maps
#'
#' @export
brapi_get_maps_mapDbId_positions_linkageGroupName <- function(con = NULL, mapDbId = '', linkageGroupName = '', min = as.integer(NA), max = as.integer(NA), page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "mapDbId, linkageGroupName")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/maps/{mapDbId}/positions/{linkageGroupName}",
                               reqArgs = "mapDbId, linkageGroupName",
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
  class(out) <- c(class(out), "brapi_get_maps_mapDbId_positions_linkageGroupName")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
