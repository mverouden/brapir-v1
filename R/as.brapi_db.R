#' @title
#' as.brapi_db
#'
#' @description
#' Create or test objects of type "brapi_db", which represents a BrAPI database
#' connection object.
#'
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
#' @return An BrAPI compliant database connection object of class brapi_db.
#'
#' @author brapir generator package
#'
#' @family brapiutils
#'
#' @export
as.brapi_db <- function(secure = FALSE,
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
  out <- list(secure = secure,
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
  class(out) <- c(class(out), "brapi_db", "brapi", "brapi_con")
  return(out)
}
