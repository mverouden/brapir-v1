### Internal function to pass a diagnostic message
brapi_message <- function(msg = "Using local test server.") {
  if (is.null(msg)) {return("")}
  if (!getOption("brapi_info", default = FALSE)) {return("")}
  return(base::message(msg))
}
