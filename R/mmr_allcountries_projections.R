#' Calculate MMR projections for all countries
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' MMR
#' @param bau_start_year A year to start BAU ARR calculation from
#' @param bau_end_year A year to end BAU ARR calculation on
#'
#' @return The MMR projections for all countries for the specified year length
#' @export
#'
#' @examples
mmr_allcountries_projections <- function(mmr_pivotwider_tibble, bau_start_year, bau_end_year){
  bau_tibble  <- NULL
  for(i in 1:nrow(calc_bau_arr(mmr_pivotwider_tibble, bau_start_year, bau_end_year))){
    col <- mmr_country_projections(mmr_pivotwider_tibble, iso_code = calc_bau_arr(mmr_pivotwider_tibble, bau_start_year, bau_end_year)$iso[i])
    bau_tibble <- rbind(bau_tibble, col)
    colnames(bau_tibble) <- c("2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030")
    # can you fix this need for hardcoding?
  }
  
  namecountry2 <- select(calc_bau_arr(mmr_pivotwider_tibble, bau_start_year, bau_end_year), "iso" , "name", "arr")
  mmrprojcountry2 <- cbind(namecountry2, bau_tibble)
  
  return(mmrprojcountry2)
  
}

#Recoded version
# is function below still used? if so... needs to be updated, ie no harcoing of years inside, and no indep def of years and start/end
macp <- function(mmr_pivotwider_tibble) {
  start_year = 2016
  end_year = 2030
  nyears <- end_year - start_year +1
  years <- seq(2016, 2030)
  
  bau_tibble  <- NULL
  for(i in 1:nrow(cba(mmr_est_unrounded_pwider))){
    col <- mcp(mmr_est_unrounded_pwider, iso_code = cba(mmr_est_unrounded_pwider)$iso[i])
    bau_tibble <- rbind(bau_tibble, col)
    colnames(bau_tibble) <- years
  }
  
  namecountry2 <- select(mmr_pivotwider_tibble, "iso" , "name")
  mmrprojcountry2 <- cbind(namecountry2, bau_tibble)
  
  return(mmrprojcountry2)
}
