#' @title
#' brapi_get_variables_observationVariableDbId
#'
#' @description
#' Get the details for a specific Observation Variable
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param observationVariableDbId character; required: TRUE; string id of the variable
#'
#' @details Retrieve variable details
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Observation%20Variables/get_variables__observationVariableDbId_ }{SwaggerHub}
#'
#' @family brapi_1.3
#' @family Observation Variables
#'
#' @export
brapi_get_variables_observationVariableDbId <- function(con = NULL, observationVariableDbId = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "observationVariableDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/variables/{observationVariableDbId}",
                               reqArgs = "observationVariableDbId",
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
  class(out) <- c(class(out), "brapi_get_variables_observationVariableDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
