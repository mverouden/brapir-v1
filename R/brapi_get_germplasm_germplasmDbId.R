#' @title
#' get /germplasm/\{germplasmDbId\}
#'
#' @description
#' Get the details of a specific Germplasm
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param germplasmDbId character; required: TRUE; The internal id of the germplasm
#'
#' @details Germplasm Details by germplasmDbId was merged with Germplasm Multi
#' Crop Passport Data. The MCPD fields are optional and marked with the prefix
#' \[MCPD\].
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Germplasm/get_germplasm__germplasmDbId_}{SwaggerHub}
#'
#' @family brapi_1.3
#' @family Germplasm
#'
#' @export
brapi_get_germplasm_germplasmDbId <- function(con = NULL, germplasmDbId = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "germplasmDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/germplasm/{germplasmDbId}",
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
  class(out) <- c(class(out), "brapi_get_germplasm_germplasmDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
