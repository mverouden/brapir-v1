#' @title
#' post /search/images
#'
#' @description
#' Submit a search request for Images
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param descriptiveOntologyTerms vector of type character; required: FALSE; A list of terms to formally describe the image to search for. Each item could be a simple Tag, an Ontology reference Id, or a full ontology URL.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param imageFileNames vector of type character; required: FALSE; Image file names to search for.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param imageFileSizeMax integer; required: FALSE; A maximum image file size to search for.
#' @param imageFileSizeMin integer; required: FALSE; A minimum image file size to search for.
#' @param imageHeightMax integer; required: FALSE; A maximum image height to search for.
#' @param imageHeightMin integer; required: FALSE; A minimum image height to search for.
#' @param imageLocation list; required: FALSE; One geometry as defined by GeoJSON (RFC 7946). All coordinates are decimal values on the WGS84 geographic coordinate reference system.
#' @param imageNames vector of type character; required: FALSE; Human readable names to search for.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param imageTimeStampRangeEnd character; required: FALSE; The latest timestamp to search for.; default: &quot;&quot;.
#' @param imageTimeStampRangeStart character; required: FALSE; The earliest timestamp to search for.; default: &quot;&quot;.
#' @param imageWidthMax integer; required: FALSE; A maximum image width to search for.
#' @param imageWidthMin integer; required: FALSE; A minimum image width to search for.
#' @param mimeTypes vector of type character; required: FALSE; A set of image file types to search for.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param observationDbIds vector of type character; required: FALSE; A list of observation Ids this image is associated with to search for; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param observationUnitDbIds vector of type character; required: FALSE; A set of observation unit identifiers to search for.; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#'
#' @details Get filtered set of image meta data
#'
#' - `imageLocation` argument should be provided as a list. The easiest way in R to construct such a list is to use the **geojsonR** package. Below in the example section examples are provided to create an `imageLocation` object for a point and a polygon.
#'
#' - `descriptiveOntologyTerm` can be thought of as Tags for the image. These could be simple descriptive words, or ontology references, or full ontology URI's.
#'
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Images/post_search_images }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Images
#' @family Search Services
#'
#' @examples
#' \dontrun{
#'
#' # Create a connection object
#' con <- brapi_db()$testserver
#'
#' library(geojsonR)
#' # Create on imageLocation example objects
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
#' # Make post /search/images call
#' # For the Point location example
#' searchResultsDbId <- brapi_post_search_images(con = con, imageLocation = imageLocation)
#' searchResultsDbId <- as.character(searchResultsDbId)
#'
#' # For the Polygon location example
#' searchResultsDbId <- brapi_post_search_images(con = con, imageLocation = imageLocation2)
#' searchResultsDbId <- as.character(searchResultsDbId)
#' }
#'
#' @export
brapi_post_search_images <- function(con = NULL, descriptiveOntologyTerms = '', imageFileNames = '', imageFileSizeMax = as.integer(NA), imageFileSizeMin = as.integer(NA), imageHeightMax = as.integer(NA), imageHeightMin = as.integer(NA), imageLocation = list(), imageNames = '', imageTimeStampRangeEnd = '', imageTimeStampRangeStart = '', imageWidthMax = as.integer(NA), imageWidthMin = as.integer(NA), mimeTypes = '', observationDbIds = '', observationUnitDbIds = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/search/images",
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
  class(out) <- c(class(out), "brapi_post_search_images")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
