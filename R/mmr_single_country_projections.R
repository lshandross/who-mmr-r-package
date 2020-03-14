#' Calculate MMR projections for a specified country
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' MMR
#' @param mmr_start_year A year to start MMR projections from
#' @param mmr_end_year A year to end MMR projections on
#' @param bau_start_year A year to start BAU ARR calculation from
#' @param bau_end_year A year to end BAU ARR calculation on
#' @param iso_code The ISO Code of a chosen country
#'
#' @return The MMR projections for the years specified for one chosen country
#' @export
#'
#' @examples
mmr_country_projections <- 
  function(mmr_pivotwider_tibble, mmr_start_year = 2016, mmr_end_year = 2030, bau_start_year = 2010, bau_end_year = 2017, iso_code){
    
    years <- seq(mmr_start_year, mmr_end_year)
    num_years <- length(years)
    bau_tibble <- calc_bau_arr(mmr_pivotwider_tibble, bau_start_year, bau_end_year) %>% 
      filter(iso == iso_code)
    projection <- rep(NA,num_years) #What does this do?
    projection <- bau_tibble$`2015` * exp(-(bau_tibble$`arr`) * (years-2015))
    return(projection)
  }

#Recoded version
mcp <- function(mmr_pivotwider_tibble, iso_code){
  mmr_start_year = 2016
  mmr_end_year = 2030
  # bau_start_year = 2010
  # bau_end_year = 2017
  years <- seq(mmr_start_year, mmr_end_year)
  num_years <- length(years)
  
  bau_tibble <- left_join(mmr_pivotwider_tibble, cba(mmr_pivotwider_tibble), by = "iso") %>% 
    filter(iso == iso_code)
  projection <- rep(NA,num_years) #What does this do?
  projection <- bau_tibble$`2015` * exp(-(bau_tibble$`arr`) * (years-2015))
  return(projection)
}