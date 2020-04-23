#' @title
#' post /search/samples
#'
#' @description
#' Submit a search request for Samples
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param germplasmDbIds vector of type character; required: FALSE;  The ID which uniquely identifies a germplasm; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param observationUnitDbIds vector of type character; required: FALSE; The ID which uniquely identifies an observation unit; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is 0.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is 1000.
#' @param plateDbIds vector of type character; required: FALSE; The ID which uniquely identifies a plate of samples; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param sampleDbIds vector of type character; required: FALSE; The ID which uniquely identifies a sample; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#'
#' @details Used to retrieve list of Samples from a Sample Tracking system based on some search criteria.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Samples/post_search_samples }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Samples
#' @family Search Services
#'
#' @export
brapi_post_search_samples <- function(con = NULL, germplasmDbIds = '', observationUnitDbIds = '', page = 0, pageSize = 1000, plateDbIds = '', sampleDbIds = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/search/samples",
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
  class(out) <- c(class(out), "brapi_post_search_samples")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
