#' @title
#' put /people/\{personDbId\}
#'
#' @description
#' Update a Person
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param personDbId character; required: TRUE; The unique database identifier of a person; default: &quot;&quot;.
#' @param description character; required: FALSE; description of this person; default: &quot;&quot;.
#' @param emailAddress character; required: FALSE; email address for this person; default: &quot;&quot;.
#' @param firstName character; required: FALSE; Persons first name; default: &quot;&quot;.
#' @param lastName character; required: FALSE; Persons last name; default: &quot;&quot;.
#' @param mailingAddress character; required: FALSE; physical address of this person; default: &quot;&quot;.
#' @param middleName character; required: FALSE; Persons middle name; default: &quot;&quot;.
#' @param phoneNumber character; required: FALSE; phone number of this person; default: &quot;&quot;.
#' @param userID character; required: FALSE; A systems user ID associated with this person. Different from personDbId because you could have a person who is not a user of the system.; default: &quot;&quot;.
#'
#' @details Update an existing Person
#'
#' @return data.frame
#'
#' @author brapir generator package
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/People/put_people__personDbId_ }{BrAPI SwaggerHub}
#'
#' @family brapi_1.3
#' @family People
#'
#' @export
brapi_put_people_personDbId <- function(con = NULL, personDbId = '', description = '', emailAddress = '', firstName = '', lastName = '', mailingAddress = '', middleName = '', phoneNumber = '', userID = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "personDbId")
  ## Obtain the call url
  callurl <- brapi_PUT_callURL(usedArgs = usedArgs,
                               callPath = "/people/{personDbId}",
                               reqArgs = "personDbId",
                               packageName = "BrAPI",
                               callVersion = 1.3)
  ## Build the Body
  callbody <- brapi_PUT_callBody(usedArgs = usedArgs,
                                 reqArgs = "personDbId")
  try({
    ## Make the call and receive the response
    resp <- brapi_PUT(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_put_people_personDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(cont)
  return(out)
}
