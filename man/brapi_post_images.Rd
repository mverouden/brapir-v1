% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/brapi_post_images.R
\name{brapi_post_images}
\alias{brapi_post_images}
\title{post /images}
\usage{
brapi_post_images(
  con = NULL,
  additionalInfo = list(),
  copyright = "",
  description = "",
  descriptiveOntologyTerms = "",
  imageFileName = "",
  imageFileSize = as.integer(NA),
  imageHeight = as.integer(NA),
  imageLocation = list(),
  imageName = "",
  imageTimeStamp = "",
  imageWidth = as.integer(NA),
  mimeType = "",
  observationDbIds = "",
  observationUnitDbId = ""
)
}
\arguments{
\item{con}{list; required: TRUE; BrAPI connection object}

\item{additionalInfo}{list; required: FALSE; If provided use the following construct list(additionalProp1 = "string", additionalProp2 =  "string", additionalProp3 = "string").}

\item{copyright}{character; required: FALSE; The copyright information of this image. Example 'Copyright 2018 Bob Robertson'; default: "".}

\item{description}{character; required: FALSE; The human readable description of an image.; default: "".}

\item{descriptiveOntologyTerms}{vector of type character; required: FALSE; A list of terms to formally describe the image. Each item could be a simple Tag, an Ontology reference Id, or a full ontology URL.; default: "", when using multiple values supply as c("value1", "value2").}

\item{imageFileName}{character; required: FALSE; The name of the image file. Might be the same as 'imageName', but could be different.; default: "".}

\item{imageFileSize}{integer; required: FALSE; The size of the image in Bytes.}

\item{imageHeight}{integer; required: FALSE; The height of the image in Pixels.}

\item{imageLocation}{list; required: FALSE; One geometry as defined by GeoJSON (RFC 7946). All coordinates are decimal values on the WGS84 geographic coordinate reference system.}

\item{imageName}{character; required: FALSE; The human readable name of an image. Might be the same as 'imageFileName', but could be different.; default: "".}

\item{imageTimeStamp}{character; required: FALSE; The date and time the image was taken; default: "".}

\item{imageWidth}{integer; required: FALSE; The width of the image in Pixels.}

\item{mimeType}{character; required: FALSE; The file type of the image. Examples 'image/jpeg', 'image/png', 'image/svg', etc; default: "".}

\item{observationDbIds}{vector of type character; required: FALSE; A list of observation Ids this image is associated with, if applicable.; default: "", when using multiple values supply as c("value1", "value2").}

\item{observationUnitDbId}{character; required: FALSE; The related observation unit identifier, if relevent.; default: "".}
}
\value{
data.frame
}
\description{
Create a new image meta data object
}
\details{
Create a new image meta data object.

The \verb{/images} calls support a GeoJSON object structure for describing their location. The BrAPI spec for GeoJSON only supports two of the possible geometries: Points and Polygons. With most images, the Point geometry should be used, and it should indicate the longitude and latitude of the camera. For top down images (i.e. from drones, cranes, etc), the Point geometry may be used to indicate the longitude and latitude of the centroid of the image content, and the Polygon geometry may be used to indicate the border of the image content.
\itemize{
\item \code{imageLocation} argument should be provided as a list. The easiest way in R to construct such a list is to use the \strong{geojsonR} package. Below in the examples section examples are provided to create an \code{imageLocation} object for a point and a polygon.
\item \code{descriptiveOntologyTerm} can be thought of as Tags for the image. These could be simple descriptive words, or ontology references, or full ontology URI's.
}
}
\examples{
\dontrun{

# Create a connection object
con <- brapi_db()$testserver

library(geojsonR)
# Create an imageLocation example list object
# Point example for Ancient Human Head at Cypress County, Canada
init <- TO_GeoJson$new()
imageLocation <- list()
pointData <- c(-110.11301, 50.010082) # provide as c(longitude, latitude. altitude)
imageLocation[["geometry"]] <- init$Point(data = pointData, stringify = FALSE)
imageLocation[["type"]] <- "Feature"

# Polygon example with exterior and an interior ring
# The first list in polygonData creates the exterior ring, whereas
# following lists create interior rings.
init <- TO_GeoJson$new()
# Polygon data points are provided as c(longitude, latitude)
polygonData <- list(list(c(-76.476949, 42.447274), # exterior ring (rectangle)
                         c(-76.474429, 42.447258),
                         c(-76.474428, 42.446193),
                         c(-76.476961, 42.446211),
                         c(-76.476949, 42.447274)),
                    list(c(-76.476733, 42.446916), # interior ring (triangle)
                         c(-76.475810, 42.447154),
                         c(-76.476306, 42.446281),
                         c(-76.476733, 42.446916)))
imageLocation2 <- list()
imageLocation2[["geometry"]] <- init$Polygon(data = polygonData, stringify = FALSE)
imageLocation2$type <- "Feature"

# Make post /images call
# For the Point location example
output <- brapi_post_images(con = con, imageLocation = imageLocation)

# For the Polygon location example
output <- brapi_post_images(con = con, imageLocation = imageLocation2)
}

}
\references{
\href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Images/post_images }{BrAPI SwaggerHub}
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
\code{\link{brapi_put_studies_studyDbId_observationunits}()},
\code{\link{brapi_put_traits_traitDbId}()}

Other Images: 
\code{\link{brapi_get_images_imageDbId}()},
\code{\link{brapi_get_images}()},
\code{\link{brapi_get_search_images_searchResultsDbId}()},
\code{\link{brapi_post_search_images}()},
\code{\link{brapi_put_images_imageDbId_imagecontent}()},
\code{\link{brapi_put_images_imageDbId}()}
}
\author{
brapir generator package
}
\concept{Images}
\concept{brapi_1.3}
