#' @title
#' put /samples
#'
#' @description
#' Add a new Sample
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param germplasmDbId character; required: FALSE;  The internal database identifier which uniquely identifies a germplasm; default: &quot;&quot;.
#' @param notes character; required: FALSE; Additional notes about a sample; default: &quot;&quot;.
#' @param observationUnitDbId character; required: FALSE; The internal database identifier, which uniquely identifies an observation unit; default: &quot;&quot;.
#' @param plantDbId character; required: FALSE; The internal database identifier, which uniquely identifies a plant. Usually 'plantNumber'; default: &quot;&quot;.
#' @param plateDbId character; required: FALSE; The internal database identifier, which uniquely identifies a plate of samples; default: &quot;&quot;.
#' @param plateIndex integer; required: FALSE; The index number of this sample on a plate; default: 0
#' @param plotDbId character; required: FALSE;  The internal database indentifier, which uniquely identifies a plot. Usually 'plotNumber'; default: &quot;&quot;.
#' @param sampleDbId character; required: FALSE; The internal database identifier, which uniquely identifies a sample; default: &quot;&quot;.
#' @param sampleTimestamp character; required: FALSE; The date and time when the sample was collected from the field and specified in the ISO 8601 format; default: &quot;&quot;.
#' @param sampleType character; required: FALSE; The type of sample taken. e.g. 'DNA', 'RNA', 'Tissue', *etc.* ; default: &quot;&quot;.
#' @param studyDbId character; required: FALSE; The internal database identifier, which uniquely identifies a study within the given database server; default: &quot;&quot;.
#' @param takenBy character; required: FALSE; The name or identifier of the entity which took the sample from the field; default: &quot;&quot;.
#' @param tissueType character; required: FALSE; The type of tissue sampled, e.g. 'Leaf', 'Root', *etc.*; default: &quot;&quot;.
#'
#' @details Call to register the event of a sample being taken, where sampleDbId is assigned as a result of the operation and returned in response.
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Samples/put_samples }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Samples
#'
#' @export
brapi_put_samples <- function(con = NULL, germplasmDbId = '', notes = '', observationUnitDbId = '', plantDbId = '', plateDbId = '', plateIndex = 0, plotDbId = '', sampleDbId = '', sampleTimestamp = '', sampleType = '', studyDbId = '', takenBy = '', tissueType = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_PUT_callURL(usedArgs = usedArgs,
                               callPath = "/samples",
                               reqArgs = "",
                               packageName = "BrAPI",
                               callVersion = 1.3)
  ## Build the Body
  callbody <- brapi_PUT_callBody(usedArgs = usedArgs,
                                 reqArgs = "")
  try({
    ## Make the call and receive the response
    resp <- brapi_PUT(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_put_samples")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
