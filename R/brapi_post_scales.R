#' @title
#' post /scales
#'
#' @description
#' Add a new Scale
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param dataType character; required: FALSE; Class of the scale, entries can be:
#'
#'    + &quot;Code&quot; - This scale class is exceptionally used to express complex traits. Code is a nominal scale that combines the expressions of the different traits composing the complex trait. For exemple a severity trait might be expressed by a 2 digit and 2 character code. The first 2 digits are the percentage of the plant covered by a fungus and the 2 characters refer to the delay in development, e.g. &quot;75VD&quot; means &quot;75%&quot; of the plant is  Crop Ontology &amp; Integrated Breeding Platform | Curation Guidelines | 5/6/2016 9 infected and the plant is very delayed.
#'    + &quot;Date&quot; - The date class is for events expressed in a time format, e.g. yyyymmddThh:mm:ssZ or dd/mm/yy
#'    + &quot;Duration&quot; - The Duration class is for time elapsed between two events expressed in a time format, e.g. days, hours, months
#'    + &quot;Nominal&quot; - Categorical scale that can take one of a limited and fixed number of categories. There is no intrinsic ordering to the categories
#'    + &quot;Numerical&quot; - Numerical scales express the trait with real numbers. The numerical scale defines the unit e.g. centimeter, ton per hectar, branches
#'    + &quot;Ordinal&quot; - Ordinal scales are scales composed of ordered categories
#'    + &quot;Text&quot; - A free text is used to express the trait.
#'
#'    ; default: &quot;&quot;.
#' @param decimalPlaces integer; required: FALSE; For numerical, number of decimal places to be reported; default: 0.
#' @param ontologyReference list; required: FALSE; The ontologyReference list should contain links to various ontology documentation (URL and type) supplied as a dataframe, an unique ontology database identifier, an ontology name and an ontology version (no specific format). In Examples section an example on how to specify this list is provided; default: list()
#' @param scaleName character; required: FALSE; Name of the scale; default: &quot;&quot;.
#' @param validValues list; required: FALSE; The validValues list should contain a character vector of values when specificing a nominal or ordinal scale, in this case max and min will be specified as 0. When specifying a numerical or date scale the categories need to specified as "", max specifies the maximum value and min specifies the minimum value used for data capture control. In the Examples section an example on how to specify this list is provided; default: list()
#' @param xref character; required: FALSE; Cross reference to the scale, for example to a unit ontology such as UO or to a unit of an external major database; default: &quot;&quot;.
#'
#' @details Create a new scale object in the database
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Observation%20Variables/post_scales }{BrAPI SwaggerHub}
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
#'   documentationLinks = data.frame(URL = "https://Ontology.org/s5",
#'                                   type = "RDF"),
#'   ontologyDbId = "MO_123",
#'   ontologyName = "Ontology.org",
#'   version = "17")
#'
#' # Create an validValues example list object
#' # If categories is used max and min have to be 0, vice versa when specifying
#' # max and min for a numerical or date scale the categories should specified
#' # as "".
#' validValues <- list(
#'   categories = c("xs", "s", "m", "l", "xl", "xxl"),
#'   max = 0,
#'   min = 0)
#'
#' # Make post /scales call
#' brapi_post_scales(con = con,
#'                   dataType = "Ordinal",
#'                   decimalPlaces = 0,
#'                   ontologyReference = ontologyReference,
#'                   scaleName = 'clothing sizes',
#'                   validValues = validValues,
#'                   xref = "xref")
#' }
#'
#' @export
brapi_post_scales <- function(con = NULL, dataType = '', decimalPlaces = 0, ontologyReference = list(), scaleName = '', validValues = list(), xref = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Fix for dataType argument
  ## Check for dataType argument
  dataType <- brapi_matchArg(arg = usedArgs[["dataType"]],
                             choices = c("",
                                         "Code",
                                         "Date",
                                         "Duration",
                                         "Nominal",
                                         "Numerical",
                                         "Ordinal",
                                         "Text"))
  ## Temporarily delete dataType argument
  usedArgs[["dataType"]] <- NULL
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Repair dataType argument
  usedArgs[["dataType"]] <- dataType
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/scales",
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
  class(out) <- c(class(out), "brapi_post_scales")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
