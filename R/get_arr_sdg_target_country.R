#' Calculate the SDG Target ARR For All Countries
#'
#' @param mmr2015_country A vector with MMR for 2015 for all countries 
#' @param arr_sdg A tibble
#' @param nproject Number of years to project (2030 - 2015)
#'
#' @return A vector of the calculated SDG target ARRs for all countries
#' @export
#'
#' @examples
get_arr_sdg_target_country <- function(
  mmr2015_country, arr_sdg, nproject){
  mmr2030_country <- get_mmr2030_sdg_projections(mmr2015_country, arr_sdg, nproject)
  # if you have this kind of function
  #  get_arr(mmr_start = mmr2015_country, mmr_end = mmr2030_country)
  -1/nproject*log(mmr2030_country/ mmr2015_country)
  
}