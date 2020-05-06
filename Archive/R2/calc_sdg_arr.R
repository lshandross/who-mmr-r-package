#' Calculate the SDG Target ARR For All Countries
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param mmr2015_country A vector with MMR for 2015 for all countries
#' @param births_tibble A tibble with the births by country for 2030
#' @param nproject The number of years to project, number of years since the base year, 2015
#'
#' @return A vector of the calculated SDG target ARRs for all countries and their corresponding ISO codes
#' @export
#'
#' @examples
calc_sdg_arr <- function(mmr_pivotwider_tibble, mmr2015_country, births_tibble, nproject){
  arr_sdg <- get_arr_sdg_target(mmr2015_country, births_tibble, nproject)
  mmr_yr_n_country <- get_mmr_sdg_proj(mmr2015_country, arr_sdg$minimum, nproject)
  sdg_arr_vector <- -1/nproject*log(mmr_yr_n_country/mmr2015_country)
  sdg_arr_tibble <- cbind(select(mmr_pivotwider_tibble, `iso`), sdg_arr_vector)
  sdg_arr_tibble <- rename(sdg_arr_tibble, sdg_arr = "sdg_afterfix140")
  sdg_arr_tibble
}
