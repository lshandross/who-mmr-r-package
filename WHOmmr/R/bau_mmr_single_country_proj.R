#' Calculate the BAU MMR projections for a specified country for a given range
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param iso_code The ISO Code of a chosen country
#' @param arr_start_year_colnum The column number of the year to start the BAU ARR calculation with
#' @param arr_end_year_colnum The column number of the to end the BAU ARR calculation with
#' @param mmr_start_year A year to start BAU MMR projections from
#' @param mmr_end_year A year to end BAU MMR projections on
#'
#' @return The BAU MMR projections for one country for the specified year range
#' @export
#'
#' @examples
bau_mmr_single_country_proj <- function(mmr_pivotwider_tibble, iso_code, arr_start_year_colnum, arr_end_year_colnum, mmr_start_year, mmr_end_year){
  years <- seq(mmr_start_year, mmr_end_year)
  num_years <- length(years)

  bau_tibble <- left_join(mmr_pivotwider_tibble, calc_bau_arr(mmr_pivotwider_tibble, arr_start_year_colnum, arr_end_year_colnum), by = "iso") %>%
    filter(iso == iso_code)

  projection <- rep(NA,num_years)
  projection <- bau_tibble$`2015` * exp(-(bau_tibble$`arr`) * (years-2015))
  return(projection)
}
