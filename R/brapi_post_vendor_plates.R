#' @title
#' post /vendor/plates
#'
#' @description
#' Submit a new set of Sample data
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param clientId character; required: TRUE; A unique, alpha-numeric ID which identifies the client to the vendor. Used to connect the order to the contract, billing, and contact info.; default: &quot;&quot;.
#' @param numberOfSamples integer; required: TRUE; The total number of samples contained in this request. Used for billing and basic validation of the request.; default: 0.
#' @param plates data.frame; required: TRUE, with default: &quot;&quot;; data.frame object of new plates to be submitted to a vendor. Each row in the data.frame describes one submitted plate. The `plates` argument data.frame requires to contain the following columns per submited plate:
#'
#'   * `clientPlateBarcode` vector of type character; Optional value of the barcode attached to each submitted plate.
#'   * `clientPlateId` vector of type character; The Id which uniquely identifies each plate to the client making the request.
#'   * `sampleSubmissionFormat` vector of type character; Identifier for the plate formats of submitted plates, usually "PLATE_96" for a 96 well plate or "TUBES" for plateless format.
#'   * `samples` list of data.frame objects; Each data.frame in this list describes the samples on a submitted plate. Therefore, each row in one data.frame is describing one sample on a specific submitted plate. The data.frame containing the sample information per plate requires to contain the following columns:
#'      + `clientSampleBarCode` vector of type character; Optional value of the barcode attached to each sample on a plate.
#'      + `clientSampleId` vector of type character; The ID which uniquely identifies each sample on a plate to the client making the request.
#'      + `column` vector of type character; The Column identifier for each samples location in a plate.
#'      + `comments` vector of type character; Generic comments about each sample on a plate for the vendor.
#'      + `organismName` vector of type character; Scientific organism name for each sample on a plate.
#'      + `row` vector The Row identifier for each samples location in a plate.
#'      + `speciesName` vector of type character; Scientific species name for each sample on a plate.
#'      + `tissueType` vector of type character; The type of tissue in each sample on a plate. List of accepted tissue types can be found in the Vendor Specifiations.
#'      + `well` vector of type character; The Well identifier for each samples location in the plate. Usually a concatenation of `row` and `column` as specified above.
#'      + `concentration` data.frame; data.frame with the same number of rows as the number of samples on a plate and requires the following specified columns:
#'         - `units` vector of type character; concentration units per sample on a plate
#'         - `concentration` vector of type numeric; concentration values per sample on a plate
#'      + `taxonomyOntologyReference` data.frame; Taxonomy Ontology Reference details for each sample individually on a plate. The data.frame requires the following specified columns:
#'         - `ontologyID` vector of type character; Taxonomy Ontology Identifier per individual sample on a plate.
#'         - `ontologyPrefix` vector of type character; Taxonomy Ontology Prefix per sample on a plate.
#'         - `ontologyTerm` vector of type character; Taxonomy Ontology Term per sample on a plate.
#'      + `tissueTypeOntologyRefence` data.frame; Tissue Type Ontology Reference details for each sample individually on a plate. The data.frame requires the following columns to be  specified:
#'         - `ontologyID` vector of type character; Tissue Type Ontology Identifier per sample on a plate.
#'         - `ontologyPrefix` vector of type character; Tissue Type Ontology Prefix per sample on a plate.
#'         - `ontologyTerm` vector of type character; Tissue Type Ontology Term per sample on a plate.
#'      + `volume` data.frame; data.frame with the same number of rows as the number of samples on a plate and requires the following specified columns:
#'         - `units` vector of type character; volume units per sample on a plate.
#'         - `value` vector of type numeric; volume values per sample on a plate.
#'
#' The Examples Section shows an example of how to construct the `plates` argument as a data.frame object.
#' @param sampleType character; required: TRUE; The type of Samples being submitted; default: &quot;&quot;, possible values  "DNA" | "RNA" | "Tissue"
#'
#' @details Submit a new set of Sample data
#'
#' @return data.frame containing the `submissionId`
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Vendor/post_vendor_plates }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Vendor
#'
#' @examples
#' \dontrun{
#'
#' # Create a connection object
#' con <- brapi_db()$testserver
#'
#' # Create an example data.frame plates object containing two plates
#' # * one 96 well plate ("PLATE_96")
#' # * one plateless format ("TUBES")
#' plates = data.frame(
#' clientPlateBarcode = c("plateBarcode01", "plateBarcode02"),
#' clientPlateId = c("plateId01", "plateId02"),
#' sampleSubmissionFormat = c("PLATE_96", "TUBES"))
#'
#' # Specify samples of PlateId01
#' samplesPlateId01 <- data.frame(
#'   clientSampleBarCode = c("sampleBarcode0101", "sampleBarcode0102"),
#'   clientSampleId = c("sampleId0101", "sampleId0102"),
#'   column = c("01", "12"),
#'   comments = c("commentS0101", "commentS0102"),
#'   organismName = c("oName0101", "oName0102"),
#'   row = c("A", "H"),
#'   speciesName = c("sName0101", "sName0102"),
#'   tissueType = c("tType0101", "tType0102"),
#'   well = c("A01", "H12"))
#' samplesPlateId01[["concentration"]] <- data.frame(
#'   units = c("cUnit0101", "cUnit0101"),
#'   concentration = c(0.0, 0.0))
#' samplesPlateId01[["taxonomyOntologyReference"]] <- data.frame(
#'   ontologyID = c("taxOnId0101", "taxOnRefId0102"),
#'   ontologyPrefix = c("taxOnPrefix0101", "taxOnPrefix0102"),
#'   ontologyTerm = c("taxOnTerm0101", "taxOnTerm0102"))
#' samplesPlateId01[["tissueTypeOntologyRefence"]] <- data.frame(
#'   ontologyID = c("tTypeOnId0101", "tTypeOnId0102"),
#'   ontologyPrefix = c("tTypeOnPrefix0101", "tTypeOnPrefix0102"),
#'   ontologyTerm = c("tTypeOnTerm0101", "tTypeOnTerm0102"))
#' samplesPlateId01[["volume"]] <- data.frame(
#'   units = c("vUnit0101", "vUnit0101"),
#'   value = c(0.00, 0.00))
#'
#' # Specify samples of PlateId02
#' samplesPlateId02 <- data.frame(
#'   clientSampleBarCode = c("sampleBarcode0201", "sampleBarcode0202"),
#'   clientSampleId = c("sampleId0201", "sampleId0202"),
#'   column = c("01", "02"),
#'   comments = c("commentS0201", "commentS0202"),
#'   organismName = c("oName0201", "oName0202"),
#'   row = c("TUBE", "TUBE"),
#'   speciesName = c("sName0201", "sName0202"),
#'   tissueType = c("tType0201", "tType0202"),
#'   well = c("TUBE01", "TUBE02"))
#' samplesPlateId02[["concentration"]] <- data.frame(
#'   units = c("cUnit0201", "cUnit0201"),
#'   concentration = c(0, 0))
#' samplesPlateId02[["taxonomyOntologyReference"]] <- data.frame(
#'   ontologyID = c("taxOnId0201", "taxOnRefId0202"),
#'   ontologyPrefix = c("taxOnPrefix0201", "taxOnPrefix0202"),
#'   ontologyTerm = c("taxOnTerm0201", "taxOnTerm0202"))
#' samplesPlateId02[["tissueTypeOntologyRefence"]] <- data.frame(
#'   ontologyID = c("tTypeOnId0201", "tTypeOnId0202"),
#'   ontologyPrefix = c("tTypeOnPrefix0201", "tTypeOnPrefix0202"),
#'   ontologyTerm = c("tTypeOnTerm0201", "tTypeOnTerm0202"))
#' samplesPlateId02[["volume"]] <- data.frame(
#'   units = c("vUnit0201", "vUnit0201"),
#'   value = c(0, 0))
#'
#' # Add samples infomation to the plates object
#' plates[["samples"]] <- list(samplesPlateId01, samplesPlateId02)
#'
#' # Make post /vendor/plates call
#' brapi_post_vendor_plates(con = con,
#'                          clientId = "BrAPIR",
#'                          numberOfSamples = 4,
#'                          plates = plates,
#'                          sampleType = "DNA")
#' }
#'
#' @export
brapi_post_vendor_plates <- function(con = NULL, clientId = '', numberOfSamples = 0, plates = '', sampleType = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check if usedArgs[["plates"]] is supplied as empty character vector
  if (inherits(usedArgs[["plates"]], what = "character") && usedArgs[["plates"]] == "") {
    stop('Required argument: "plates" should be supplied as a data.frame, see the help page on how the data.frame should be constructed.')
  }
  plates <- usedArgs[["plates"]]
  if (!inherits(x = plates, what = "data.frame")) {
    stop('Required argument: "plates" should be supplied as a data.frame, see the help page on how the data.frame should be constructed.')
  }
  usedArgs[["plates"]] <- NULL
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Put plates back into usedArgs
  usedArgs[["plates"]] <- plates
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/vendor/plates",
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
  class(out) <- c(class(out), "brapi_post_vendor_plates")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
