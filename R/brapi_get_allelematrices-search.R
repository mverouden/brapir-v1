#' @title
#' get /allelematrices-search
#'
#' @description
#' Get the a Matrix of Allele data
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param markerProfileDbId vector of type character; required: FALSE; The marker Profile db ids. Not Required if 'markerDbId' or 'matrixDbId' is present.
#' @param markerDbId vector of type character; required: FALSE; ids of the markers. if none are specified, results are returned for all markers in the database. Not Required if 'markerProfileDbId' or 'matrixDbId' is present.
#' @param matrixDbId vector of type character; required: FALSE;
#' @param format character; required: FALSE; format for the datafile to be downloaded. tsv and csv currently supported; flapjack may be supported.; default: as.character(NA), other possible values: &quot;csv&quot;, tsv&quot; and depending on the call &quot;flapjack&quot; may be supported.
#' @param expandHomozygotes logical; required: FALSE; Should homozygotes NOT be collapsed into a single occurrence?; default: NA, other possible values: TRUE | FALSE
#' @param unknownString character; required: FALSE; The string to use as a representation for missing data or the reserved word &quot;empty_string&quot;.
#' @param sepPhased character; required: FALSE; The string to use as a separator for phased allele calls or the reserved word &quot;empty_string&quot;.
#' @param sepUnphased character; required: FALSE; The string to use as a separator for unphased allele calls or the reserved word &quot;empty_string&quot;.
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details  This uses a more efficient data structure and pagination for large
#' number of markers. Use this `GET`` when parameter size is less than 2K bytes.
#'
#'  This method may support asynchronous processing.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Marker%20Profiles/get_allelematrices_search }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Marker Profiles
#'
#' @export
brapi_get_allelematrices_search <- function(con = NULL, markerProfileDbId = '', markerDbId = '', matrixDbId = '', format = as.character(NA), expandHomozygotes = NA, unknownString = '', sepPhased = '', sepUnphased = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/allelematrices-search",
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
  class(out) <- c(class(out), "brapi_get_allelematrices-search")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
