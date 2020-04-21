#' @title
#' get /people
#'
#' @description
#' Get the People
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param firstName character; required: FALSE; A persons first name
#' @param lastName character; required: FALSE; A persons last name
#' @param personDbId character; required: FALSE; The unique ID of a person
#' @param userID character; required: FALSE; A systems user ID ascociated with this person. Different from personDbId because you could have a person who is not a user of the system.
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Get filtered list of people
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/People/get_people }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family People
#'
#' @export
brapi_get_people <- function(con = NULL, firstName = '', lastName = '', personDbId = '', userID = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/people",
                               reqArgs = "",
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
  class(out) <- c(class(out), "brapi_get_people")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
