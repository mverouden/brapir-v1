#' @title
#' put /studies/\{studyDbId\}/observationunits
#'
#' @description
#' Update the Observation Units or upload new Observation Units for a specific Study
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param studyDbId character; required: TRUE; The internal study database identifier of which these observation units are updated or addded.
#' @param observationUnits data.frame; required: TRUE; Data.frame of observation units. Each row in the `observationUnits` data.frame corresponds to a single observation unit. The following columns are required in the `observationUnits` argument data.frame:
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
#'      + `LONGITUDE` ISO 6709 standard, WGS84 geodetic datum. See [Location Coordinate Encoding](https://github.com/plantbreeding/API/blob/master/Specification/GeneralInfo/Location_Encoding.md) for details
#'      + `LATITUDE` ISO 6709 standard, WGS84 geodetic datum. See [Location Coordinate Encoding](https://github.com/plantbreeding/API/blob/master/Specification/GeneralInfo/Location_Encoding.md) for details
#'      + `PLANTED_ROW` The physical planted row number
#'      + `PLANTED_INDIVIDUAL` The physical counted number, could be independEnt or within a planted row
#'      + `GRID_ROW` The row index number of a square grid overlay
#'      + `GRID_COL` The column index number of a square grid overlay
#'      + `MEASURED_ROW` The distance in meters from a defined 0th row
#'      + `MEASURED_COL` The distance in meters from a defined 0th column
#'   * `positionCoordinateY` vector of type character; to specify the Y position coordinate for each observation unit. Different systems may use different coordinate systems.
#'   * `positionCoordinateYType` vector of type character; to specify the type of positional Y coordinate used for each observation unit. Must be one of the following values:
#'      + `LONGITUDE` ISO 6709 standard, WGS84 geodetic datum. See [Location Coordinate Encoding](https://github.com/plantbreeding/API/blob/master/Specification/GeneralInfo/Location_Encoding.md) for details
#'      + `LATITUDE` ISO 6709 standard, WGS84 geodetic datum. See [Location Coordinate Encoding](https://github.com/plantbreeding/API/blob/master/Specification/GeneralInfo/Location_Encoding.md) for details
#'      + `PLANTED_ROW` The physical planted row number
#'      + `PLANTED_INDIVIDUAL` The physical counted number, could be independEnt or within a planted row
#'      + `GRID_ROW` The row index number of a square grid overlay
#'      + `GRID_COL` The column index number of a square grid overlay
#'      + `MEASURED_ROW` The distance in meters from a defined 0th row
#'      + `MEASURED_COL` The distance in meters from a defined 0th column
#'   * `replicate` vector of type character; To specify the replicate number of each observation unit. May be the same as blockNumber.
#'   * `studyDbId` vector of type character; The internal study database identifier each observation unit is related to. Must be the same as provided as the `studyDbId` argument in the function.
#'
#' The Examples Section shows an example of how to construct the `observationUnits` argument as a data.frame object.
#' @param observationUnitXrefList list; required: FALSE; List of data frames, where each element of the list contains the cross references (as a data.frame) to a single observation unit, i.e. a single row in the `obeservationUnits` argument data.frame. Each observationUnitXref data.frame requires the following columns:
#'
#'   * `id` vector of type character; The unique identifier in the external reference 'source' system for each cross reference.
#'   * `source` vector of type character; The system identifier (name, URL, etc) which has an external reference to the observation unit
#'
#' The Examples Section shows an example of how to construct the `observationUnitXrefList` argument as a list of data.frame objects.
#'@param treatmentList list; required: FALSE; List of data frames, where each element of the list contains the treatments (as a data.frame) applied to a single observation unit, i.e. a single row in the `observationUnits` argument data.frame. Each treatment data.frame requires the following columns:
#'
#'   * `factor` vector of type character; The type of treatment/factor. e.g. 'fertilizer', 'inoculation', 'irrigation', _etc_
#'   * `modality` vector of type character; The treatment/factor descritpion. e.g. 'low fertilizer', 'yellow rust inoculation', 'high water', _etc_
#'
#' The Examples Section shows an example of how to construct the `treatmentList` argument as a list of data.frame objects.
#' @param observationsList list; required: FALSE; List of data frames, where each element of the list contains the observations (as a data.frame) of a single observation unit, i.e. a single row in the `observationUnits` argument data.frame. Each observations data.frame requires the following columns:
#'
#'   * `germplasmDbId` vector of type character; The internal database identifier, which uniquely identifies a germplasm which the observations have been done on. Must have the same value as the `germplasmDbId` in the row of the `observationUnits` data.frame, which the observations belong to.
#'   * `germplasmName` vector of type character; Name of the germplasm. It can be the preferred name and does not have to be unique.
#'   * `observationDbId` vector of type character; The internal database identifier which uniquely identifies an observation.
#'   * `observationLevel` vector of type character; The level of an observation unit, e.g. "plot" or "plant".
#'   * `observationTimeStamp` vector of type character; The date and time when this observation was made specified in the ISO 8601 format.
#'   * `observationUnitDbId` vector of type character; The internal database identifier which uniquely identifies an observation unit. Must have the same value as the `observationUnitDbId` in the row of the `observationUnits` data.frame, which the observations belong to.
#'   * `observationUnitName` vector of type character; A human readable name for an observation unit as defined earlier in the `observationUnits` data.frame the observations belong to.
#'   * `observationVariableDbId` vector of type character; The internal database identifier which uniquely identifies an observation variable.
#'   * `observationVariableName` vector of type character; A human readable name for an observation variable.
#'   * `operator` vector of type character; The name or identifier of the entity which collected the observation.
#'   * `studyDbId` vector of type character; The internal study database identifier each observation unit is related to. Must be the same as provided as the `studyDbId` argument in the function.
#'   * `uploadedBy` vector of type character; The name or identifier of the user who uploaded the observation to the database system.
#'   * `value` vector of type character; The value of the data collected as an observation.
#'
#' The Examples Section shows an example of how to construct the `observationsList` argument as a list of data.frame objects.
#' @param seasonList list; required: FALSE; List of data frames, where each element of the list specifies seasonal information in which observations have been made. Therefore, the number of rows in an element of the list must match the number of rows in the linked element of the `observationsList`. Each season data.frame requires the following columns:
#'
#'   * `season` vector of type character; Name of the season. ex. 'Spring', 'Q2', 'Season A', _etc._
#'   * `seasonDbId` vector of type character; The internal database identifier which uniquely identifies a season.
#'   * `year` vector of type character; The 4 digit year of the season.
#'
#' The Examples Section shows an example of how to construct the `seasonList` argument as a list of data.frame objects.
#'
#' @details Use this call for updating the Observation Units or uploading new Observation Units for a specific Study. The following rules are used:
#'
#'   * If `observationUnitDbId` or `observationDbId` is populated, they should be considered updates to existing records.
#'   * If an existing record of a `observationUnitDbId` or `observationDbId` is not found, the entered data should be treated as new records and assign new internal database identifiers.
#'   * If `observationUnitDbId` or `observationDbId` is un-populated (empty string or null) the entered data should be treated as new records and assign new internal database identifiers.
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
#'
#' # Create an observationUnits data.frame object
#' # with 4 observation units
#' observationUnits <- data.frame(
#'   blockNumber = c("1", "1", "1", "1"),
#'   entryNumber = c("5", "6", "7", "8"),
#'   entryType = c("TEST", "TEST", "TEST", "CHECK"),
#'   germplasmDbId = c("1", "1", "3", "3"),
#'   observationLevel = c("plot", "plant",  "plot", "plant"),
#'   observationUnitDbId = c("5", "6", "7", "8"),
#'   observationUnitName = c("Plot 3", "Plant 3", "Plot 4", "Plant 4"),
#'   plantNumber = c("0", "3", "0", "4"),
#'   plotNumber = c("3", "3", "4", "4"),
#'   positionCoordinateX = c("1", "1", "1", "1"),
#'   positionCoordinateXType = c("GRID_COL", "GRID_COL", "GRID_COL", "GRID_COL"),
#'   positionCoordinateY = c("1", "1", "2", "2"),
#'   positionCoordinateYType = c("GRID_ROW", "GRID_ROW", "GRID_ROW", "GRID_ROW"),
#'   replicate = c("0", "0", "0", "0"),
#'   studyDbId = c("1002", "1002", "1002", "1002")
#' )
#'
#' # Create an observationUnitXref list
#' # with 4 element, because of 4 observation units
#' observationUnitXref1 <- data.frame(
#'   id = c(),
#'   source = c()
#' )
#' observationUnitXref2 <- data.frame(
#'   id = c("unit6id1", "unit6id2"),
#'   source = c("unit6src1", "unit6src2")
#' )
#' observationUnitXref3 <- data.frame(
#'   id = c(),
#'   source = c()
#' )
#' observationUnitXref4 <- data.frame(
#'   id = c("unit8id1"),
#'   source = c("unit8src1")
#' )
#' observationUnitXrefList <- list(
#'   observationUnitXref1, observationUnitXref2,
#'   observationUnitXref3, observationUnitXref4)
#' rm(observationUnitXref1, observationUnitXref2,
#'    observationUnitXref3, observationUnitXref4)
#'
#' # Create a treatment list
#' # with 4 element, because of 4 observation units
#' treatment1 <- data.frame(
#'   factor = c("water regimen"),
#'   modality = c("deficit"))
#' treatment2 <- data.frame(
#'   factor = c("water regimen"),
#'   modality = c("deficit"))
#' treatment3 <- data.frame(
#'   factor = c("water regimen", "Phosphate level"),
#'   modality = c("deficit", "high"))
#' treatment4 <- data.frame(
#'   factor = c("water regimen", "Phosphate level"),
#'   modality = c("deficit", "high"))
#' treatmentList <- list(
#'   treatment1, treatment2,
#'   treatment3, treatment4)
#' rm(treatment1, treatment2,
#'    treatment3, treatment4)
#'
#' # Create an observations list
#' # with 4 element, because of 4 observation units
#' observations1 <- data.frame(
#'   # two observation on the first observation unit!
#'   germplasmDbId = c("1", "1"),
#'   germplasmName = c("Name001", "Name001"),
#'   # one existing observation with specified DbId
#'   # one new observation, where a new DbId will be assigned
#'   observationDbId = c("9", ""),
#'   observationLevel = c("plot", "plot"),
#'   observationTimeStamp = c("2013-06-14T22:11:51Z", "2020-06-18T15:22:15Z"),
#'   observationUnitDbId = c("5", "5"),
#'   observationUnitName = c("Plot 3", "Plot 3"),
#'   observationVariableDbId = c("MO_123:100002", "MO_123:100003"),
#'   observationVariableName = c("Plant height", "Carotenoid"),
#'   operator = c("Bob", "Bob"),
#'   studyDbId = c("1002", "1002"),
#'   uploadedBy = c("Bob", "Bob"),
#'   value = c("2.1", "1.86"))
#' observations2 <- data.frame(
#'   germplasmDbId = c("1"),
#'   germplasmName = c("Name001"),
#'   observationDbId = c("10"),
#'   observationLevel = c("plant"),
#'   observationTimeStamp = c("2013-06-14T22:12:51Z"),
#'   observationUnitDbId = c("6"),
#'   observationUnitName = c("Plant 3"),
#'   observationVariableDbId = c("MO_123:100006"),
#'   observationVariableName = c("Virus severity"),
#'   operator = c("Bob"),
#'   studyDbId = c("1002"),
#'   uploadedBy = c("Bob"),
#'   value = c("4.5"))
#' observations3 <- data.frame(
#'   germplasmDbId = c("3"),
#'   germplasmName = c("Name003"),
#'   observationDbId = c("11"),
#'   observationLevel = c("plot"),
#'   observationTimeStamp = c("2013-06-14T22:13:51Z"),
#'   observationUnitDbId = c("7"),
#'   observationUnitName = c("Plot 4"),
#'   observationVariableDbId = c("MO_123:100003"),
#'   observationVariableName = c("Carotenoid"),
#'   operator = c("Bob"),
#'   studyDbId = c("1002"),
#'   uploadedBy = c("Bob"),
#'   value = c("1.4"))
#' observations4 <- data.frame(
#'   germplasmDbId = c("3"),
#'   germplasmName = c("Name003"),
#'   observationDbId = c("12"),
#'   observationLevel = c("plant"),
#'   observationTimeStamp = c("2013-06-14T22:14:51Z"),
#'   observationUnitDbId = c("8"),
#'   observationUnitName = c("Plant 4"),
#'   observationVariableDbId = c("MO_123:100005"),
#'   observationVariableName = c("Root color"),
#'   operator = c("Bob"),
#'   studyDbId = c("1002"),
#'   uploadedBy = c("Bob"),
#'   value = c("red"))
#' observationsList <- list(
#'   observations1, observations2,
#'   observations3, observations4)
#' rm(observations1, observations2,
#'    observations3, observations4)
#'
#' # Create a season list
#' # with 4 element, because of 4 observation units
#' season1 <- data.frame(
#'  # two rows because observations1 has two observations!
#'  season = c("spring", "summer"),
#'  seasonDbId = c("3", "4"),
#'  year = c("2012", "2012"))
#' season2 <- data.frame(
#'   season = c("spring"),
#'   seasonDbId = c("3"),
#'   year = c("2012"))
#' season3 <- data.frame(
#'   season = c("spring"),
#'   seasonDbId = c("3"),
#'   year = c("2012"))
#' season4 <- data.frame(
#'   season = c("spring"),
#'   seasonDbId = c("3"),
#'   year = c("2012"))
#' seasonList <- list(
#'   season1, season2,
#'   season3, season4)
#' rm(season1, season2,
#'    season3, season4)
#'
#' # Make put /studies/{studyDbId}/observationunits call
#' brapi_put_studies_studyDbId_observationunits(
#'   con = con,
#'   studyDbId = "1002",
#'   observationUnits = observationUnits,
#'   observationUnitXrefList = observationUnitXrefList,
#'   treatmentList = treatmentList,
#'   observationsList = observationsList,
#'   seasonList = seasonList)
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
