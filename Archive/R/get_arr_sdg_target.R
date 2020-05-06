#' Calculate the ARR SDG Target (to later get country-specific arrs)
#'
#' @param mmr2015_country A vector with MMR for 2015 for all countries 
#' @param births_tibble 
#' @param nproject Number of years to project (2030 - 2015)
#'
#' @return 
#' @export
#'
#' @examples
get_arr_sdg_target <- function(mmr2015_country, births_tibble, nproject) {
  optimize(squared_diff, interval = c(-1,1),
           mmr2015_country,
           births_tibble,
           nproject)
}