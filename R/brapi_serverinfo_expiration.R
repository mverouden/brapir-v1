#' @title
#' brapi_serverinfo_expiration
#'
#' @description
#' Display the expiration date and time of token if available.
#'
#' @param con list; required: **TRUE**; BrAPI connection object of class `brapi_con`.
#'
#' @examples
#' library(brapir)
#'
#' if (interactive()) {
#'   con <- brapi_db()$testserver
#'   brapi_serverinfo_expiration(con)
#' }
#'
#' @export
brapi_serverinfo_expiration <- function(con) {
  if ("expires_in" %in% names(con)) {
    tokenExpires <- as.POSIXct(con$expires_in/1000, origin = "1970-01-01")
    brapi_message(msg = paste0("Database connection expires: ",
                               tokenExpires))
  } else {
    brapi_message(msg = paste0("Database connection expiration time unknown."))
  }
}
