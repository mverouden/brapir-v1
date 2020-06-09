#' @title
#' put /studies/\{studyDbId\}/observations
#'
#' @description
#' Update the Observations or create new Observations of a specific Study
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param studyDbId character; required: TRUE; Identifier of the study. Usually a number, could be alphanumeric.
#' @param observations data.frame; required: TRUE; data.frame of observation references to be created or updated with default: &quot;&quot;; Each row in the  `observations` data.frame represents a single observation and can consist of the following columns:
#'
#'   * `collector` vector of type character; the name or identifier of the entity which collected each observation.
#'   * `observationDbId`  vector of type character; the internal database identifier of each existing observation to be updated.
#'   * `observationTimeStamp` vector of type character; The date and time each individual observation was taken and specified in the ISO 8601 standard, e.g. for two observations c("2020-06-09T10:18:29.000Z", "2020-06-09T10:18:40.010Z")
#'   * `observationUnitDbId` vector of type character; the unique internal database identifier specifying the observation unit for each observation.
#'   * `observationVariableDbId` vector of type character; the internal database identifier of the trait for each observation
#'   * `value` vector of type character; the value of each observation as specified by the observation variable defined by its `observationVariableDbId` in the previous column.
#'
#' The Examples Section shows an example of how to construct the `observations` argument as a data.frame object.
#'
#' @details The following rules are used for updating observations and creating new observations:
#'
#'   * If an `observationDbId` is &quot;null&quot; or an empty string in the request, a NEW observation should be created for the given study and observationUnit
#'   * If an `observationDbId` is populated but not found in the database, a NEW observation should be created for the given study and observationUnit AND an NEW `observationDbId` should be assigned to it. A warning should be returned to the client.
#'   * If an `observationDbId` is populated and found in the database, but the existing entry is not associated with the given study or observationUnit, a NEW observation should be created for the given study and observationUnit AND an NEW `observationDbId` should be assigned to it. A warning should be returned to the client.
#'   * If an `observationDbId` is populated and found in the database and is associated with the given study and observationUnit, then it should be updated with the new data given.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Studies/put_studies__studyDbId__observations }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Studies
#' @family Observations
#'
#' @examples
#' \dontrun{
#'
#' # Create a connection object
#' con <- brapi_db()$testserver
#'
#' # Create an observations data.frame
#' # containing the observations to be updated and added
#' # 1) change Plant Height (observationVariableDbId = "MO_123:100002")
#' #    from 1.1. to 2.1 for Plant 1 (observationUnitDbId = "2") matching
#' #    observationDbId = "3"
#' # 2) add Virus severity (observationVariableDbId = "MO_123:100006")
#' #    of 0.8 for Plant 2 (observationUnitDbId = "4")
#' observations <- data.frame(
#'   collector = c("Jack", "Freddy"),
#'   observationDbId = c("3", ""),
#'   observationTimeStamp = c(
#'     paste0(anytime::iso8601(lubridate::with_tz(Sys.time(),
#'                                                tzone = "UTC")),
#'            "Z"),
#'     paste0(anytime::iso8601(lubridate::with_tz(Sys.time(),
#'                                                tzone = "UTC")),
#'            "Z")),
#'   observationUnitDbId = c("2", "4"),
#'   obserbationVariableDbId = c("MO_123:100002", "MO_123:100006"),
#'   value = c("2.2", "0.8"))
#'
#' # Make put /studies/{studyDbId}/observations call
#' brapi_put_studies_studyDbId_observations(con = con,
#'                                          studyDbId = '1001',
#'                                          observations = observations)
#' }
#'
#' @export
brapi_put_studies_studyDbId_observations <- function(con = NULL, studyDbId = '', observations = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check if usedArgs[["observations"]] is supplied as empty character vector
  if (inherits(usedArgs[["observations"]], what = "character") && usedArgs[["observations"]] == "") {
    stop('Required argument: "observations" should be supplied as a data.frame, see the help page on how the data.frame should be constructed.')
  }
  observations <- usedArgs[["observations"]]
  if (!inherits(x = observations, what = "data.frame")) {
    stop('Required argument: "observations" should be supplied as a data.frame, see the help page on how the data.frame should be constructed.')
  }
  usedArgs[["observations"]] <- NULL
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "studyDbId")
  ## Put observations back into usedArgs
  usedArgs[["observations"]] <- observations
  ## Obtain the call url
  callurl <- brapi_PUT_callURL(usedArgs = usedArgs,
                               callPath = "/studies/{studyDbId}/observations",
                               reqArgs = "studyDbId",
                               packageName = "BrAPI",
                               callVersion = 1.3)
  ## Build the Body
  callbody <- brapi_PUT_callBody(usedArgs = usedArgs,
                                 reqArgs = "studyDbId")
  try({
    ## Make the call and receive the response
    resp <- brapi_PUT(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_put_studies_studyDbId_observations")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
