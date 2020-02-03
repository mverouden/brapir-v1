### Internal function to match an argument of type character with limited
### options where also an empty string "" is possible
### Revision of match.arg to be able to match empty strings ""
brapi_matchArg <- function(arg, choices, several.ok = FALSE) {
  if (missing(choices)) {
    formal.args <- formals(sys.function(sys.parent()))
    choices <- eval(formal.args[[as.character(substitute(arg))]])
  }
  if (is.null(arg)) {
    return(choices[1L])
  } else {
    if (!is.character(arg)) {stop("'arg' must be NULL or a character vector")}
  }
  if (!several.ok) {
    if (identical(arg, choices)) {return(arg[1L])}
    if (length(arg) > 1L) {stop("'arg' must be of length 1")}
  } else {
    if (length(arg) == 0L) {stop("'arg' must be of length >= 1")}
  }
  i <- charmatch(arg, choices, nomatch = 0L)
  if (all(i == 0L)) {
    stop(gettextf("'arg' should be one of %s",
                  paste(dQuote(choices), collapse = ", ")),
         domain = NA)
  }
  i <- i[i > 0L]
  if (!several.ok && length(i) > 1) {
    stop("there is more than one match in 'brapi_matchArg'")
  }
  return(choices[i])
}
