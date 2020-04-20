#' @title
#' post /search/variables
#'
#' @description
#' Submit a search request for Observation Variables
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param dataTypes vector of type character; required: FALSE; List of scale data types to filter search results; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param methodDbIds vector of type character; required: FALSE; List of methods to filter search results; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param observationVariableDbIds vector of type character; required: FALSE; List of observation variable IDs to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param observationVariableNames vector of type character; required: FALSE; List of human readable observation variable names to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param observationVariableXrefs vector of type character; required: FALSE; List of cross references for the observation variable to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param ontologyDbIds vector of type character; required: FALSE; List of ontology IDs to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param page integer; required: FALSE; Which page of the &quot;data&quot; array to return. The page indexing starts at 0 (page=0 will return the first page). Default is 0.
#' @param pageSize integer; required: FALSE; The maximum number of items to return per page of the &quot;data&quot; array. Default is 1000.
#' @param scaleDbIds vector of type character; required: FALSE; List of scales to filter search results; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param scaleXrefs vector of type character; required: FALSE; List of cross references for the scale to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param traitClasses vector of type character; required: FALSE; List of trait classes to filter search results; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param traitDbIds vector of type character; required: FALSE; List of trait unique ID to filter search results; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param traitXrefs vector of type character; required: FALSE; List of cross references for the trait to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#'
#' @details Search observation variables.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references [BrAPI SwaggerHub](https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Observation\%20Variables/post_search_variables )
#'
#' @family brapi_1.3
#' @family Observation Variables
#' @family Search Services
#'
#' @export
brapi_post_search_variables <- function(con = NULL, dataTypes = '', methodDbIds = '', observationVariableDbIds = '', observationVariableNames = '', observationVariableXrefs = '', ontologyDbIds = '', page = 0, pageSize = 1000, scaleDbIds = '', scaleXrefs = '', traitClasses = '', traitDbIds = '', traitXrefs = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/search/variables",
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
  class(out) <- c(class(out), "brapi_post_search_variables")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
