#' @title
#' get /images
#'
#' @description
#' Get the image meta data summaries
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param imageDbId character; required: FALSE; The unique identifier for a image
#' @param imageName character; required: FALSE; The human readable name of an image
#' @param observationUnitDbId character; required: FALSE; The unique identifier of the observation unit an image is portraying
#' @param observationDbId character; required: FALSE; The unique identifier of the observation an image is accosiated with
#' @param descriptiveOntologyTerm character; required: FALSE; A descriptive term associated with an image
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Get filtered set of image meta data
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Images/get_images }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Images
#'
#' @export
brapi_get_images <- function(con = NULL, imageDbId = '', imageName = '', observationUnitDbId = '', observationDbId = '', descriptiveOntologyTerm = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/images",
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
  class(out) <- c(class(out), "brapi_get_images")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
