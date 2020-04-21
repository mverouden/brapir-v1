#' @title
#' get /observationunits
#'
#' @description
#' Get the Observation Units
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param germplasmDbId character; required: FALSE; The unique ID of a germplasm (accession) to filter on
#' @param observationVariableDbId character; required: FALSE; The unique ID of an observation variable
#' @param studyDbId character; required: FALSE; The unique ID of a studies to filter on
#' @param locationDbId character; required: FALSE; The unique ID of a location where these observations were collected
#' @param trialDbId character; required: FALSE; The unique ID of a trial to filter on
#' @param programDbId character; required: FALSE; The unique ID of a program to filter on
#' @param seasonDbId character; required: FALSE; The year or Phenotyping campaign of a multi-annual study (trees, grape, ...)
#' @param observationLevel character; required: FALSE; The type of the observationUnit. Returns only the observation unit of the specified type; the parent levels ID can be accessed through observationUnitStructure.
#' @param observationTimeStampRangeStart character; required: FALSE; Timestamp range start
#' @param observationTimeStampRangeEnd character; required: FALSE; Timestamp range end
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Get a set of observation units
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Observations/get_observationunits }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Observations
#'
#' @export
brapi_get_observationunits <- function(con = NULL, germplasmDbId = '', observationVariableDbId = '', studyDbId = '', locationDbId = '', trialDbId = '', programDbId = '', seasonDbId = '', observationLevel = '', observationTimeStampRangeStart = '', observationTimeStampRangeEnd = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/observationunits",
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
  class(out) <- c(class(out), "brapi_get_observationunits")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
