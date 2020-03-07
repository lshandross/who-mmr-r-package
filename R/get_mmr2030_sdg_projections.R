#' Title
#'
#' @param mmr2015_country A vector with MMR for 2015 for all countries
#' @param arr
#' @param years_to_project 
#'
#' @return
#' @export
#'
#' @examples
get_mmr2030_sdg_projections <- function(mmr2015_country, arr, years_to_project) {
  sdg_beforefix140 <- mmr2015_country[[1]] * exp(-global_arr * (years_to_project))
  sdg_afterfix140 <- ifelse(sdg_beforefix140 >140, 140, sdg_beforefix140)
  return(sdg_afterfix140)
}