#' @title
#' post /search/programs
#'
#' @description
#' Submit a search request for Programs
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param abbreviations vector of type character; required: FALSE; An abbreviation of a program to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param commonCropNames vector of type character; required: FALSE; Common name for the crop which this program is for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param leadPersonDbIds vector of type character; required: FALSE; The person DbIds of the program leader to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param leadPersonNames vector of type character; required: FALSE; The names of the program leader to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param objectives vector of type character; required: FALSE; A program objective to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param page integer; required: FALSE; Which page of the &quot;data&quot; array to return. The page indexing starts at 0 (page=0 will return the first page). Default is 0.
#' @param pageSize integer; required: FALSE; The maximum number of items to return per page of the &quot;data&quot; array. Default is 1000.
#' @param programDbIds vector of type character; required: FALSE; A program identifier to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param programNames vector of type character; required: FALSE; A name of a program to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#'
#' @details Advanced searching for the programs resource.
#' See Search Services for additional implementation details.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references [BrAPI SwaggerHub](https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Programs/post_search_programs )
#'
#' @family brapi_1.3
#' @family Programs
#' @family Search Services
#'
#' @export
brapi_post_search_programs <- function(con = NULL, abbreviations = '', commonCropNames = '', leadPersonDbIds = '', leadPersonNames = '', objectives = '', page = 0, pageSize = 1000, programDbIds = '', programNames = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/search/programs",
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
  class(out) <- c(class(out), "brapi_post_search_programs")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
