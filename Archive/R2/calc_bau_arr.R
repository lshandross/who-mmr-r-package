#' Calculate Observed ARR During a Specified Time Period
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param start_year_colnum The column number of the year to start the calculation with
#' @param end_year_colnum The column number of the to end the calculation with
#'
#' @return A tibble with a column for the calculated BAU for all countries attached to each country's corresponding ISO code
#' @export
#'
#' @examples
calc_bau_arr <- function(mmr_pivotwider_tibble, start_year_colnum, end_year_colnum) {
  length_years <- end_year_colnum - start_year_colnum + 1
  arr = (-1/(length_years))*log(mmr_pivotwider_tibble[[end_year_colnum]]/mmr_pivotwider_tibble[[start_year_colnum]])
  return(cbind(select(mmr_pivotwider_tibble, `iso`), arr))
}
