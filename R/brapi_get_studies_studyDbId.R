#' @title
#' get /studies/\{studyDbId\}
#'
#' @description
#' Get the details for a specific Study
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param studyDbId character; required: TRUE; Identifier of the study. Usually a number, could be alphanumeric.
#'
#' @details
#' Retrieve the information of the study required for field data collection
#'
#' An additionalInfo field was added to provide a controlled vocabulary for less common data fields.
#'
#' Linked data:
#' * Observation Variables: ```/brapi/v1/studies/{studyDbId}/observationvariables```
#' * Germplasm: ```/brapi/v1/studies/{studyDbId}/germplasm```
#' * Observation Units: ```/brapi/v1/studies/{studyDbId}/observationunits```
#' * Layout: ```brapi/v1/studies/{studyDbId}/layout```
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Studies/get_studies__studyDbId_ }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Studies
#'
#' @export
brapi_get_studies_studyDbId <- function(con = NULL, studyDbId = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "studyDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/studies/{studyDbId}",
                               reqArgs = "studyDbId",
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
  class(out) <- c(class(out), "brapi_get_studies_studyDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
