#' @title
#' post /studies/\{studyDbId\}/table
#'
#' @description
#' Submit new Observations in a table format for a specific Study
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param studyDbId character; required: TRUE; Identifier of the study. Usually a number, could be alphanumeric.
#' @param data data.frame; required: TRUE; data frame of observation data recorded for different observation variables across different observation units; default: &quot;&quot;.
#' @param headerRow vector of type character; required: TRUE; The header row describing the data frame. Append 'observationVariableDbIds' for complete header row of the table. This vector of type character should contain any or all of the following strings; year, studyDbId, studyName, locationDbId, locationName, germplasmDbId, germplasmName, observationUnitDbId, plotNumber, replicate, blockNumber, entryType, X, Y; default: &quot;&quot;, when using multiple values supply as c(&quot;year&quot;, &quot;studyDbId&quot;, ...).
#' @param observationVariableDbIds vector of type character; required: TRUE; The list of observation variable identifiers which have values recorded for them in the data frame. Append to the 'headerRow' for complete header row; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#'
#' @details This call can be used to create new observations in bulk.
#'
#' Note: If you need to update any existing observation, please use `PUT /studies/{studyDbId}/observations`. This call should only be used to create **NEW** observations.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Studies/post_studies__studyDbId__table }{BrAPI SwaggerHub}
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
#' # Create an example data.frame data object
#' data <- data.frame(
#'   year = c("2019", "2019", "2020", "2020"),
#'   studyDbId = c("1001", "1001", "1001", "1001"),
#'   studyName = c("Study 1", "Study 1", "Study 1", "Study 1"),
#'   locationDbId = c("1", "1", "1", "1"),
#'   locationName = c("Peru", "Peru", "Peru", "Peru"),
#'   germplasmDbId = c("1", "1", "2", "2"),
#'   germplasmName  = c("Name001", "Name001", "Name002", "Name002"),
#'   observationUnitDbId = c("1", "2", "3", "4"),
#'   plotNumber = c("1", "1", "2", "2"),
#'   replicate = c("0", "0", "0", "0"),
#'   blockNumber = c("1", "1", "1", "1"),
#'   entryType = c("FILLER", "TEST", "FILLER", "FILLER"),
#'   X = c("1", "1", "1", "1"),
#'   Y = c("1", "2", "3", "4"),
#'   'MO_123:100002' = c("1.0", "1.1", "1.2", "1.3"),
#'   'MO_123:100003' = c("2.1", "2.2", "2.3", "2.4"),
#'   'MO_123:100005' = c("light blue", "blue", "dark blue", "blue"),
#'   'MO_123:100006' = c("4.3", "4.2", "4.0", "4.1"))
#'
#' # Create a headerRow character vector
#' headerRow <- c("year",
#'                "studyDbId",
#'                "studyName",
#'                "locationDbId",
#'                "locationName",
#'                "germplasmDbId",
#'                "germplasmName",
#'                "observationUnitDbId",
#'                "plotNumber",
#'                "replicate",
#'                "blockNumber",
#'                "entryType",
#'                "X",
#'                "Y")
#'
#' # Create an observationVariableDbIds character vector
#' observationVariableDbIds <- c("MO_123:100002",
#'                               "MO_123:100003",
#'                               "MO_123:100005",
#'                               "MO_123:100006")
#'
#' # Make post /studies/{studyDbId}/table call
#' brapi_post_studies_studyDbId_table(con = con,
#'                                    studyDbId = "1001",
#'                                    data = data,
#'                                    headerRow = headerRow,
#'                                    observationVariableDbIds = observationVariableDbIds)
#' }
#'
#' @export
brapi_post_studies_studyDbId_table <- function(con = NULL, studyDbId = '', data = '', headerRow = '', observationVariableDbIds = '') {
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
  brapi_checkArgs(usedArgs, reqArgs = "studyDbId, headerRow, observationVariableDbIds")
  ## Put data back into usedArgs as as a matrix
  usedArgs[["data"]] <- as.matrix(data)
  ## Strip column names from usedArgs[["data"]]
  colnames(usedArgs[["data"]]) <- NULL
  ## Check dimensions of data, headerRow and observationVariableDbIds
  if (ncol(usedArgs[["data"]]) != sum(length(usedArgs[["headerRow"]]) + length(usedArgs[["observationVariableDbIds"]]))) {
    stop('The number of columns in the data argument and the arguments headerRow and observationVariableDbIds mismatch!')
  }
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/studies/{studyDbId}/table",
                                reqArgs = "studyDbId",
                                packageName = "BrAPI",
                                callVersion = 1.3)
  ## Build the Body
  callbody <- brapi_POST_callBody(usedArgs = usedArgs,
                                  reqArgs = "studyDbId")
  try({
    ## Make the call and receive the response
    resp <- brapi_POST(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_post_studies_studyDbId_table")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
