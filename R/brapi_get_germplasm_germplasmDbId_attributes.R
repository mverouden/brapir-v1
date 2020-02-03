#' @title
#' brapi_get_germplasm_germplasmDbId_attributes
#'
#' @description
#' Get the Germplasm Attributes associated with a specific Germplasm
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param germplasmDbId character; required: TRUE; The germplasm characterized
#' @param attributeDbIds vector of type character; required: FALSE; Restrict the response to only the listed attributeDbIds.
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Values for all attributes by default.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Germplasm%20Attributes/get_germplasm__germplasmDbId__attributes}{SwaggerHub}
#'
#' @family brapi_1.3
#' @family Germplasm Attributes
#' @family Germplasm
#'
#' @export
brapi_get_germplasm_germplasmDbId_attributes <- function(con = NULL, germplasmDbId = '', attributeDbIds = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "germplasmDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/germplasm/{germplasmDbId}/attributes",
                               reqArgs = "germplasmDbId",
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
  class(out) <- c(class(out), "brapi_get_germplasm_germplasmDbId_attributes")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
