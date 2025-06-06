#' Calculate MMR projections for all countries
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' MMR
#' @param bau_start_year A year to start BAU ARR calculation from
#' @param bau_end_year A year to end BAU ARR calculation on
#' @param mmr_start_year A year to start BAU MMR calculation from
#' @param mmr_end_year A year to end BAU MMR calculation on
#'
#' @return The MMR projections for all countries for the specified year length
#' @export
#'
#' @examples
mmr_allcountries_projections <- function(mmr_pivotwider_tibble, bau_start_year, bau_end_year, mmr_start_year, mmr_end_year){
  #years <- seq(mmr_start_year, mmr_end_year)
  bau_tibble  <- NULL
  for(i in 1:nrow(calc_bau_arr(mmr_pivotwider_tibble, bau_start_year, bau_end_year))){
    col <- mmr_country_projections(mmr_pivotwider_tibble,  mmr_start_year, mmr_end_year, bau_start_year, bau_end_year, iso_code = calc_bau_arr(mmr_pivotwider_tibble, bau_start_year, bau_end_year)$iso[i])
    bau_tibble <- rbind(bau_tibble, col)
    colnames(bau_tibble) <- seq(2016,2030)
  }
  
  namecountry2 <- select(calc_bau_arr(mmr_pivotwider_tibble, bau_start_year, bau_end_year), "iso" , "name", "arr")
  mmrprojcountry2 <- cbind(namecountry2, bau_tibble)
  
  return(mmrprojcountry2)
  
}

macp <- function(mmr_pivotwider_tibble, mmr_start_year, mmr_end_year) {
  nyears <- mmr_end_year - mmr_start_year +1
  years <- seq(mmr_start_year, mmr_end_year)
  
  bau_tibble  <- NULL
  for(i in 1:nrow(cba(mmr_est_unrounded_pwider))){
    col <- mcp(mmr_est_unrounded_pwider, iso_code = cba(mmr_est_unrounded_pwider)$iso[i], mmr_start_year, mmr_end_year)
    bau_tibble <- rbind(bau_tibble, col)
    colnames(bau_tibble) <- years
  }
  
  namecountry2 <- select(mmr_pivotwider_tibble, "iso" , "name")
  mmrprojcountry2 <- cbind(namecountry2, bau_tibble)
  
  return(mmrprojcountry2)
}