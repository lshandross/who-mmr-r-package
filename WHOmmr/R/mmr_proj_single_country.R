#' Calculate the MMR projections for a specified country
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param arr_tibble A tibble that includes the desired ARR for every country along w/ each country's ISO code
#' @param arr_col_num The column number of the column of arr_tibble that lists each country's ARR
#' @param iso_code The ISO Code of a chosen country
#' @param mmr_start_year A year to start MMR projections from
#' @param mmr_end_year A year to end MMR projections on
#'
#' @return The MMR projections for one country for the specified year range
#' @export
#'
#' @examples
mmr_proj_single_country <- function(mmr_pivotwider_tibble, arr_tibble, arr_col_num, iso_code, mmr_start_year, mmr_end_year) {
  years <- seq(mmr_start_year, mmr_end_year)
  num_years <- length(years)
  arr_tibble_iso <- arr_tibble %>% filter(iso == iso_code)
  iso_mmr_tibble <- filter(mmr_pivotwider_tibble, iso == iso_code)

  projection <- rep(NA,num_years)
  projection <- iso_mmr_tibble$`2015` * exp(-(arr_tibble_iso[[arr_col_num]]) * (years-2015))
  projection
}
