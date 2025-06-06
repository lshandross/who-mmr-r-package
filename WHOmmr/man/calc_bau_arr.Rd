% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_bau_arr.R
\name{calc_bau_arr}
\alias{calc_bau_arr}
\title{Calculate Observed ARR During a Specified Time Period}
\usage{
calc_bau_arr(mmr_pivotwider_tibble, start_year_colnum, end_year_colnum)
}
\arguments{
\item{mmr_pivotwider_tibble}{A tibble that includes all countries' observed MMR in the pivotwider format}

\item{start_year_colnum}{The column number of the year to start the calculation with}

\item{end_year_colnum}{The column number of the to end the calculation with}
}
\value{
A tibble with a column for the calculated BAU for all countries attached to each country's corresponding ISO code
}
\description{
Calculate Observed ARR During a Specified Time Period
}
