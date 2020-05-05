sdg_mmr_single_country_proj <- function(mmr_pivotwider_tibble, bau_sdg_arr_tibble, iso_code, mmr_start_year, mmr_end_year) {
  years <- seq(mmr_start_year, mmr_end_year)
  num_years <- length(years)
  arr_tibble_iso <- filter(bau_sdg_arr_tibble, iso == iso_code)
  
  iso_mmr_tibble <- filter(mmr_pivotwider_tibble, iso == iso_code)
  projection <- rep(NA,num_years)
  projection <- iso_mmr_tibble$`2015` * exp(-(arr_tibble_iso$`sdg arr`) * (years-2015))
  projection
}



sdg_mmr_allcountries_proj <- function(mmr_pivotwider_tibble, bau_sdg_arr_tibble, mmr_start_year, mmr_end_year) {
  sdg_mmr_tibble <- NULL
  for(i in 1: nrow(bau_sdg_arr_tibble)){
    col <- sdg_mmr_single_country_proj(mmr_pivotwider_tibble, bau_sdg_arr_tibble, iso_code = bau_sdg_arr_tibble$iso[i], mmr_start_year, mmr_end_year)
    sdg_mmr_tibble <- rbind(sdg_mmr_tibble, col)
    
  }
  colnames(sdg_mmr_tibble) <- seq(mmr_start_year, mmr_end_year)
  nc2 <- cbind(mmr_pivotwider_tibble$`name`, bau_sdg_arr_tibble)
  sdgmmrprojcountry2 <- cbind(nc2 %>% rename(name = "mmr_pivotwider_tibble$name"), sdg_mmr_tibble)
  sdgmmrprojcountry2
}   