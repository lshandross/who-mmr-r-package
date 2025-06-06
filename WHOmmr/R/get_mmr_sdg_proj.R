#' Calculate the target year's MMR projections, Adjusted for No Country's MMR Above 140, based on a chosen ARR
#'
#' @param mmr2015_country A vector with MMR for 2015 for all countries
#' @param arr A number (the ARR, intended to be the calculated SDG ARR)
#' @param nproject Number of years to project, number of years since the base year, 2015
#'
#' @return The MMR projections based on a chosen ARR, adjusted so no country has an MMR over 140
#' @export
#'
#' @examples
get_mmr_sdg_proj <- function(mmr2015_country, arr, nproject) {
  sdg_beforefix140 <- mmr2015_country[[1]] * exp(-arr * (nproject))
  sdg_afterfix140 <- ifelse(sdg_beforefix140 >140, 140, sdg_beforefix140)
  data.frame(sdg_afterfix140)
}
