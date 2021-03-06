% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/brapi_put_studies_studyDbId_observationunits.R
\name{brapi_put_studies_studyDbId_observationunits}
\alias{brapi_put_studies_studyDbId_observationunits}
\title{put /studies/\{studyDbId\}/observationunits}
\usage{
brapi_put_studies_studyDbId_observationunits(
  con = NULL,
  studyDbId = "",
  observationUnits = "",
  observationUnitXrefList = list(),
  treatmentList = list(),
  observationsList = list(),
  seasonList = list()
)
}
\arguments{
\item{con}{list; required: TRUE; BrAPI connection object}

\item{studyDbId}{character; required: TRUE; The internal study database identifier of which these observation units are updated or addded.}

\item{observationUnits}{data.frame; required: TRUE; Data.frame of observation units. Each row in the \code{observationUnits} data.frame corresponds to a single observation unit. The following columns are required in the \code{observationUnits} argument data.frame:
\itemize{
\item \code{blockNumber} vector of type character; The block number for each observation unit. Different systems may use different block designs.
\item \code{entryNumber} vector of type character; The entry number for each observation unit. Different systems may use different entry systems.
\item \code{entryType} vector of type character; The type of entry for each observation unit with possible values: "CHECK" | "FILLER" | "TEST"
\item \code{germplasmDbId} vector of type character; The internal database identifier of a germplasm for each observation unit
\item \code{observationLevel} vector of type character; The level of each observation unit, e.g. "plot", "plant"
\item \code{observationUnitDbId} vector of type character; The internal database identifier for each observation unit in case of updating
\item \code{observationUnitName} vector of type character; A human readable name for each observation unit
\item \code{plantNumber} vector of type character; The plant number in a field. Applicable for observationLevel: "plant"
\item \code{plotNumber} vector of type character: The plot number in a field. Applicable for observationLevel: "plot"
\item \code{positionCoordinateX} vector of type character; to specify the X position coordinate for each observation unit. Different systems may use different coordinate systems.
\item \code{positionCoordinateXType} vector of type character; to specify the type of X positional coordinate used for each observation unit. Must be one of the following values:
\itemize{
\item \code{LONGITUDE} ISO 6709 standard, WGS84 geodetic datum. See \href{https://github.com/plantbreeding/API/blob/master/Specification/GeneralInfo/Location_Encoding.md}{Location Coordinate Encoding} for details
\item \code{LATITUDE} ISO 6709 standard, WGS84 geodetic datum. See \href{https://github.com/plantbreeding/API/blob/master/Specification/GeneralInfo/Location_Encoding.md}{Location Coordinate Encoding} for details
\item \code{PLANTED_ROW} The physical planted row number
\item \code{PLANTED_INDIVIDUAL} The physical counted number, could be independEnt or within a planted row
\item \code{GRID_ROW} The row index number of a square grid overlay
\item \code{GRID_COL} The column index number of a square grid overlay
\item \code{MEASURED_ROW} The distance in meters from a defined 0th row
\item \code{MEASURED_COL} The distance in meters from a defined 0th column
}
\item \code{positionCoordinateY} vector of type character; to specify the Y position coordinate for each observation unit. Different systems may use different coordinate systems.
\item \code{positionCoordinateYType} vector of type character; to specify the type of positional Y coordinate used for each observation unit. Must be one of the following values:
\itemize{
\item \code{LONGITUDE} ISO 6709 standard, WGS84 geodetic datum. See \href{https://github.com/plantbreeding/API/blob/master/Specification/GeneralInfo/Location_Encoding.md}{Location Coordinate Encoding} for details
\item \code{LATITUDE} ISO 6709 standard, WGS84 geodetic datum. See \href{https://github.com/plantbreeding/API/blob/master/Specification/GeneralInfo/Location_Encoding.md}{Location Coordinate Encoding} for details
\item \code{PLANTED_ROW} The physical planted row number
\item \code{PLANTED_INDIVIDUAL} The physical counted number, could be independEnt or within a planted row
\item \code{GRID_ROW} The row index number of a square grid overlay
\item \code{GRID_COL} The column index number of a square grid overlay
\item \code{MEASURED_ROW} The distance in meters from a defined 0th row
\item \code{MEASURED_COL} The distance in meters from a defined 0th column
}
\item \code{replicate} vector of type character; To specify the replicate number of each observation unit. May be the same as blockNumber.
\item \code{studyDbId} vector of type character; The internal study database identifier each observation unit is related to. Must be the same as provided as the \code{studyDbId} argument in the function.
}

The Examples Section shows an example of how to construct the \code{observationUnits} argument as a data.frame object.}

\item{observationUnitXrefList}{list; required: FALSE; List of data frames, where each element of the list contains the cross references (as a data.frame) to a single observation unit, i.e. a single row in the \code{obeservationUnits} argument data.frame. Each observationUnitXref data.frame requires the following columns:
\itemize{
\item \code{id} vector of type character; The unique identifier in the external reference 'source' system for each cross reference.
\item \code{source} vector of type character; The system identifier (name, URL, etc) which has an external reference to the observation unit
}

The Examples Section shows an example of how to construct the \code{observationUnitXrefList} argument as a list of data.frame objects.}

\item{treatmentList}{list; required: FALSE; List of data frames, where each element of the list contains the treatments (as a data.frame) applied to a single observation unit, i.e. a single row in the \code{observationUnits} argument data.frame. Each treatment data.frame requires the following columns:
\itemize{
\item \code{factor} vector of type character; The type of treatment/factor. e.g. 'fertilizer', 'inoculation', 'irrigation', \emph{etc}
\item \code{modality} vector of type character; The treatment/factor descritpion. e.g. 'low fertilizer', 'yellow rust inoculation', 'high water', \emph{etc}
}

The Examples Section shows an example of how to construct the \code{treatmentList} argument as a list of data.frame objects.}

\item{observationsList}{list; required: FALSE; List of data frames, where each element of the list contains the observations (as a data.frame) of a single observation unit, i.e. a single row in the \code{observationUnits} argument data.frame. Each observations data.frame requires the following columns:
\itemize{
\item \code{germplasmDbId} vector of type character; The internal database identifier, which uniquely identifies a germplasm which the observations have been done on. Must have the same value as the \code{germplasmDbId} in the row of the \code{observationUnits} data.frame, which the observations belong to.
\item \code{germplasmName} vector of type character; Name of the germplasm. It can be the preferred name and does not have to be unique.
\item \code{observationDbId} vector of type character; The internal database identifier which uniquely identifies an observation.
\item \code{observationLevel} vector of type character; The level of an observation unit, e.g. "plot" or "plant".
\item \code{observationTimeStamp} vector of type character; The date and time when this observation was made specified in the ISO 8601 format.
\item \code{observationUnitDbId} vector of type character; The internal database identifier which uniquely identifies an observation unit. Must have the same value as the \code{observationUnitDbId} in the row of the \code{observationUnits} data.frame, which the observations belong to.
\item \code{observationUnitName} vector of type character; A human readable name for an observation unit as defined earlier in the \code{observationUnits} data.frame the observations belong to.
\item \code{observationVariableDbId} vector of type character; The internal database identifier which uniquely identifies an observation variable.
\item \code{observationVariableName} vector of type character; A human readable name for an observation variable.
\item \code{operator} vector of type character; The name or identifier of the entity which collected the observation.
\item \code{studyDbId} vector of type character; The internal study database identifier each observation unit is related to. Must be the same as provided as the \code{studyDbId} argument in the function.
\item \code{uploadedBy} vector of type character; The name or identifier of the user who uploaded the observation to the database system.
\item \code{value} vector of type character; The value of the data collected as an observation.
}

The Examples Section shows an example of how to construct the \code{observationsList} argument as a list of data.frame objects.}

\item{seasonList}{list; required: FALSE; List of data frames, where each element of the list specifies seasonal information in which observations have been made. Therefore, the number of rows in an element of the list must match the number of rows in the linked element of the \code{observationsList}. Each season data.frame requires the following columns:
\itemize{
\item \code{season} vector of type character; Name of the season. ex. 'Spring', 'Q2', 'Season A', \emph{etc.}
\item \code{seasonDbId} vector of type character; The internal database identifier which uniquely identifies a season.
\item \code{year} vector of type character; The 4 digit year of the season.
}

The Examples Section shows an example of how to construct the \code{seasonList} argument as a list of data.frame objects.}
}
\value{
data.frame
}
\description{
Update the Observation Units or upload new Observation Units for a specific Study
}
\details{
Use this call for updating the Observation Units or uploading new Observation Units for a specific Study. The following rules are used:
\itemize{
\item If \code{observationUnitDbId} or \code{observationDbId} is populated, they should be considered updates to existing records.
\item If an existing record of a \code{observationUnitDbId} or \code{observationDbId} is not found, the entered data should be treated as new records and assign new internal database identifiers.
\item If \code{observationUnitDbId} or \code{observationDbId} is un-populated (empty string or null) the entered data should be treated as new records and assign new internal database identifiers.
}
}
\examples{
\dontrun{

# Create a connection object
con <- brapi_db()$testserver

# Create an observationUnits data.frame object
# with 4 observation units
observationUnits <- data.frame(
  blockNumber = c("1", "1", "1", "1"),
  entryNumber = c("5", "6", "7", "8"),
  entryType = c("TEST", "TEST", "TEST", "CHECK"),
  germplasmDbId = c("1", "1", "3", "3"),
  observationLevel = c("plot", "plant",  "plot", "plant"),
  observationUnitDbId = c("5", "6", "7", "8"),
  observationUnitName = c("Plot 3", "Plant 3", "Plot 4", "Plant 4"),
  plantNumber = c("0", "3", "0", "4"),
  plotNumber = c("3", "3", "4", "4"),
  positionCoordinateX = c("1", "1", "1", "1"),
  positionCoordinateXType = c("GRID_COL", "GRID_COL", "GRID_COL", "GRID_COL"),
  positionCoordinateY = c("1", "1", "2", "2"),
  positionCoordinateYType = c("GRID_ROW", "GRID_ROW", "GRID_ROW", "GRID_ROW"),
  replicate = c("0", "0", "0", "0"),
  studyDbId = c("1002", "1002", "1002", "1002")
)

# Create an observationUnitXref list
# with 4 element, because of 4 observation units
observationUnitXref1 <- data.frame(
  id = c(),
  source = c()
)
observationUnitXref2 <- data.frame(
  id = c("unit6id1", "unit6id2"),
  source = c("unit6src1", "unit6src2")
)
observationUnitXref3 <- data.frame(
  id = c(),
  source = c()
)
observationUnitXref4 <- data.frame(
  id = c("unit8id1"),
  source = c("unit8src1")
)
observationUnitXrefList <- list(
  observationUnitXref1, observationUnitXref2,
  observationUnitXref3, observationUnitXref4)
rm(observationUnitXref1, observationUnitXref2,
   observationUnitXref3, observationUnitXref4)

# Create a treatment list
# with 4 element, because of 4 observation units
treatment1 <- data.frame(
  factor = c("water regimen"),
  modality = c("deficit"))
treatment2 <- data.frame(
  factor = c("water regimen"),
  modality = c("deficit"))
treatment3 <- data.frame(
  factor = c("water regimen", "Phosphate level"),
  modality = c("deficit", "high"))
treatment4 <- data.frame(
  factor = c("water regimen", "Phosphate level"),
  modality = c("deficit", "high"))
treatmentList <- list(
  treatment1, treatment2,
  treatment3, treatment4)
rm(treatment1, treatment2,
   treatment3, treatment4)

# Create an observations list
# with 4 element, because of 4 observation units
observations1 <- data.frame(
  # two observation on the first observation unit!
  germplasmDbId = c("1", "1"),
  germplasmName = c("Name001", "Name001"),
  # one existing observation with specified DbId
  # one new observation, where a new DbId will be assigned
  observationDbId = c("9", ""),
  observationLevel = c("plot", "plot"),
  observationTimeStamp = c("2013-06-14T22:11:51Z", "2020-06-18T15:22:15Z"),
  observationUnitDbId = c("5", "5"),
  observationUnitName = c("Plot 3", "Plot 3"),
  observationVariableDbId = c("MO_123:100002", "MO_123:100003"),
  observationVariableName = c("Plant height", "Carotenoid"),
  operator = c("Bob", "Bob"),
  studyDbId = c("1002", "1002"),
  uploadedBy = c("Bob", "Bob"),
  value = c("2.1", "1.86"))
observations2 <- data.frame(
  germplasmDbId = c("1"),
  germplasmName = c("Name001"),
  observationDbId = c("10"),
  observationLevel = c("plant"),
  observationTimeStamp = c("2013-06-14T22:12:51Z"),
  observationUnitDbId = c("6"),
  observationUnitName = c("Plant 3"),
  observationVariableDbId = c("MO_123:100006"),
  observationVariableName = c("Virus severity"),
  operator = c("Bob"),
  studyDbId = c("1002"),
  uploadedBy = c("Bob"),
  value = c("4.5"))
observations3 <- data.frame(
  germplasmDbId = c("3"),
  germplasmName = c("Name003"),
  observationDbId = c("11"),
  observationLevel = c("plot"),
  observationTimeStamp = c("2013-06-14T22:13:51Z"),
  observationUnitDbId = c("7"),
  observationUnitName = c("Plot 4"),
  observationVariableDbId = c("MO_123:100003"),
  observationVariableName = c("Carotenoid"),
  operator = c("Bob"),
  studyDbId = c("1002"),
  uploadedBy = c("Bob"),
  value = c("1.4"))
observations4 <- data.frame(
  germplasmDbId = c("3"),
  germplasmName = c("Name003"),
  observationDbId = c("12"),
  observationLevel = c("plant"),
  observationTimeStamp = c("2013-06-14T22:14:51Z"),
  observationUnitDbId = c("8"),
  observationUnitName = c("Plant 4"),
  observationVariableDbId = c("MO_123:100005"),
  observationVariableName = c("Root color"),
  operator = c("Bob"),
  studyDbId = c("1002"),
  uploadedBy = c("Bob"),
  value = c("red"))
observationsList <- list(
  observations1, observations2,
  observations3, observations4)
rm(observations1, observations2,
   observations3, observations4)

# Create a season list
# with 4 element, because of 4 observation units
season1 <- data.frame(
 # two rows because observations1 has two observations!
 season = c("spring", "summer"),
 seasonDbId = c("3", "4"),
 year = c("2012", "2012"))
season2 <- data.frame(
  season = c("spring"),
  seasonDbId = c("3"),
  year = c("2012"))
season3 <- data.frame(
  season = c("spring"),
  seasonDbId = c("3"),
  year = c("2012"))
season4 <- data.frame(
  season = c("spring"),
  seasonDbId = c("3"),
  year = c("2012"))
seasonList <- list(
  season1, season2,
  season3, season4)
rm(season1, season2,
   season3, season4)

# Make put /studies/{studyDbId}/observationunits call
brapi_put_studies_studyDbId_observationunits(
  con = con,
  studyDbId = "1002",
  observationUnits = observationUnits,
  observationUnitXrefList = observationUnitXrefList,
  treatmentList = treatmentList,
  observationsList = observationsList,
  seasonList = seasonList)
}

}
\references{
\href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Studies/put_studies__studyDbId__observationunits }{BrAPI SwaggerHub}
}
\seealso{
Other brapi_1.3: 
\code{\link{brapi_get_allelematrices_search}()},
\code{\link{brapi_get_allelematrices}()},
\code{\link{brapi_get_attributes_categories}()},
\code{\link{brapi_get_attributes}()},
\code{\link{brapi_get_breedingmethods_breedingMethodDbId}()},
\code{\link{brapi_get_breedingmethods}()},
\code{\link{brapi_get_calls}()},
\code{\link{brapi_get_commoncropnames}()},
\code{\link{brapi_get_germplasm_germplasmDbId_attributes}()},
\code{\link{brapi_get_germplasm_germplasmDbId_markerprofiles}()},
\code{\link{brapi_get_germplasm_germplasmDbId_mcpd}()},
\code{\link{brapi_get_germplasm_germplasmDbId_pedigree}()},
\code{\link{brapi_get_germplasm_germplasmDbId_progeny}()},
\code{\link{brapi_get_germplasm_germplasmDbId}()},
\code{\link{brapi_get_germplasm}()},
\code{\link{brapi_get_images_imageDbId}()},
\code{\link{brapi_get_images}()},
\code{\link{brapi_get_lists_listDbId}()},
\code{\link{brapi_get_lists}()},
\code{\link{brapi_get_locations_locationDbId}()},
\code{\link{brapi_get_locations}()},
\code{\link{brapi_get_maps_mapDbId_positions_linkageGroupName}()},
\code{\link{brapi_get_maps_mapDbId_positions}()},
\code{\link{brapi_get_maps_mapDbId}()},
\code{\link{brapi_get_maps}()},
\code{\link{brapi_get_markerprofiles_markerProfileDbId}()},
\code{\link{brapi_get_markerprofiles}()},
\code{\link{brapi_get_markers_markerDbId}()},
\code{\link{brapi_get_markers}()},
\code{\link{brapi_get_methods_methodDbId}()},
\code{\link{brapi_get_methods}()},
\code{\link{brapi_get_observationlevels}()},
\code{\link{brapi_get_observationunits}()},
\code{\link{brapi_get_ontologies}()},
\code{\link{brapi_get_people_personDbId}()},
\code{\link{brapi_get_people}()},
\code{\link{brapi_get_programs}()},
\code{\link{brapi_get_samples_sampleDbId}()},
\code{\link{brapi_get_samples}()},
\code{\link{brapi_get_scales_scaleDbId}()},
\code{\link{brapi_get_scales}()},
\code{\link{brapi_get_search_germplasm_searchResultsDbId}()},
\code{\link{brapi_get_search_images_searchResultsDbId}()},
\code{\link{brapi_get_search_markers_searchResultsDbId}()},
\code{\link{brapi_get_search_observationtables_searchResultsDbId}()},
\code{\link{brapi_get_search_observationunits_searchResultsDbId}()},
\code{\link{brapi_get_search_programs_searchResultsDbId}()},
\code{\link{brapi_get_search_samples_searchResultsDbId}()},
\code{\link{brapi_get_search_studies_searchResultsDbId}()},
\code{\link{brapi_get_search_variables_searchResultsDbId}()},
\code{\link{brapi_get_seasons}()},
\code{\link{brapi_get_studies_studyDbId_germplasm}()},
\code{\link{brapi_get_studies_studyDbId_layouts}()},
\code{\link{brapi_get_studies_studyDbId_observations}()},
\code{\link{brapi_get_studies_studyDbId_observationunits}()},
\code{\link{brapi_get_studies_studyDbId_observationvariables}()},
\code{\link{brapi_get_studies_studyDbId_table}()},
\code{\link{brapi_get_studies_studyDbId}()},
\code{\link{brapi_get_studies}()},
\code{\link{brapi_get_studytypes}()},
\code{\link{brapi_get_traits_traitDbId}()},
\code{\link{brapi_get_traits}()},
\code{\link{brapi_get_trials_trialDbId}()},
\code{\link{brapi_get_trials}()},
\code{\link{brapi_get_variables_observationVariableDbId}()},
\code{\link{brapi_get_variables}()},
\code{\link{brapi_get_vendor_orders_orderId_plates}()},
\code{\link{brapi_get_vendor_orders_orderId_results}()},
\code{\link{brapi_get_vendor_orders_orderId_status}()},
\code{\link{brapi_get_vendor_orders}()},
\code{\link{brapi_get_vendor_plates_submissionId}()},
\code{\link{brapi_get_vendor_specifications}()},
\code{\link{brapi_post_allelematrices_search}()},
\code{\link{brapi_post_images}()},
\code{\link{brapi_post_lists_listDbId_items}()},
\code{\link{brapi_post_lists}()},
\code{\link{brapi_post_methods}()},
\code{\link{brapi_post_people}()},
\code{\link{brapi_post_phenotypes}()},
\code{\link{brapi_post_scales}()},
\code{\link{brapi_post_search_germplasm}()},
\code{\link{brapi_post_search_images}()},
\code{\link{brapi_post_search_markers}()},
\code{\link{brapi_post_search_observationtables}()},
\code{\link{brapi_post_search_observationunits}()},
\code{\link{brapi_post_search_programs}()},
\code{\link{brapi_post_search_samples}()},
\code{\link{brapi_post_search_studies}()},
\code{\link{brapi_post_search_variables}()},
\code{\link{brapi_post_studies_studyDbId_table}()},
\code{\link{brapi_post_traits}()},
\code{\link{brapi_post_vendor_orders}()},
\code{\link{brapi_post_vendor_plates}()},
\code{\link{brapi_put_images_imageDbId_imagecontent}()},
\code{\link{brapi_put_images_imageDbId}()},
\code{\link{brapi_put_lists_listDbId}()},
\code{\link{brapi_put_methods_methodDbId}()},
\code{\link{brapi_put_people_personDbId}()},
\code{\link{brapi_put_samples}()},
\code{\link{brapi_put_scales_scaleDbId}()},
\code{\link{brapi_put_studies_studyDbId_layouts}()},
\code{\link{brapi_put_studies_studyDbId_observations}()},
\code{\link{brapi_put_traits_traitDbId}()}

Other Studies: 
\code{\link{brapi_get_search_studies_searchResultsDbId}()},
\code{\link{brapi_get_seasons}()},
\code{\link{brapi_get_studies_studyDbId_germplasm}()},
\code{\link{brapi_get_studies_studyDbId_layouts}()},
\code{\link{brapi_get_studies_studyDbId_observations}()},
\code{\link{brapi_get_studies_studyDbId_observationunits}()},
\code{\link{brapi_get_studies_studyDbId_observationvariables}()},
\code{\link{brapi_get_studies_studyDbId_table}()},
\code{\link{brapi_get_studies_studyDbId}()},
\code{\link{brapi_get_studies}()},
\code{\link{brapi_get_studytypes}()},
\code{\link{brapi_post_search_studies}()},
\code{\link{brapi_post_studies_studyDbId_table}()},
\code{\link{brapi_put_studies_studyDbId_layouts}()},
\code{\link{brapi_put_studies_studyDbId_observations}()}

Other Observations: 
\code{\link{brapi_get_observationlevels}()},
\code{\link{brapi_get_observationunits}()},
\code{\link{brapi_get_search_observationtables_searchResultsDbId}()},
\code{\link{brapi_get_search_observationunits_searchResultsDbId}()},
\code{\link{brapi_get_studies_studyDbId_observations}()},
\code{\link{brapi_get_studies_studyDbId_observationunits}()},
\code{\link{brapi_get_studies_studyDbId_table}()},
\code{\link{brapi_post_phenotypes}()},
\code{\link{brapi_post_search_observationtables}()},
\code{\link{brapi_post_search_observationunits}()},
\code{\link{brapi_post_studies_studyDbId_table}()},
\code{\link{brapi_put_studies_studyDbId_observations}()}
}
\author{
brapir generator package
}
\concept{Observations}
\concept{Studies}
\concept{brapi_1.3}
