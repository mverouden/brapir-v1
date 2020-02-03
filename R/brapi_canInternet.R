#' @title
#' brapi_canInternet
#'
#' @description
#' Check for internet connection.
#'
#' @param url character; A url to check. Default is \href{https://www.google.org}{www.google.org}.
#'
#' @return NULL when internet access is available or ERROR when internet access is not available
#'
#' @author brapir generator package
#'
#' @references \href{http://stackoverflow.com/questions/5076593/how-to-determine-if-you-have-an-internet-connection-in-r}{Stack Overflow} and \code{\link[curl]{has_internet}}
#'
#' @family brapiutils
#'
#' @importFrom curl nslookup
#'
#' @export
brapi_canInternet <- function(url = "www.google.org") {
  stopifnot(is.character(url))
  return(invisible(curl::nslookup(host = url)))
}
