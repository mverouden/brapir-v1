#' @title
#' brapi_get_studies_studyDbId_observationunits
#'
#' @description
#' Get the Observation Units associated with a specific Study
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param studyDbId character; required: TRUE; The study these observation units are related to.
#' @param observationLevel character; required: FALSE; The granularity level of observation units. Either `plotNumber` or `plantNumber` fields will be relavant depending on whether granularity is plot or plant respectively.
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details The main API call for field data collection, to retrieve all the observation units within a study.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Studies/get_studies__studyDbId__observationunits}{SwaggerHub}
#'
#' @family brapi_1.3
#' @family Studies
#' @family Observations
#'
#' @export
brapi_get_studies_studyDbId_observationunits <- function(con = NULL, studyDbId = '', observationLevel = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "studyDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/studies/{studyDbId}/observationunits",
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
  class(out) <- c(class(out), "brapi_get_studies_studyDbId_observationunits")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
