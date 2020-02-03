#' @title
#' is.brapi_con
#'
#' @description
#' Check whether an object is of class brapi_con
#'
#' @param obj object to be tested
#'
#' @return boolean (TRUE of FALSE)
#'
#' @author brapir generator package
#'
#' @family brapiutils
#'
#' @export
is.brapi_con <- function(obj) {
  res <- inherits(x = obj, what = "brapi_con")
  return(res)
}
