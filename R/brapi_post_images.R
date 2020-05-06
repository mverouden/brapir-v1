#' @title
#' post /images
#'
#' @description
#' Create a new image meta data object
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param additionalInfo list; required: FALSE; If provided use the following construct list(additionalProp1 = "string", additionalProp2 =  "string", additionalProp3 = "string").
#' @param copyright character; required: FALSE; The copyright information of this image. Example 'Copyright 2018 Bob Robertson'; default: &quot;&quot;.
#' @param description character; required: FALSE; The human readable description of an image.; default: &quot;&quot;.
#' @param descriptiveOntologyTerms vector of type character; required: FALSE; A list of terms to formally describe the image. Each item could be a simple Tag, an Ontology reference Id, or a full ontology URL.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param imageFileName character; required: FALSE; The name of the image file. Might be the same as 'imageName', but could be different.; default: &quot;&quot;.
#' @param imageFileSize integer; required: FALSE; The size of the image in Bytes.
#' @param imageHeight integer; required: FALSE; The height of the image in Pixels.
#' @param imageLocation list; required: FALSE; One geometry as defined by GeoJSON (RFC 7946). All coordinates are decimal values on the WGS84 geographic coordinate reference system.
#' @param imageName character; required: FALSE; The human readable name of an image. Might be the same as 'imageFileName', but could be different.; default: &quot;&quot;.
#' @param imageTimeStamp character; required: FALSE; The date and time the image was taken; default: &quot;&quot;.
#' @param imageWidth integer; required: FALSE; The width of the image in Pixels.
#' @param mimeType character; required: FALSE; The file type of the image. Examples 'image/jpeg', 'image/png', 'image/svg', etc; default: &quot;&quot;.
#' @param observationDbIds vector of type character; required: FALSE; A list of observation Ids this image is associated with, if applicable.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param observationUnitDbId character; required: FALSE; The related observation unit identifier, if relevent.; default: &quot;&quot;.
#'
#' @details Create a new image meta data object.
#'
#' The `/images` calls support a GeoJSON object structure for describing their location. The BrAPI spec for GeoJSON only supports two of the possible geometries: Points and Polygons. With most images, the Point geometry should be used, and it should indicate the longitude and latitude of the camera. For top down images (i.e. from drones, cranes, etc), the Point geometry may be used to indicate the longitude and latitude of the centroid of the image content, and the Polygon geometry may be used to indicate the border of the image content.
#'
#' - `imageLocation` argument should be provided as a list. The easiest way in R to construct such a list is to use the **geojsonR** package. Below in the example section examples are provided to create an `imageLocation` object for a point and a polygon.
#'
#' - `descriptiveOntologyTerm` can be thought of as Tags for the image. These could be simple descriptive words, or ontology references, or full ontology URI's.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Images/post_images }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Images
#'
#' @examples
#' \dontrun{
#'
#' # Create a connection object
#' con <- brapi_db()$testserver
#'
#' library(geojsonR)
#' # Create an imageLocation example list object
#' #' # Point example for Ancient Human Head at Cypress County, Canada
#' init <- TO_GeoJson$new()
#' imageLocation <- list()
#' pointData <- c(-110.11301, 50.010082) # provide as c(longitude, latitude. altitude)
#' imageLocation[["geometry"]] <- init$Point(data = pointData, stringify = FALSE)
#' imageLocation$type <- "Feature"
#'
#' # Polygon example with exterior and an interior ring
#' # The first list in polygonData creates the exterior ring, whereas
#' # following lists create interior rings.
#' init <- TO_GeoJson$new()
#' # Polygon data points are provided as c(longitude, latitude)
#' polygonData <- list(list(c(-76.476949, 42.447274), # exterior ring (rectangle)
#'                          c(-76.474429, 42.447258),
#'                          c(-76.474428, 42.446193),
#'                          c(-76.476961, 42.446211),
#'                          c(-76.476949, 42.447274)),
#'                     list(c(-76.476733, 42.446916), # interior ring (triangle)
#'                          c(-76.475810, 42.447154),
#'                          c(-76.476306, 42.446281),
#'                          c(-76.476733, 42.446916)))
#' imageLocation2 <- list()
#' imageLocation2[["geometry"]] <- init$Polygon(data = polygonData, stringify = FALSE)
#' imageLocation2$type <- "Feature"
#'
#' # Make post /images call
#' # For the Point location example
#' output <- brapi_post_images(con = con, imageLocation = imageLocation)
#'
#' # For the Polygon location example
#' output <- brapi_post_images(con = con, imageLocation = imageLocation2)
#' }
#'
#' @export
brapi_post_images <- function(con = NULL, additionalInfo = list(), copyright = '', description = '', descriptiveOntologyTerms = '', imageFileName = '', imageFileSize = as.integer(NA), imageHeight = as.integer(NA), imageLocation = list(), imageName = '', imageTimeStamp = '', imageWidth = as.integer(NA), mimeType = '', observationDbIds = '', observationUnitDbId = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/images",
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
  class(out) <- c(class(out), "brapi_post_images")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
