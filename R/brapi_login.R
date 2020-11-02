#' @title
#' post /token
#'
#' @description
#' Login into a BrAPI compatible database.
#'
#' @param con list; required: TRUE; BrAPI connection object
#'
#' @details Although the POST /token call for authentication has been deprecated after version 1.1 of the BrAPI specification, its functionality is still retained for compatibility reasons with the [Breeding Management System (BMS Pro)](https://bmspro.io/) of [Integrated Breeding Platform](https://integratedbreeding.net/) to allow users to obtain a valid token from within R and use with additional BrAPI R functions.
#'
#' @return A list object of class 'brapi_con' with the authentication token filled.
#'
#' @author brapir generator package
#'
#' @references \href{https://github.com/plantbreeding/API/blob/V1.1/Specification/Authentication/Authentication.md}{BrAPI Specs GitHub}
#'
#' @family brapiutils
#'
#' @examples
#' \dontrun{
#'
#' # Create a connection object
#' con <- brapi_db()$testserver
#' }
#'
#' @export
brapi_login <- function(con = NULL) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Disable multicrop when TRUE to create correct callurl
  if (usedArgs[["con"]][["multicrop"]] == TRUE) {
    omc <- usedArgs[["con"]][["multicrop"]]
    ## Temporarily disable multicrop
    usedArgs[["con"]][["multicrop"]] <- FALSE
  } else {
    omc <- FALSE
  }
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/token",
                                reqArgs = "",
                                packageName = "BrAPI",
                                callVersion = 1.3)
  ## Restore multicrop
  if (omc == TRUE) {
    usedArgs[["con"]][["multicrop"]] <- omc
  }
  ## Build the Body
  callbody <- list(username = usedArgs[["con"]][["user"]],
                   password = usedArgs[["con"]][["password"]],
                   grant_type = usedArgs[["con"]][["granttype"]],
                   client_id = usedArgs[["con"]][["clientid"]])

  try({
    ## Make the call and receive the response
    resp <- httr::POST(url = callurl,
                       body = callbody,
                       encode = ifelse(con$bms == TRUE, "json", "form"))
    ## Check response status
    if (resp[["status_code"]] == 401) {
      ## Status Unauthorized
      httr::stop_for_status(x = resp,
                            task = "authenticate. Check your username and password!")
    } else {
      ## Status other than unauthorized
      if (resp[["status_code"]] != 200) {
        ## Status other than Unauthorized and OK
        httr::stop_for_status(x = resp)
      } else {
        ## Status OK: Extract token out of resp(onse) from POST call
        cont <- httr::content(x = resp)
        usedArgs[["con"]][["token"]] <- cont[["access_token"]]
        usedArgs[["con"]][["expires_in"]] <- cont[["expires_in"]]
        brapi_message(jsonlite::toJSON(x = cont, pretty = TRUE))
        message("Authenticated!")
      }
    }
  })
  return(usedArgs[["con"]])
}
