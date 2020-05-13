#' @title
#' post /lists
#'
#' @description
#' Create a New List
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param data vector of type character; required: FALSE; ; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param description character; required: FALSE; ; default: &quot;&quot;.
#' @param listName character; required: FALSE; ; default: &quot;&quot;.
#' @param listOwnerName character; required: FALSE; ; default: &quot;&quot;.
#' @param listOwnerPersonDbId character; required: FALSE; ; default: &quot;&quot;.
#' @param listSize integer; required: FALSE; default: 0.
#' @param listSource character; required: FALSE; ; default: &quot;&quot;.
#' @param listType character; required: FALSE; ; default: &quot;&quot;, other possible values: &quot;germplasm&quot;|&quot;markers&quot;|&quot;observations&quot;|&quot;observationUnits&quot;|&quot;observationVariables&quot;|&quot;programs&quot;|&quot;samples&quot;|&quot;studies&quot;|&quot;trials&quot;
#'
#' @details Create a new list
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Lists/post_lists }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Lists
#'
#' @export
brapi_post_lists <- function(con = NULL, data = '', description = '', listName = '', listOwnerName = '', listOwnerPersonDbId = '', listSize = 0, listSource = '', listType = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/lists",
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
  class(out) <- c(class(out), "brapi_post_lists")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
