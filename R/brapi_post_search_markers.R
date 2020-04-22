#' @title
#' post /search/markers
#'
#' @description
#' Submit a search request for Markers
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param includeSynonyms logical; required: FALSE; Should an array of synonyms be included in the response; default: NA, other possible values: TRUE | FALSE
#' @param markerDbIds vector of type character; required: FALSE; List of IDs which uniquely identify markers ; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param markerNames vector of type character; required: FALSE; The search pattern for the marker name or synonym.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param matchMethod character; required: FALSE; How to perform string matching during search. 'exact' will search for exact, case sensitive matches only. 'case_insensitive' will search for exact matches, but case insensitive. 'wildcard' will allow the special characters '*' (star) and '%' (percent) to represent variable length arbitrary strings, and the special character '?' (question) to represent one arbitrary character.; default: &quot;&quot;.
#' @param page integer; required: FALSE; Which page of the &quot;data&quot; array to return. The page indexing starts at 0 (page=0 will return the first page). Default is 0.
#' @param pageSize integer; required: FALSE; The maximum number of items to return per page of the &quot;data&quot; array. Default is 1000.
#' @param types vector of type character; required: FALSE; The type of marker, e.g. SNP; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#'
#' @details
#' Other service requests use the servers internal `markerDbId`. This service returns marker records that provide the markerDbId. For the requested name or synonym, returns an array (possibly empty) of marker records that match the search criteria.
#'
#' If there is none, an empty array is returned. If there is one or more than one match, returns an array of all marker records that match the search criteria. '
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Markers/post_search_markers }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Markers
#' @family Search Services
#'
#' @export
brapi_post_search_markers <- function(con = NULL, includeSynonyms = NA, markerDbIds = '', markerNames = '', matchMethod = '', page = 0, pageSize = 1000, types = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/search/markers",
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
  class(out) <- c(class(out), "brapi_post_search_markers")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
