#' @title
#' get /samples/\{sampleDbId\}
#'
#' @description
#' Get the details of a specific Sample
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param sampleDbId character; required: TRUE; the internal DB id for a sample
#'
#' @details Used to retrieve the details of a single Sample from a Sample Tracking system.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Samples/get_samples__sampleDbId_ }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Samples
#'
#' @export
brapi_get_samples_sampleDbId <- function(con = NULL, sampleDbId = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "sampleDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/samples/{sampleDbId}",
                               reqArgs = "sampleDbId",
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
  class(out) <- c(class(out), "brapi_get_samples_sampleDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
