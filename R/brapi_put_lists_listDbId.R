#' @title
#' put /lists/\{listDbId\}
#'
#' @description
#' Update a specific List
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param listDbId character; required: TRUE; The unique ID of this generic list; default: &quot;&quot;
#' @param data vector of type character; required: FALSE; data items to be update in the specific list; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param description character; required: FALSE with default: &quot;&quot;.
#' @param listName character; required: FALSE with default: &quot;&quot;.
#' @param listOwnerName character; required: FALSE with default: &quot;&quot;.
#' @param listOwnerPersonDbId character; required: FALSE; database identifier of the person owning the specific list; default: &quot;&quot;.
#' @param listSize integer; required: FALSE with default: 0.
#' @param listSource character; required: FALSE with default: &quot;&quot;.
#' @param listType character; required: FALSE; ; default: &quot;&quot;, other possible values: &quot;germplasm&quot;|&quot;markers&quot;|&quot;observations&quot;|&quot;observationUnits&quot;|&quot;observationVariables&quot;|&quot;programs&quot;|&quot;samples&quot;|&quot;studies&quot;|&quot;trials&quot;
#'
#' @details Update an existing generic list
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Lists/put_lists__listDbId_ }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Lists
#'
#' @export
brapi_put_lists_listDbId <- function(con = NULL, listDbId = '', data = '', description = '', listName = '', listOwnerName = '', listOwnerPersonDbId = '', listSize = 0, listSource = '', listType = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "listDbId")
  ## Obtain the call url
  callurl <- brapi_PUT_callURL(usedArgs = usedArgs,
                               callPath = "/lists/{listDbId}",
                               reqArgs = "listDbId",
                               packageName = "BrAPI",
                               callVersion = 1.3)
  ## Build the Body
  callbody <- brapi_PUT_callBody(usedArgs = usedArgs,
                                 reqArgs = "listDbId")
  try({
    ## Make the call and receive the response
    resp <- brapi_PUT(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_put_lists_listDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
