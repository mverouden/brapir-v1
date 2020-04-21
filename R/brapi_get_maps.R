#' @title
#' get /maps
#'
#' @description
#' Get the Genomic Maps
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param commonCropName character; required: FALSE; The common name of the crop, found from &quot;GET /commoncropnames&quot;
#' @param scientificName character; required: FALSE; Full scientific binomial format name. This includes Genus, Species, and Sub-species
#' @param type character; required: FALSE; Type of map
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Get list of maps
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Genome%20Maps/get_maps }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Genome Maps
#'
#' @export
brapi_get_maps <- function(con = NULL, commonCropName = '', scientificName = '', type = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/maps",
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
  class(out) <- c(class(out), "brapi_get_maps")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
