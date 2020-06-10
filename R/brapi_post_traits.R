#' @title
#' post /traits
#'
#' @description
#' Add a new Trait
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param alternativeAbbreviations vector of type character; required: FALSE; Other frequent abbreviations of the trait, if any. These abbreviations do not have to follow a convention; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param attribute character; required: FALSE; A trait can be decomposed as &quot;Trait&quot; = &quot;Entity&quot; + &quot;Attribute&quot;, the attribute is the observed feature (or characteristic) of the entity e.g., for &quot;grain colour&quot;, attribute = &quot;colour&quot;; default: &quot;&quot;.
#' @param class character; required: FALSE; Trait class. (examples: &quot;morphological trait&quot;, &quot;phenological trait&quot;, &quot;agronomical trait&quot;, &quot;physiological trait&quot;, &quot;abiotic stress trait&quot;, &quot;biotic stress trait&quot;, &quot;biochemical trait&quot;, &quot;quality traits trait&quot;, &quot;fertility trait&quot;, etc.); default: &quot;&quot;.
#' @param description character; required: FALSE; The description of a trait; default: &quot;&quot;.
#' @param entity character; required: FALSE; A trait can be decomposed as &quot;Trait&quot; = &quot;Entity&quot; + &quot;Attribute&quot;, the entity is the part of the plant that the trait refers to e.g., for &quot;grain colour&quot;, entity = &quot;grain&quot;; default: &quot;&quot;.
#' @param mainAbbreviation character; required: FALSE; Main abbreviation for trait name. (examples: &quot;Carotenoid content&quot; =&gt; &quot;CC&quot;); default: &quot;&quot;.
#' @param ontologyReference list; required: FALSE; The ontologyReference list should contain links to various ontology documentation (URL and type) supplied as a dataframe, an unique ontology database identifier, an ontology name and an ontology version (no specific format). In the Examples section an example on how to specify this list is provided; default: list()
#' @param status character; required: FALSE; Trait status (examples: &quot;recommended&quot;, &quot;obsolete&quot;, &quot;legacy&quot;, etc.); default: &quot;&quot;.
#' @param synonyms vector of type character; required: FALSE; Other trait names; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;).
#' @param traitName character; required: FALSE; The human readable name of a trait; default: &quot;&quot;.
#' @param xref character; required: FALSE; Cross reference of the trait to an external ontology or database term e.g., Xref to a trait ontology (TO) term; default: &quot;&quot;.
#'
#' @details Create a new trait object in the database
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Observation%20Variables/post_traits }{BrAPI SwaggerHub}
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
#'   documentationLinks = data.frame(URL = "https://Ontology.org/s6",
#'                                   type = "RDF"),
#'   ontologyDbId = "MO_123",
#'   ontologyName = "Ontology.org",
#'   version = "17")
#'
#' # Make post /traits call
#' brapi_post_traits(con = con,
#'                   alternativeAbbreviations = "",
#'                   attribute = "size",
#'                   class = "morphological trait",
#'                   description = "Size designation of clothes",
#'                   entity = "clothing",
#'                   mainAbbreviation = "CS",
#'                   ontologyReference = ontologyReference,
#'                   status = "legacy",
#'                   synonyms = "",
#'                   traitName = "clothingSize",
#'                   xref = "none")
#' }
#'
#' @export
brapi_post_traits <- function(con = NULL, alternativeAbbreviations = '', attribute = '', class = '', description = '', entity = '', mainAbbreviation = '', ontologyReference = list(), status = '', synonyms = '', traitName = '', xref = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/traits",
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
  class(out) <- c(class(out), "brapi_post_traits")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
