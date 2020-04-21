#' @title
#' get /lists/\{listDbId\}
#'
#' @description
#' Get the details of a specific List
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param listDbId character; required: TRUE; The unique ID of this generic list
#'
#' @details Get a specific generic lists
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Lists/get_lists__listDbId_ }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Lists
#'
#' @export
brapi_get_lists_listDbId <- function(con = NULL, listDbId = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "listDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/lists/{listDbId}",
                               reqArgs = "listDbId",
                               packageName = "BrAPI",
                               callVersion = 1.3)

  try({
    ## Make the call and receive the response
    resp <- brapi_GET(url = callurl, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_get_lists_listDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
