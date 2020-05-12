#' @title
#' post /methods
#'
#' @description
#' Add a new Method
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param class character; required: FALSE; Method class (examples: &quot;Measurement&quot;, &quot;Counting&quot;, &quot;Estimation&quot;, &quot;Computation&quot;, etc.); default: &quot;&quot;.
#' @param description character; required: FALSE; Method description.; default: &quot;&quot;.
#' @param formula character; required: FALSE; For computational methods i.e., when the method consists in assessing the trait by computing measurements, write the generic formula used for the calculation; default: &quot;&quot;.
#' @param methodName character; required: FALSE; Human readable name for the method; default: &quot;&quot;.
#' @param ontologyReference list; required: FALSE; The ontologyReference list should contain links to various ontology documentation (URL and type) supplied as a dataframe, an unique ontology database identifier, an ontology name and an ontology version (no specific format). In Examples section an example on how to specify this list is provided; default: list()
#' @param reference character; required: FALSE; Bibliographical reference describing the method.; default: &quot;&quot;.
#'
#' @details Create a new method object in the database
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Observation%20Variables/post_methods }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family Observation Variables
#'
#' @examples
#' \dontrun{
#'
#' # Create a connection object
#' con <- brapi_db()$testserver
#'
#' # Create an ontologyReference example list object
#' # ontologyDbId should be specified as an existing one (see get /ontologies) or
#' # left empty (some servers might generate a new ontologyDbId).
#' ontologyReference <- list(
#'   documentationLinks = data.frame(URL = "https://www.cropontology.org/terms/CO_333:1000040/",
#'                                   type = "webpage"),
#'   ontologyDbId = "",
#'   ontologyName = "cropontology.org",
#'   version = "5.0")
#'
#' # Make post /methods call
#' brapi_post_methods(con = con,
#'                    class = "Numeric",
#'                    description = "Net Weight/Ha",
#'                    formula = "NA",
#'                    methodName = "Phenotypic analysis",
#'                    ontologyReference = ontologyReference,
#'                    reference = "WEBPAGE")
#' }
#'
#' @export
brapi_post_methods <- function(con = NULL, class = '', description = '', formula = '', methodName = '', ontologyReference = list(), reference = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/methods",
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
  class(out) <- c(class(out), "brapi_post_methods")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
