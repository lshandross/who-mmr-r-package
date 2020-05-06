#' Calculate the ARR SDG Target (to later obtain country-specific arrs)
#'
#' @param mmr2015_country A vector with MMR for 2015 for all countries
#' @param births_vector A tibble with the births by country for desired year, must have same number of rows as mmr2015_country with the column of births titled `Births`
#' @param nproject The number of years to project, number of years since the base year, 2015
#'
#' @return Optimizes the SDG ARR to help with the calculation of SDG ARRs for each country
#' @export
#'
#' @examples
get_arr_sdg_target <- function(mmr2015_country, births_vector, nproject) {
  optimize(squared_diff, interval = c(-1,1), mmr2015_country, births_vector, nproject)
}
