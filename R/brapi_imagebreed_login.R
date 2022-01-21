#' @title
#' post /token for ImageBreed.org
#'
#' @description
#' Login into ImageBreed.
#'
#' @param user character; Username to be used, when logging in is required. Default is "".
#' @param password character; Password to be used for the specified user, when
#'   logging in is required. Default is "".
#'
#' @details Using the POST /token call for authentication a user can login to
#'   ImageBreed.org to obtain a valid token from within R and use with additional
#'   BrAPI R functions. The password is **NOT** stored in the connection object
#'   for safety.
#'
#' @return A list object of class 'brapi_con' with the authentication token
#'   filled to make BrAPI calls in R from the ImageBreed database.
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
#' }
#'
#' @export
brapi_imagebreed_login <- function(user = "", password = "") {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Create the connection object for ImageBreed.org and fill username and
  ## password as provided by the function
  con <- brapi_db()[["imagebreed"]]
  con[["user"]] <- usedArgs[["user"]]
  con[["password"]] <- usedArgs[["password"]]
  usedArgs[["con"]] <- con
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
        ## Remove password from the connection object and put an empty string
        usedArgs[["con"]][["password"]] <- ""
        brapi_message(jsonlite::toJSON(x = cont, pretty = TRUE))
        message("Authenticated!")
      }
    }
  })
  return(usedArgs[["con"]])
}
