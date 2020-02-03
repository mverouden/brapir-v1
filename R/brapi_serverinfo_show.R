#' @title
#' brapi_serverinfo_show
#'
#' @description
#' Show informative messages or not
#'
#' @param show logical; default is TRUE
#'
#' @family brapiutils
#'
#' @export
brapi_serverinfo_show <- function(show = TRUE) {
  stopifnot(is.logical(show))
  options(brapi_info = show)
  return(invisible())
}
