#' @title
#' post /search/observationtables
#'
#' @description
#' Submit a search request for a table of Observations
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param germplasmDbIds vector of type character; required: FALSE; The name or synonym of external genebank accession identifiers; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param locationDbIds vector of type character; required: FALSE; locations these traits were collected; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param observationLevel character; required: FALSE; The type of the observationUnit. Returns only the observation unit of the specified type; the parent levels ID can be accessed through observationUnit Structure.; default: &quot;&quot;.
#' @param observationTimeStampRangeEnd character; required: FALSE; Timestamp range end; default: &quot;&quot;.
#' @param observationTimeStampRangeStart character; required: FALSE; Timestamp range start; default: &quot;&quot;.
#' @param observationVariableDbIds vector of type character; required: FALSE; The IDs of traits, could be ontology ID, database ID or PUI; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param page integer; required: FALSE; Which page of the &quot;data&quot; array to return. The page indexing starts at 0 (page=0 will return the first page). Default is 0.
#' @param pageSize integer; required: FALSE; The maximum number of items to return per page of the &quot;data&quot; array. Default is 1000.
#' @param programDbIds vector of type character; required: FALSE; list of programs to search across; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param seasonDbIds vector of type character; required: FALSE; The year or Phenotyping campaign of a multi-annual study (trees, grape, ...); default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param studyDbIds vector of type character; required: FALSE; The database ID / PK of the studies search parameter; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param trialDbIds vector of type character; required: FALSE; list of trials to search across; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#'
#' @details Returns a list of observationUnit with the observed Phenotypes. observationTimeStampRangeStart and observationTimeStampRangeEnd need to be specified in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) formatting.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Observations/post_search_observationtables }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Observations
#' @family Search Services
#'
#' @export
brapi_post_search_observationtables <- function(con = NULL, germplasmDbIds = '', locationDbIds = '', observationLevel = '', observationTimeStampRangeEnd = '', observationTimeStampRangeStart = '', observationVariableDbIds = '', page = 0, pageSize = 1000, programDbIds = '', seasonDbIds = '', studyDbIds = '', trialDbIds = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/search/observationtables",
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
  class(out) <- c(class(out), "brapi_post_search_observationtables")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
