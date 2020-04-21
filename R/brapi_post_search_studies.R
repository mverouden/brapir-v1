#' @title
#' post /search/studies
#'
#' @description
#' Submit a search request for Studies
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param active logical; required: FALSE; Is this study currently active; default: NA, other possible values: TRUE | FALSE
#' @param commonCropNames vector of type character; required: FALSE; Common names for the crop associated with this study; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param germplasmDbIds vector of type character; required: FALSE; List of IDs which uniquely identify germplasm; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param locationDbIds vector of type character; required: FALSE; List of location names to filter search results; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param observationVariableDbIds vector of type character; required: FALSE; List of observation variable IDs to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param page integer; required: FALSE; Which page of the &quot;data&quot; array to return. The page indexing starts at 0 (page=0 will return the first page). Default is 0.
#' @param pageSize integer; required: FALSE; The maximum number of items to return per page of the &quot;data&quot; array. Default is 1000.
#' @param programDbIds vector of type character; required: FALSE; List of program identifiers to filter search results; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param programNames vector of type character; required: FALSE; List of program names to filter search results; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param seasonDbIds vector of type character; required: FALSE; The ID which uniquely identifies a season; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param sortBy character; required: FALSE; Name of one of the fields within the study object on which results can be sorted; default: &quot;&quot;.
#' @param sortOrder character; required: FALSE; Order results should be sorted. ex. &quot;ASC&quot; or &quot;DESC&quot;; default: &quot;&quot;.
#' @param studyDbIds vector of type character; required: FALSE; List of study identifiers to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param studyNames vector of type character; required: FALSE; List of study names to filter search results; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param studyTypeDbIds vector of type character; required: FALSE; The unique identifier of the type of study being performed.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param studyTypeNames vector of type character; required: FALSE; The name of the type of study being performed. ex. &quot;Yield Trial&quot;, etc; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param trialDbIds vector of type character; required: FALSE; List of trial identifiers to filter search results; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#'
#' @details Get list of studies
#' StartDate and endDate should be ISO8601 format for dates
#' See Search Services for additional implementation details.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Studies/post_search_studies }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Studies
#' @family Search Services
#'
#' @export
brapi_post_search_studies <- function(con = NULL, active = NA, commonCropNames = '', germplasmDbIds = '', locationDbIds = '', observationVariableDbIds = '', page = 0, pageSize = 1000, programDbIds = '', programNames = '', seasonDbIds = '', sortBy = '', sortOrder = '', studyDbIds = '', studyNames = '', studyTypeDbIds = '', studyTypeNames = '', trialDbIds = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/search/studies",
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
  class(out) <- c(class(out), "brapi_post_search_studies")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
