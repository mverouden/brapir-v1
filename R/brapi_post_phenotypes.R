#' @title
#' post /phenotypes
#'
#' @description
#' Add new Observation Unit Phenotypes
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param format character; required: FALSE; In case where JSON data is zipped for faster transfer speed (as in the case of the IRRI handheld implementation), the zipped JSON file will be listed in datafiles. The zipped file contains a JSON file with the same structure as the BrAPI call.; default: as.character(NA), other possible values: &quot;csv&quot;, tsv&quot; and depending on the call &quot;flapjack&quot; may be supported.
#' @param data data.frame; required: TRUE, with default: &quot;&quot;; data.frame of observation data recorded for different observation variables across different observation units. The data data.frame requires to contain the following columns:
#'
#'   * observatioUnitDbId character; required: TRUE
#'   * studyDbId character; required: TRUE; Identifier of the study. Usually a number, could be alphanumeric.
#'   * observations data.frame; required: TRUE; the observations data.frame has required and optional columns:
#'       + collector character; required: TRUE; the name or identifier of the entity which collected the observation
#'       + observationDbId character; required: FALSE; the ID which uniquely identifies an observation
#'       + observationTimeStamp character; required: TRUE; the date and time when this observation was made and specified in the ISO 8601 format
#'       + observationVariableDbId character; required: TRUE; variable unique identifier
#'       + observationVariableName character; required: TRUE;	a human readable name for an observation variable
#'       + season	character; required: FALSE; the season when the observation data was collected
#'       + value character; required: TRUE; the value of the data collected as an observation
#'
#' The Examples Section show an example of how to construct the data argument as a nested data.frame.
#'
#' @details
#' Along with the study specific phenotype saving calls (in the observationUnit and table formats), this call allows phenotypes to be saved  and images to optionally be transferred as well.
#'
#' Call to invoke for saving the measurements (observations) collected from field for all the observation units.
#'
#' Observation timestamp should be ISO 8601 https://www.w3.org/TR/NOTE-datetime
#'
#' In case where JSON data is zipped for faster transfer speed (as in the case of the IRRI handheld implementation), the zipped JSON file will be listed in datafiles. The zipped file contains a JSON file with the same structure as the BrAPI call. In this case a format parameter should be passed as well.
#'
#' Images can be optionally be uploaded using this call by providing a zipfile of all images in the datafiles, along with the actual zipfile in multi-part form data.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Phenotypes/post_phenotypes }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Phenotypes
#' @family Observations
#'
#' @examples
#' \dontrun{
#'
#' # Create a connection object
#' con <- brapi_db()$testserver
#'
#' # Create an example data.frame data object
#' data <- data.frame(
#'   observatioUnitDbId = "7",
#'   studyDbId = "1002"
#' )
#' datadf <- data.frame(
#'   collector = c("C. Technical", "C. Technical"),
#'   observationDbId = c("", ""),
#'   observationTimeStamp = c("2020-05-15T15:30:00.760Z", "2020-05-15T15:31:16.760Z"),
#'   observationVariableDbId = c("MO_123:100002", "MO_123:100003"),
#'   observationVariableName = c("Plant height", "Carotenoid"),
#'   season = c("spring", "spring"),
#'   value = c("1.75", "1.4")
#' )
#' data[["observations"]] <- list(datadf)
#'
#' # Make post /phenotypes call
#' brapi_post_phenotypes(con = con,
#'                       format = as.character(NA),
#'                       data = data)
#' }
#'
#' @export
brapi_post_phenotypes <- function(con = NULL, format = as.character(NA), data = "") {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check if usedArgs[["data]] is supplied as empty character vector
  if (inherits(usedArgs[["data"]], what = "character") && usedArgs[["data"]] == "") {
    stop('Required argument: "data" should be supplied as a data.frame, see the help page on how the data.frame should be constructed.')
  }
  data <- usedArgs[["data"]]
  if (!inherits(x = data, what = "data.frame")) {
    stop('Required argument: "data" should be supplied as a data.frame, see the help page on how the data.frame should be constructed.')
  }
  usedArgs[["data"]] <- NULL
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Put data back into usedArgs
  usedArgs[["data"]] <- data
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/phenotypes",
                                reqArgs = "",
                                packageName = "BrAPI",
                                callVersion = 1.3)
  ## Build the Body
  callbody <- brapi_POST_callBody(usedArgs = usedArgs,
                                  reqArgs = "")
  try({
    ## Make the call and receive the response
    resp <- brapi_POST(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_post_phenotypes")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
