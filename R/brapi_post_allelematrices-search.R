#' @title
#' post /allelematrices-search
#'
#' @description
#' Submit a request to get a Matrix of Allele data
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param expandHomozygotes logical; required: FALSE; Should homozygotes be expanded (true) or collapsed into a single occurence (false); default: NA, other possible values: TRUE | FALSE
#' @param format character; required: FALSE; The data format of the response data. ie &quot;json&quot;, &quot;tsv&quot;, etc; default: as.character(NA), other possible values: &quot;csv&quot;, &quot;tsv&quot;, and depending on the call &quot;flapjack&quot; may be supported.
#' @param markerDbId vector of type character; required: FALSE; An ID which uniquely identifies a Marker; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param markerProfileDbId vector of type character; required: FALSE; An ID which uniquely identifies a Marker Profile; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param matrixDbId vector of type character; required: FALSE; An ID which uniquely identifies an Allele Matrix; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param page integer; required: FALSE; Which page of the &quot;data&quot; array to return. The page indexing starts at 0 (page=0 will return the first page). Default is 0.
#' @param pageSize integer; required: FALSE; The maximum number of items to return per page of the &quot;data&quot; array. Default is 1000.
#' @param sepPhased character; required: FALSE; The string to use as a separator for phased allele calls.; default: &quot;&quot;.
#' @param sepUnphased character; required: FALSE; The string to use as a separator for unphased allele calls.; default: &quot;&quot;.
#' @param unknownString character; required: FALSE; The string to use as a representation for missing data.; default: &quot;&quot;.
#'
#' @details
#' This uses a more efficient data structure and pagination for large number of markers.
#'
#' Use POST when parameter size is greater than 2K bytes.
#'
#' - If no format is specified, this call returns the data in JSON form.
#' - If a format (other than JSON) is specified and the server supports this format, it will return the link to the exported data file in the &quot;datafiles&quot; field of the &quot;metadata&quot;.
#' - If more than one format is requested at a time, the server will throw a &quot;501 Not Implemented&quot; error.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Marker%20Profiles/post_allelematrices_search }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Marker Profiles
#'
#' @export
brapi_post_allelematrices_search <- function(con = NULL, expandHomozygotes = NA, format = as.character(NA), markerDbId = '', markerProfileDbId = '', matrixDbId = '', page = 0, pageSize = 1000, sepPhased = '', sepUnphased = '', unknownString = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/allelematrices-search",
                                reqArgs = "",
                                packageName = "BrAPI",
                                callVersion = 1.3)
  ## Build the Body
  callbody <- brapi_POST_callBody(usedArgs = usedArgs,
                                  reqArgs = "")
  try({
    ## Make the call and receive the response
    resp <- brapi_POST(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_post_allelematrices_search")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
