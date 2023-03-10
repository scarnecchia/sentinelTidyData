% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get.R
\name{load_data}
\alias{load_data}
\title{Load SAS data files into R}
\usage{
load_data(source, file = NULL)
}
\arguments{
\item{source}{A character string specifying the directory where the SAS data
files are located.}

\item{file}{A character string specifying the name of the SAS data file to be
loaded. If \code{NULL}, all \verb{*.sas7bdat} files in the \code{source} directory are
loaded.}
}
\value{
A list of data frames, one data frame per SAS file loaded.
}
\description{
Safely load SAS7BDAT data files into R, either the entire folder
specified by \code{source} or a specified vector of files \code{file}. The loaded
data is returned as a list of \code{\link[=data.frames]{data.frames()}}. This function uses
\code{\link[purrr:safely]{purrr::safely()}} to ensure it always succeeds. It returns a list with
components \code{result} and \code{error}. Results should be accessed with
\code{purrr::transpose(.x)[["error"]]}
}
