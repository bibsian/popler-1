% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metadata_url.R
\name{metadata_url}
\alias{metadata_url}
\title{Get metadata information from a data object}
\usage{
metadata_url(data_object)
}
\arguments{
\item{data_object}{An object produced by the function get_data()}
}
\description{
Load the webpage containing the metadata of the data sets downloaded through get_data(). If you downloaded data from multiple projects, this function opens multiple webpages. 
This is a wrapper of function browseURL in base.
}
\examples{

# Load the metadata webpages of the projects that contain data from the Poa genus.
poa_data = get_data(subset = genus == "Poa")
metadata_url( poa_data )
}

