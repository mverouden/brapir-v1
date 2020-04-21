#' @title
#' get /studies/\{studyDbId\}/table
#'
#' @description
#' Get the Observations for a specific Study in a table format
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param studyDbId character; required: TRUE; Identifier of the study. Usually a number, could be alphanumeric.
#' @param format character; required: FALSE; The format parameter will cause the data to be dumped to a file in the specified format. Currently, tsv and csv are supported.; default: as.character(NA), other possible values: &quot;csv&quot;, tsv&quot; and depending on the call &quot;flapjack&quot; may be supported.
#'
#' @details Retrieve the details of the study required for field data collection. Includes actual trait data.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Studies/get_studies__studyDbId__table }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Studies
#' @family Observations
#'
#' @export
brapi_get_studies_studyDbId_table <- function(con = NULL, studyDbId = '', format = as.character(NA)) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "studyDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/studies/{studyDbId}/table",
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
  class(out) <- c(class(out), "brapi_get_studies_studyDbId_table")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
