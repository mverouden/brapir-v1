#' @title
#' put /images/\{imageDbId\}
#'
#' @description
#' Update an image meta data
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param imageDbId character; required: TRUE; The unique identifier for a image
#' @param additionalInfo list; required: FALSE;
#' @param copyright character; required: FALSE; The copyright information of this image. Example 'Copyright 2018 Bob Robertson'; default: &quot;&quot;.
#' @param description character; required: FALSE; The human readable description of an image.; default: &quot;&quot;.
#' @param descriptiveOntologyTerms vector of type character; required: FALSE; A list of terms to formally describe the image. Each item could be a simple Tag, an Ontology reference Id, or a full ontology URL.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param imageFileName character; required: FALSE; The name of the image file. Might be the same as 'imageName', but could be different.; default: &quot;&quot;.
#' @param imageFileSize integer; required: FALSE; The size of the image in Bytes.
#' @param imageHeight integer; required: FALSE; The height of the image in Pixels.
#' @param imageLocation list; required: FALSE; One geometry as defined by GeoJSON (RFC 7946). All coordinates are decimal values on the WGS84 geographic coordinate reference system.
#' @param imageName character; required: FALSE; The human readable name of an image. Might be the same as 'imageFileName', but could be different.; default: &quot;&quot;.
#' @param imageTimeStamp character; required: FALSE; The date and time the image was taken and specified in the ISO 8601 standard, e.g. "2020-05-29T11:12:14.007Z"; default: &quot;&quot;.
#' @param imageWidth integer; required: FALSE; The width of the image in Pixels.
#' @param mimeType character; required: FALSE; The file type of the image. Examples 'image/jpeg', 'image/png', 'image/svg', etc; default: &quot;&quot;.
#' @param observationDbIds vector of type character; required: FALSE; A list of observation Ids this image is associated with, if applicable.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param observationUnitDbId character; required: FALSE; The related observation unit identifier, if relevant.; default: &quot;&quot;.
#'
#' @details Update an image meta data object. This call should be paired with 'PUT /images/{imageDbId}/imagecontent' for full capability.
#'
#'  + The `/images` calls support a GeoJSON object structure for describing their location. The BrAPI spec for GeoJSON only supports two of the possible geometries: Points and Polygons. With most images, the Point geometry should be used, and it should indicate the longitude and latitude of the camera. For top down images (i.e. from drones, cranes, etc), the Point geometry may be used to indicate the longitude and latitude of the centroid of the image content, and the Polygon geometry may be used to indicate the border of the image content.
#'  + `imageLocation` argument should be provided as a list. The easiest way in R to construct such a list is to use the **geojsonR** package. Below in the examples section examples are provided to create an `imageLocation` list object for a point and a polygon.
#'  + `descriptiveOntologyTerm` can be thought of as Tags for the image. These could be simple descriptive words, or ontology references, or full ontology URI's.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Images/put_images__imageDbId_ }{BrAPI SwaggerHub}
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
#' # Point example for Wageningen University & Research
#' init <- TO_GeoJson$new()
#' imageLocation <- list()
#' pointData <- c(5.663038, 51.986648) # provide as c(longitude, latitude. altitude)
#' imageLocation[["geometry"]] <- init$Point(data = pointData, stringify = FALSE)
#' imageLocation[["type"]] <- "Feature"
#'
#' # Polygon example with an exterior and interior ring
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
#' imageLocation2[["type"]] <- "Feature"
#'
#' # Make put /images/{imageDbId} call
#' # For the Point location example
#' output <- brapi_put_images_imageDbId(con = con,
#'                                      imageDbId = "img2",
#'                                      additionalInfo = list(
#'                                        additionalProp1 = "addProp1string",
#'                                        additionalProp2 = "addProp2string",
#'                                        additionalProp3 = "addProp3string"),
#'                                      copyright = "Copyright 2020",
#'                                      description = "BrAPI Logo 2020",
#'                                      descriptiveOntologyTerms = c(
#'                                        "brapi",
#'                                        "logo",
#'                                        "svg"),
#'                                      imageFileName = "brapi-logo.svg",
#'                                      imageFileSize = 3676,
#'                                      imageHeight = 56,
#'                                      imageLocation = imageLocation,
#'                                      imageName = "modified_brapiLogo",
#'                                      imageTimeStamp = "2020-05-29T11:30:12Z",
#'                                      imageWidth = 56,
#'                                      mimeType = "image/svg",
#'                                      observationDbIds = c("1", "2"),
#'                                      observationUnitDbId = "1")
#' # For the Polygon location example use `imageLocation = imageLocation2`
#' }
#'
#' @export
brapi_put_images_imageDbId <- function(con = NULL, imageDbId = '', additionalInfo = list(), copyright = '', description = '', descriptiveOntologyTerms = '', imageFileName = '', imageFileSize = as.integer(NA), imageHeight = as.integer(NA), imageLocation = list(), imageName = '', imageTimeStamp = '', imageWidth = as.integer(NA), mimeType = '', observationDbIds = '', observationUnitDbId = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "imageDbId")
  ## Obtain the call url
  callurl <- brapi_PUT_callURL(usedArgs = usedArgs,
                               callPath = "/images/{imageDbId}",
                               reqArgs = "imageDbId",
                               packageName = "BrAPI",
                               callVersion = 1.3)
  ## Build the Body
  callbody <- brapi_PUT_callBody(usedArgs = usedArgs,
                                 reqArgs = "imageDbId")
  try({
    ## Make the call and receive the response
    resp <- brapi_PUT(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_put_images_imageDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
