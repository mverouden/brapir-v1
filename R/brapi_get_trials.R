#' @title
#' get /trials
#'
#' @description
#' Get the breeding Trials
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param commonCropName character; required: FALSE; Common name for the crop associated with this trial
#' @param programDbId character; required: FALSE; Program filter to only return trials associated with given program id.
#' @param locationDbId character; required: FALSE; Filter by location
#' @param active logical; required: FALSE; Filter active status true/false.; default: NA, other possible values: TRUE | FALSE
#' @param sortBy character; required: FALSE; Sort order. Name of the field to sorty by.
#' @param sortOrder character; required: FALSE; Sort order direction: asc/desc; default: &quot;&quot;, other possible values: &quot;asc&quot;|&quot;ASC&quot;|&quot;desc&quot;|&quot;DESC&quot;
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Retrieve a filtered list of Trials. A Trial is a collection of studies
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Trials/get_trials }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Trials
#'
#' @export
brapi_get_trials <- function(con = NULL, commonCropName = '', programDbId = '', locationDbId = '', active = NA, sortBy = '', sortOrder = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/trials",
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
  class(out) <- c(class(out), "brapi_get_trials")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
