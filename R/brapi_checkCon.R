#' @title
#' brapi_checkCon
#'
#' @description
#' Checks if a BrAPI compliant database can be reached given the connection details.
#'
#' @param con list; required: **TRUE**; BrAPI connection object of class `brapi_con`.
#' @param verbose logical; Default is TRUE, other possible value is "FALSE.
#' @param brapi_calls character; Use to check if one or more calls are implemented by the server according to the calls url. Default is "any".
#'
#' @details
#' Raises errors when the connection to a BrAPI compliant database can not be made over internet.
#'
#' @return logical
#'
#' @author brapir generator package
#'
#' @family brapiutils
#'
#' @export
brapi_checkCon <- function(con = NULL, verbose = TRUE, brapi_calls = "any") {
  base::stopifnot(is.brapi_con(con))
  base::stopifnot(is.logical(verbose))
  base::stopifnot(is.character(brapi_calls))

  url <- con[["db"]]

  brapi_canInternet()
  brapi_canInternet(url = url)

  if (verbose) {
    brapi_message(msg = "BrAPI connection ok.")
    brapi_message(paste(con, collapse = "\n"))
  }
  return(TRUE)
}
