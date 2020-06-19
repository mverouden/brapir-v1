#' @title
#' put /studies/\{studyDbId\}/observationunits
#'
#' @description
#' Update the Observation Units or upload new Observation Units for a specific Study
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param studyDbId character; required: TRUE; The internal study database identifier these observation units are related to.
#' @param observationUnits data.frame; required: TRUE; data.frame of observation units. Each row in the `observationUnits` data.frame corresponds to a single observation unit. The following columns are required in the `observationUnits` argument data.frame:
#'
#'   * `blockNumber` vector of type character; The block number for each observation unit. Different systems may use different block designs.
#'   * `entryNumber` vector of type character; The entry number for each observation unit. Different systems may use different entry systems.
#'   * `entryType` vector of type character; The type of entry for each observation unit with possible values: "CHECK" | "FILLER" | "TEST"
#'   * `germplasmDbId` vector of type character; The internal database identifier of a germplasm for each observation unit
#'   * `observationLevel` vector of type character; The level of each observation unit, e.g. "plot", "plant"
#'   * `observationUnitDbId` vector of type character; The internal database identifier for each observation unit in case of updating
#'   * `observationUnitName` vector of type character; A human readable name for each observation unit
#'   * `plantNumber` vector of type character; The plant number in a field. Applicable for observationLevel: "plant"
#'   * `plotNumber` vector of type character: The plot number in a field. Applicable for observationLevel: "plot"
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
#'   * `replicate` vector of type character; To specify the replicate number of each observation unit. May be the same as blockNumber.
#'   * `studyDbId` vector of type character; The internal study database identifier each observation unit is related to. Must be the same as provided as the `studyDbId` argument in the function.
#'
#' The Examples Section shows an example of how to construct the `observationUnits` argument as a data.frame object.
#'
#' @details Use this call for updating the Observation Units or uploading new Observation Units for a specific Study. The following rules are used:
#'
#'   * If `observationUnitDbId` or `observationDbId` is populated, they should be considered updates to existing records.
#'   * If an existing record of a `observationUnitDbId` or `observationDbId` is not found, the entered data should be treated as new records and assign new internal database identifiers.
#'   * If `observationUnitDbId` or `observationDbId` is un-populated (empty string or null) the entered data should be treated as new records and assig new internal database identifiers.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Studies/put_studies__studyDbId__observationunits }{BrAPI SwaggerHub}
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
#' }
#'
#' @export
brapi_put_studies_studyDbId_observationunits <- function(con = NULL, studyDbId = '', observationUnits = '', observationUnitXrefList = list(), treatmentList = list(), observationsList = list(), seasonList = list()) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check if usedArgs[["observationUnits"]] is supplied as empty character vector
  if (inherits(usedArgs[["observationUnits"]], what = "character") && usedArgs[["observationUnits"]] == "") {
    stop('Required argument: "observationUnits" should be supplied as a data.frame, see the help page on how the data.frame should be constructed.')
  }
  observationUnits <- usedArgs[["observationUnits"]]
  if (!inherits(x = observationUnits, what = "data.frame")) {
    stop('Required argument: "observationUnits" should be supplied as a data.frame, see the help page on how the data.frame should be constructed.')
  }
  ## Check whether call studyDbId matches in observationUnits
  if (length(unique(observationUnits[["studyDbId"]])) != 1 || unique(observationUnits[["studyDbId"]]) != usedArgs[["studyDbId"]]) {
    stop('The "studyDbId" in the "observationUnits" data.frame is not uniquely defined or is not matching the "studyDbId" argument of the function call.')
  }
  usedArgs[["observationUnits"]] <- NULL
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "studyDbId")
  ## Obtain the call url
  callurl <- brapi_PUT_callURL(usedArgs = usedArgs,
                               callPath = "/studies/{studyDbId}/observationunits",
                               reqArgs = "studyDbId",
                               packageName = "BrAPI",
                               callVersion = 1.3)
  ## Build the Body
  for (i in seq(nrow(observationUnits))) {
    if (nrow(observationUnits) == length(usedArgs[["observationUnitXrefList"]])) {
      observationUnits[["observationUnitXref"]][[i]] <- usedArgs[["observationUnitXrefList"]][[i]]
    } else if (length(usedArgs[["observationUnitXrefList"]]) != 0 &&
               nrow(observationUnits) > length(usedArgs[["observationUnitXrefList"]])) {
      stop('Argument: "observationUnitXrefList" argument should have the same number of elements as the number of rows in the "observationUnits" argument data.frame.')
    }
    if (nrow(observationUnits) == length(usedArgs[["treatmentList"]])) {
      observationUnits[["treatments"]][[i]] <- usedArgs[["treatmentList"]][[i]]
    } else if (length(usedArgs[["treatmentList"]]) != 0 &&
               nrow(observationUnits) > length(usedArgs[["treatmentList"]])) {
      stop('Argument: "treatmentList" argument should have the same number of elements as the number of rows in the "observationUnits" argument data.frame.')
    }
    if (nrow(observationUnits) == length(usedArgs[["observationsList"]])) {
      if (length(unique(usedArgs[["observationsList"]][[i]][["studyDbId"]])) > 1 ||
          ifelse(nrow(usedArgs$observationsList[[i]]) == 0,
                 FALSE,
                 unique(usedArgs[["observationsList"]][[i]][["studyDbId"]]) != usedArgs[["studyDbId"]])) {
        stop('The "studyDbId" in the "observations" data.frame is not uniquely defined or is not matching the "studyDbId" argument of the function call.')
      } else {
      observationUnits[["observations"]][[i]] <- usedArgs[["observationsList"]][[i]]
      }
    } else if (length(usedArgs[["observationsList"]]) != 0 &&
               nrow(observationUnits) > length(usedArgs[["observationsList"]])) {
      stop('Argument: "observationsList" argument should have the same number of elements as the number of rows in the "observationUnits" argument data.frame.')
    }
    if (nrow(observationUnits) == length(usedArgs[["seasonList"]])) {
      if (nrow(usedArgs[["observationsList"]][[i]]) != 0 &&
          nrow(usedArgs[["observationsList"]][[i]]) == nrow(usedArgs[["seasonList"]][[i]])) {
        observationUnits[["observations"]][[i]][["season"]] <- usedArgs[["seasonList"]][[i]]
      } else if (nrow(usedArgs[["observationsList"]][[i]]) != 0 &&
                 nrow(usedArgs[["observationsList"]][[i]]) != nrow(usedArgs[["seasonList"]][[i]])) {
        stop(paste('Element:', i, 'of the "observationsList" argument and the "seasonList" argument mismatch in the number of rows.'))
      }
    } else if (length(usedArgs[["seasonList"]]) != 0 &&
               nrow(observationUnits) > length(usedArgs[["seasonList"]])) {
      stop('Argument: "seasonList" argument should have the same number of elements as the number of rows in the "observationUnits" argument data.frame.')
    }
  }
  callbody <- observationUnits
  try({
    ## Make the call and receive the response
    resp <- brapi_PUT(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_put_studies_studyDbId_observationunits")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
