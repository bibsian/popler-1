% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary_popler.R
\name{summary_popler}
\alias{summary_popler}
\title{Count the number of observations in one or more of the popler database variables}
\usage{
summary_popler(group_vars = NULL, count_vars = "title", trim = TRUE)
}
\arguments{
\item{group_vars}{Variables used to group observation counts.}

\item{count_vars}{Names of variables whose observations will be counted. If no group variables defined, the function counts unique fields contained in the specified variable(s)}

\item{trim}{If TRUE, strings are truncated at the 25th character.}
}
\value{
An object of class "tbl_df", "tbl", and "data.frame".
}
\description{
summary_popler() counts the number of observations (e.g. number of species) contained in one or more of the popler database variables.
"Counts" refer to the number of unique occurrences in each field.  
Observations can be counted one by one, or by grouping them based on other variables (e.g. number of species, grouped by study)
}
\examples{
# Tallies without grouping factor
summary_popler(count_vars = "title", trim = TRUE)
         
# Number of species by study
summary_popler(group_vars = "title", 
               count_vars = "species", trim = TRUE)
         
# Number of studies by LTER site
summary_popler(group_vars = "lterid", 
               count_vars = "title", trim = TRUE)
}

