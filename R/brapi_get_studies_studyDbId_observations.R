#' @title
#' get /studies/\{studyDbId\}/observations
#'
#' @description
#' Get the Observations associated with a specific Study
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param studyDbId character; required: TRUE; Identifier of the study. Usually a number, could be alphanumeric.
#' @param observationVariableDbIds vector of type character; required: FALSE; Numeric `id` of that variable (combination of trait, unit and method)
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details
#' Retrieve all observations where there are measurements for the given observation variables. observationTimestamp should be ISO8601 format with timezone -&gt; YYYY-MM-DDThh:mm:ss+hhmm
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Studies/get_studies__studyDbId__observations }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Studies
#' @family Observations
#'
#' @export
brapi_get_studies_studyDbId_observations <- function(con = NULL, studyDbId = '', observationVariableDbIds = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "studyDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/studies/{studyDbId}/observations",
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
  class(out) <- c(class(out), "brapi_get_studies_studyDbId_observations")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
