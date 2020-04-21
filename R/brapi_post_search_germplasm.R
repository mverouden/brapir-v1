#' @title
#' post /search/germplasm
#'
#' @description
#' Submit a search request for Germplasm
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param accessionNumbers vector of type character; required: FALSE; List unique identifiers for accessions within a genebank; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param commonCropNames vector of type character; required: FALSE; List crops to search by; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param germplasmDbIds vector of type character; required: FALSE; List of IDs which uniquely identify germplasm; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param germplasmGenus vector of type character; required: FALSE; List of Genus names to identify germplasm; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param germplasmNames vector of type character; required: FALSE; List of human readable names to identify germplasm; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param germplasmPUIs vector of type character; required: FALSE; List of Permanent Unique Identifiers to identify germplasm; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param germplasmSpecies vector of type character; required: FALSE; List of Species names to identify germplasm; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param page integer; required: FALSE; Which page of the &quot;data&quot; array to return. The page indexing starts at 0 (page=0 will return the first page). Default is 0.
#' @param pageSize integer; required: FALSE; The maximum number of items to return per page of the &quot;data&quot; array. Default is 1000.
#'
#' @details Search for a set of germplasm based on some criteria
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Germplasm/post_search_germplasm }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Germplasm
#' @family Search Services
#'
#' @export
brapi_post_search_germplasm <- function(con = NULL, accessionNumbers = '', commonCropNames = '', germplasmDbIds = '', germplasmGenus = '', germplasmNames = '', germplasmPUIs = '', germplasmSpecies = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/search/germplasm",
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
  class(out) <- c(class(out), "brapi_post_search_germplasm")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
