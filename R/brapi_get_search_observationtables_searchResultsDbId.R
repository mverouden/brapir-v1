#' @title
#' get /search/observationtables/\{searchResultsDbId\}
#'
#' @description
#' Get the results of a Observation table search request
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param Accept character; required: TRUE; The requested content type which should be returned by the server; default: &quot;application/json&quot;, other possible values: &quot;text/csv&quot;|&quot;text/tsv&quot;|&quot;application/flapjack&quot;
#' @param searchResultsDbId character; required: TRUE; Permanent unique identifier which references the search results
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details
#' Returns a list of observationUnit with the observed Phenotypes.
#' * observationTimeStamp - Iso Standard 8601.
#' * observationValue data type inferred from the ontology
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Observations/get_search_observationtables__searchResultsDbId_ }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Observations
#' @family Search Services
#'
#' @export
brapi_get_search_observationtables_searchResultsDbId <- function(con = NULL, Accept = 'application/json', searchResultsDbId = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "Accept, searchResultsDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/search/observationtables/{searchResultsDbId}",
                               reqArgs = "Accept, searchResultsDbId",
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
  class(out) <- c(class(out), "brapi_get_search_observationtables_searchResultsDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
