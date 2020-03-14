#' Calculate Observed ARR During a Specified Time Period (Add Column to Tibble) of 
#'
#' @param mmr_pivotwider_tibble A tibble that contains all countries' MMR in the pivotwider format
#' @param start_year A year to start the calculation with
#' @param end_year A year to end the calculation on
#'
#' @return The input mmr_pivotwide_tibble with an added BAU ARR column
#' @export
#'
#' @examples
calc_bau_arr <- function(mmr_pivotwider_tibble, start_year, end_year) {
  length_years = end_year - start_year
  arr = (-1/(length_years))*log(mmr_pivotwider_tibble[["2017"]]/mmr_pivotwider_tibble$`2010`)
  return(cbind(mmr_pivotwider_tibble, arr))
}


#recoded
cba <- function(mmr_pivotwider_tibble) {
  start_year = 2010
  end_year = 2017
  length_years = end_year - start_year 
  arr = (-1/(length_years))*log(mmr_pivotwider_tibble[["2017"]]/mmr_pivotwider_tibble$`2010`)
  return(cbind(select(mmr_pivotwider_tibble, `iso`), arr))
}