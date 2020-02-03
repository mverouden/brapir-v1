#' @title
#' brapi_connect
#'
#' @description
#' Create a BrAPI connection object, which contains all parameters to connect to
#' a BrAPI compliant database via internet.
#'
#' @param brapiDb list; Connection object for a BrAPI compliant database created by the `as.brapi_db()` or `brapi_db()` functions. Default is NULL.
#' @param secure logical; Whether or not a secure connection ("https://") should be used. Default is FALSE, other possible value is TRUE.
#' @param protocol character; Scheme identifying the protocol to be used to access the resource via internet. Default is "http://", other possible value is "https://".
#' @param db character; Host name address of the BrAPI compliant database to be used. Default is "127.0.0.1" (defines localhost).
#' @param port integer; Port number to be used to access a BrAPI compliant database via internet. Default is 80.
#' @param apipath character; Path identifying where the Breeding API has been implemented. Default is "".
#' @param multicrop logical; Whether (TRUE) or not (FALSE) the database is a multicrop system. Default is FALSE, other possible is TRUE.
#' @param commoncropname character; Common crop name to be used, especially when the database is a multicrop system. Default is "".
#' @param user character; Username to be used, when logging in is required. Default is "".
#' @param password character; Password to be used for the specified user, when logging in is required. Default is "".
#' @param token character; Token to be used for authorization, will be passed with every call in the header. Default is ""
#' @param granttype character; Grant type. Default is "password".
#' @param clientid character; Client identification string. Default is "brapir".
#' @param bms logical; Whether (TRUE) of not (FALSE) the database used is from the Breeding Management System (Integrated Breeding Platform). Default is FALSE, other possible value is TRUE.
#'
#'
#' @details
#' If the brapiDb argument is used to specify a connection object as created by the `as.brapi_db()` function or from the white list in the `brapi_db()` function, it will override the other parameters; except for user, password and token.
#'
#' @author brapir generator package
#'
#' @return An BrAPI compliant database connection object of class brapi_db.
#'
#' @family brapiutils
#'
#' @export
brapi_connect <- function(brapiDb = NULL,
                          secure = FALSE,
                          protocol = "http://",
                          db = "127.0.0.1",
                          port = 80,
                          apipath = NULL,
                          multicrop = FALSE,
                          commoncropname = "",
                          user = "",
                          password = "",
                          token = "",
                          granttype = "password",
                          clientid = "brapir",
                          bms = FALSE) {
  brapi <- NULL
  if (!is.null(brapiDb)) {
    # brapiDb agrument was not NULL but passed
    if (all(sapply(X = c("list", "brapi_db", "brapi", "brapi_con"),
                   FUN = function(i) {inherits(brapiDb, what = i)}))) {
      brapi <- brapiDb
    }
  } else {
    # check for net connectivity
    brapi_canInternet()
    brapi_checkConArgs(secure = secure,
                       protocol = protocol,
                       db = db,
                       port = port,
                       apipath = apipath,
                       multicrop = multicrop,
                       commoncropname = commoncropname,
                       user = user,
                       password = password,
                       token = token,
                       granttype = granttype,
                       clientid = clientid,
                       bms = bms)
    # bms == TRUE, then always multicrop == TRUE
    if (bms == TRUE) {
      multicrop <- TRUE
    }
    # create brapi list object from passed arguments
    brapi <- list(secure = secure,
                  protocol = protocol,
                  db = db,
                  port = port,
                  apipath = apipath,
                  multicrop = multicrop,
                  commoncropname = commoncropname,
                  user = user,
                  password = password,
                  token = token,
                  granttype = granttype,
                  clientid = clientid,
                  bms = bms)
    class(brapi) <- c(class(brapi), "brapi_db", "brapi", "brapi_con")
  }
  brapi_serverinfo_expiration(brapi)

  return(brapi)
}
