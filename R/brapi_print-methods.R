#' @title
#' print.brapi_con
#'
#' @description
#' print method for an object of class brapi_con, which will only display the
#' crop, database address:port and user.
#'
#' @param x list; a BrAPI connection object (of class `brapi_con`).
#' @param ... further arguments passed to or from other methods.
#'
#' @author brapir generator package
#'
#' @family brapiutils
#'
#' @export
print.brapi_con <- function(x, ...) {
  # Print in console
  txt <- paste0("Crop = ", x$commoncropname, "\n\n")
  txt <- paste0(txt, "Address:Port = ", x$db, ":", x$port, "\n")
  cat(paste0(txt, "User = ", x$user, "\n"))
  return(invisible())
}

#' @title
#' print.brapi_db
#'
#' @description
#' Print method for an object of class brapi_db.
#'
#' @param x list; a `brapi_db` class object.
#' @param ... further arguments passed to or from other methods.
#'
#' @author brapir generator package
#'
#' @family brapiutils
#'
#' @export
print.brapi_db <- function(x, ...) {
  names(x) %>% sort %>% paste(collapse = "\n") %>% cat
  return(invisible())
}
