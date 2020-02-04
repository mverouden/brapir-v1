#' @title
#' get /scales/\{scaleDbId\}
#'
#' @description
#' Get the details of a specific Scale
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param scaleDbId character; required: TRUE; Id of the scale to retrieve details of.
#'
#' @details
#' Retrieve details about a specific scale.
#'
#' An Observation Variable has 3 critical parts:
#' * a Trait being observed,
#' * a Method for making the observation, and
#' * a Scale on which the observation can be measured and compared with other observations.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Observation%20Variables/get_scales__scaleDbId_}{SwaggerHub}
#'
#' @family brapi_1.3
#' @family Observation Variables
#'
#' @export
brapi_get_scales_scaleDbId <- function(con = NULL, scaleDbId = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "scaleDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/scales/{scaleDbId}",
                               reqArgs = "scaleDbId",
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
  class(out) <- c(class(out), "brapi_get_scales_scaleDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
