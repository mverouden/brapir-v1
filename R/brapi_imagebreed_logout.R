#' @title
#' delete /token for ImageBreed.org
#'
#' @description
#' Logout from ImageBreed.
#'
#' @param con list; required: TRUE; BrAPI connection object
#'
#' @details Using the DELETE /token call for authentication a user can logout
#'   from ImageBreed.org and release the valid access token from within R.
#'
#' @return A list object of class 'brapi_con' from which the authentication
#'   token has been removed.
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
#' # Login to ImageBreed.org with R
#' con <- brapi_imagebreed_login(user = "USERNAME_HERE",
#'                               password = "PASSWORD_HERE")
#'
#' # Logout from ImageBreed.org with R
#' con <- brapi_imagebreed_logout(con = con)
#' }
#'
#' @export
brapi_imagebreed_logout <- function(con = NULL) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                                callPath = "/token",
                                reqArgs = "",
                                packageName = "BrAPI",
                                callVersion = 1.3)
  ## Build the Body
  callbody <- list(access_token = usedArgs[["con"]][["token"]])

  try({
    ## Make the call and receive the response
    resp <- httr::DELETE(url = callurl,
                         body = callbody,
                         encode = ifelse(con$bms == TRUE, "json", "form"))
    ## Check response status
    if (resp[["status_code"]] == 401) {
      ## Status Unauthorized
      httr::stop_for_status(x = resp,
                            task = "access_token has not been removed! Possibly it has already expired.")
    } else {
      ## Status other than unauthorized
      if (resp[["status_code"]] != 200) {
        ## Status other than Unauthorized and OK
        httr::stop_for_status(x = resp)
      } else {
        ## Status OK: Extract token out of resp(onse) from POST call
        cont <- httr::content(x = resp)
        usedArgs[["con"]][["token"]] <- ""
        usedArgs[["con"]][["expires_in"]] <- ""
        brapi_message(jsonlite::toJSON(x = cont, pretty = TRUE))
        message(cont[["metadata"]][["status"]][[3]][["message"]])
      }
    }
  })
  return(usedArgs[["con"]])
}
