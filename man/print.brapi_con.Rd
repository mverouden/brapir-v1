% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/brapi_print-methods.R
\name{print.brapi_con}
\alias{print.brapi_con}
\title{print.brapi_con}
\usage{
\method{print}{brapi_con}(x, ...)
}
\arguments{
\item{x}{list; a BrAPI connection object (of class \code{brapi_con}).}

\item{...}{further arguments passed to or from other methods.}
}
\description{
print method for an object of class brapi_con, which will only display the
crop, database address:port and user.
}
\seealso{
Other brapiutils: 
\code{\link{as.brapi_db}()},
\code{\link{brapi_canInternet}()},
\code{\link{brapi_checkCon}()},
\code{\link{brapi_connect}()},
\code{\link{brapi_db}()},
\code{\link{brapi_imagebreed_login}()},
\code{\link{brapi_imagebreed_logout}()},
\code{\link{brapi_login}()},
\code{\link{brapi_serverinfo_show}()},
\code{\link{is.brapi_con}()},
\code{\link{print.brapi_db}()}
}
\author{
brapir generator package
}
\concept{brapiutils}
