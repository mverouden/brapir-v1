#' @title
#' put /images/\{imageDbId\}/imagecontent
#'
#' @description
#' Update an image with the image file content
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param imageDbId character; required: TRUE; The unique identifier for a image
#' @param imageFileName character; required: TRUE; The name of the image file to be used to update the image file content. The path of the `imageFileName` should be defined relative to the current working directory.; default: &quot;&quot;.
#'
#' @details Update an image with the image file content This call should be paired with `PUT /images/{imageDbId}` for full capability.
#'
#' A server may choose to modify the image meta data object based on the actually image which has been uploaded. Image data may be stored in a database or file system. Servers should generate and provide the &quot;imageURL&quot; for retrieving the image, wherever it happens to live.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Images/put_images__imageDbId__imagecontent }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Images
#'
#' @export
brapi_put_images_imageDbId_imagecontent <- function(con = NULL, imageDbId = '', imageFileName = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "imageDbId, imageFileName")
  ## Obtain the call url
  callurl <- brapi_PUT_callURL(usedArgs = usedArgs,
                               callPath = "/images/{imageDbId}/imagecontent",
                               reqArgs = "imageDbId",
                               packageName = "BrAPI",
                               callVersion = 1.3)
  try({
    ## Make the call and receive the response
    brapi_message(msg = paste0("URL call was: ", callurl, "\n"))
    brapi_message(msg = paste0("Waiting for response from server: ...\n"))
    resp <- httr::PUT(url = callurl,
                      body = httr::upload_file(usedArgs[["imageFileName"]]),
                      httr::timeout(25),
                      httr::add_headers("Authorization" = paste("Bearer", usedArgs[["con"]][["token"]])))
    txt <- ifelse(resp[["status_code"]] == 200, " ok!", " problem!")
    brapi_message(msg = paste0("Server status: ", txt, "\n"))
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_put_images_imageDbId_imagecontent")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
