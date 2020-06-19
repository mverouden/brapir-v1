#' @title
#' put /studies/\{studyDbId\}/layouts
#'
#' @description
#' Update an existing Study with new layout details
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param studyDbId character; required: TRUE; Identifier of the study. Usually a number, could be alphanumeric.
#' @param layout data.frame; required: TRUE, with default: &quot;&quot;; data.frame of observation unit position data entities which need to be updated. Each row in the `layout` argument data .frame corresponds to a single entity and requires to contain the following columns:
#'
#'   * `blockNumber` vector of type character; to specify the blocknumber positions of each observation unit
#'   * `entryType` vector of type character; to specify the entrytype of each observation unit with possible values: "CHECK" | "FILLER" | "TEST"
#'   * `observationUnitDbId` vector of type character; to specify the internal database identifier of each observation unit.
#'   * `positionCoordinateX` vector of type character; to specify the X position coordinate for each observation unit. Different systems may use different coordinate systems.
#'   * `positionCoordinateXType` vector of type character; to specify the type of X positional coordinate used for each observation unit. Must be one of the following values:
#'      + `LONGITUDE` ISO 6709 standard, WGS84 geodetic datum. See "Location Coordinate Encoding" for details
#'      + `LATITUDE` ISO 6709 standard, WGS84 geodetic datum. See "Location Coordinate Encoding" for details
#'      + `PLANTED_ROW` The physical planted row number
#'      + `PLANTED_INDIVIDUAl` The physical counted number, could be independEnt or within a planted row
#'      + `GRID_ROW` The row index number of a square grid overlay
#'      + `GRID_COL` The column index number of a square grid overlay
#'      + `MEASURED_ROW` The distance in meters from a defined 0th row
#'      + `MEASURED_COL` The distance in meters from a defined 0th column
#'   * `positionCoordinateY` vector of type character; to specify the Y position coordinate for each observation unit. Different systems may use different coordinate systems.
#'   * `positionCoordinateYType` vector of type character; to specify the type of positional Y coordinate used for each observation unit. Must be one of the following values:
#'      + `LONGITUDE` ISO 6709 standard, WGS84 geodetic datum. See "Location Coordinate Encoding" for details
#'      + `LATITUDE` ISO 6709 standard, WGS84 geodetic datum. See "Location Coordinate Encoding" for details
#'      + `PLANTED_ROW` The physical planted row number
#'      + `PLANTED_INDIVIDUAl` The physical counted number, could be independEnt or within a planted row
#'      + `GRID_ROW` The row index number of a square grid overlay
#'      + `GRID_COL` The column index number of a square grid overlay
#'      + `MEASURED_ROW` The distance in meters from a defined 0th row
#'      + `MEASURED_COL` The distance in meters from a defined 0th column
#'   * `replicate` vector of type character; to specify the replicate number of each observation unit.
#'
#' The Examples Section shows an example of how to construct the `layout` argument as a data.frame object.
#'
#' @details Update the layout data for a set of observation units within a study. A layout data.frame is a subset of fields within an observationUnit. If any of the fields in the request data.frame (as defined in the `layout` function argument) is missing, that piece of data will not be updated. The response should match the structure of the response from `GET studies/{studyDbId}/layout` as implemented in the `brapi_get_studies_studyDbId_layout()` function, but it should only contain the layout objects which have been updated by the PUT request.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Studies/put_studies__studyDbId__layouts }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Studies
#'
#' @examples
#' \dontrun{
#'
#' # Create a connection object
#' con <- brapi_db()$testserver
#'
#' # Create a layout data.frame
#' # containing the fields to be updated
#' layout <- data.frame(
#'   blockNumber = c("12"),
#'   entryType = c("CHECK"),
#'   observationUnitDbId = c("1"),
#'   positionCoordinateX = c("12"),
#'   positionCoordinateXType = c("GRID_COL"),
#'   positionCoordinateY = c("12"),
#'   positionCoordinateYType = c("GRID_ROW"),
#'   replicate = c("1"))
#'
#' # Make put /studies/{studyDbId}/layout call
#' brapi_put_studies_studyDbId_layouts(con = con, studyDbId = '1001', layout = layout)
#' }
#'
#' @export
brapi_put_studies_studyDbId_layouts <- function(con = NULL, studyDbId = '', layout = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check if usedArgs[["layout"]] is supplied as empty character vector
  if (inherits(usedArgs[["layout"]], what = "character") && usedArgs[["layout"]] == "") {
    stop('Required argument: "layout" should be supplied as a data.frame, see the help page on how the data.frame should be constructed.')
  }
  layout <- usedArgs[["layout"]]
  if (!inherits(x = layout, what = "data.frame")) {
    stop('Required argument: "layout" should be supplied as a data.frame, see the help page on how the data.frame should be constructed.')
  }
  usedArgs[["layout"]] <- NULL
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "studyDbId")
  ## Put layout back into usedArgs
  usedArgs[["layout"]] <- layout
  ## Obtain the call url
  callurl <- brapi_PUT_callURL(usedArgs = usedArgs,
                               callPath = "/studies/{studyDbId}/layouts",
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
  class(out) <- c(class(out), "brapi_put_studies_studyDbId_layouts")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
