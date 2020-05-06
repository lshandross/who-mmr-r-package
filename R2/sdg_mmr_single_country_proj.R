#' Calculate the SDG MMR projections for a specified country
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param bau_sdg_arr_tibble A tibble that includes all of the BAU and SDG ARRs
#' @param iso_code The ISO Code of a chosen country
#' @param mmr_start_year A year to start BAU MMR projections from
#' @param mmr_end_year A year to end BAU MMR projections on
#'
#' @return The SDG MMR projections for one country for the specified year range
#' @export
#'
#' @examples
sdg_mmr_single_country_proj <- function(mmr_pivotwider_tibble, bau_sdg_arr_tibble, iso_code, mmr_start_year, mmr_end_year) {
  years <- seq(mmr_start_year, mmr_end_year)
  num_years <- length(years)
  arr_tibble_iso <- filter(bau_sdg_arr_tibble, iso == iso_code)
  iso_mmr_tibble <- filter(mmr_pivotwider_tibble, iso == iso_code)

  projection <- rep(NA,num_years)
  projection <- iso_mmr_tibble$`2015` * exp(-(arr_tibble_iso$`sdg arr`) * (years-2015))
  projection
}
