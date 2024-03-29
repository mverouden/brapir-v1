% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/brapi_checkCon.R
\name{brapi_checkCon}
\alias{brapi_checkCon}
\title{brapi_checkCon}
\usage{
brapi_checkCon(con = NULL, verbose = TRUE, brapi_calls = "any")
}
\arguments{
\item{con}{list; required: \strong{TRUE}; BrAPI connection object of class \code{brapi_con}.}

\item{verbose}{logical; Default is TRUE, other possible value is "FALSE.}

\item{brapi_calls}{character; Use to check if one or more calls are implemented by the server according to the calls url. Default is "any".}
}
\value{
logical
}
\description{
Checks if a BrAPI compliant database can be reached given the connection details.
}
\details{
Raises errors when the connection to a BrAPI compliant database can not be made over internet.
}
\seealso{
Other brapiutils: 
\code{\link{as.brapi_db}()},
\code{\link{brapi_canInternet}()},
\code{\link{brapi_connect}()},
\code{\link{brapi_db}()},
\code{\link{brapi_imagebreed_login}()},
\code{\link{brapi_imagebreed_logout}()},
\code{\link{brapi_login}()},
\code{\link{brapi_serverinfo_show}()},
\code{\link{is.brapi_con}()},
\code{\link{print.brapi_con}()},
\code{\link{print.brapi_db}()}
}
\author{
brapir generator package
}
\concept{brapiutils}
