#' @title
#' get /markerprofiles/\{markerProfileDbId\}
#'
#' @description
#' Get the details for a specific Marker Profile
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param markerProfileDbId character; required: TRUE; The server's internal id for the marker profile
#' @param expandHomozygotes logical; required: FALSE; Should homozygotes NOT be collapsed into a single orrucance?; default: NA, other possible values: TRUE | FALSE
#' @param unknownString character; required: FALSE; The string to use as a representation for missing data or the reserved word &quot;empty_string&quot;.
#' @param sepPhased character; required: FALSE; The string to use as a separator for phased allele calls or the reserved word &quot;empty_string&quot;.
#' @param sepUnphased character; required: FALSE; The string to use as a separator for unphased allele calls or the reserved word &quot;empty_string&quot;.
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details
#' For the requested marker profile ID, returns the allele call for each marker.
#'
#' Allele encodings:
#' - Unknown data will by default be encoded by \&quot;N\&quot;
#' - Homozygotes are returned as a single occurance, e.g. AA -&gt; A, GG -&gt; G
#' - Phased heterozygotes are by default separated by a pipe (\&quot;|\&quot;) and unphased heterozygotes are by default separated by a forward slash (\&quot;/\&quot;)
#' - Dominant markers such as DArTs: 1 for present, 0 for absent
#' - If the user would like to use an empty string (\&quot;\&quot;) for any of the parameters, the value should be set to the reserved word \&quot;empty_string\&quot;, e.g. sepUnphased = "empty_string".
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Marker%20Profiles/get_markerprofiles__markerProfileDbId_ }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Marker Profiles
#'
#' @export
brapi_get_markerprofiles_markerProfileDbId <- function(con = NULL, markerProfileDbId = '', expandHomozygotes = NA, unknownString = '', sepPhased = '', sepUnphased = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "markerProfileDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/markerprofiles/{markerProfileDbId}",
                               reqArgs = "markerProfileDbId",
                               packageName = "BrAPI",
                               callVersion = 1.3)

  try({
    ## Make the call and receive the response
    resp <- brapi_GET(url = callurl, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_get_markerprofiles_markerProfileDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
