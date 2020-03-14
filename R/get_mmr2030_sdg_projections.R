#' Calculate MMR projections for all countries based on a chosen ARR 
#'
#' @param mmr2015_country A vector with MMR for 2015 for all countries
#' @param arr A number (the ARR, intended to be the calculated SDG ARR)
#' @param years_to_project Number of years to project
#'
#' @return The MMR projections based on a chosen ARR 
#' @export
#'
#' @examples
get_mmr2030_sdg_projections <- function(mmr2015_country, arr) {
  years_to_project = 15
  sdg_beforefix140 <- mmr2015_country[[1]] * exp(-global_arr * (years_to_project))
  sdg_afterfix140 <- ifelse(sdg_beforefix140 >140, 140, sdg_beforefix140)
  return(sdg_afterfix140)
}