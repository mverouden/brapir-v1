#' @title
#' post /lists/\{listDbId\}/items
#'
#' @description
#' Add Items to a specific List
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param listDbId character; required: TRUE; The unique ID of this generic list; default: &quot;&quot;
#' @param items vector of type character; required: TRUE; Items to be added to the generic list; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#'
#' @details Add new data items to a specific generic lists
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Lists/post_lists__listDbId__items }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Lists
#'
#' @export
brapi_post_lists_listDbId_items <- function(con = NULL, listDbId = '', items = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "listDbId, items")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/lists/{listDbId}/items",
                                reqArgs = "listDbId",
                                packageName = "BrAPI",
                                callVersion = 1.3)
  ## Build the Body
  callbody <- brapi_POST_callBody(usedArgs = usedArgs,
                                  reqArgs = "listDbId")
  callbody <- callbody[["items"]]
  ## Add-ons to usedArgs to make an array of strings POST call
  usedArgs[["Accept"]] <- "application/json"
  usedArgs[["Content-Type"]] <- "application/json"
  try({
    ## Make the call and receive the response
    resp <- brapi_POST(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_post_lists_listDbId_items")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
