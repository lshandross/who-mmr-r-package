mmr_allcountries_projections <- function(mmr_pivotwider_tibble, bau_start_year, bau_end_year){
  bau_tibble  <- NULL
  for(i in 1:nrow(calc_bau_arr(mmr_pivotwider_tibble, bau_start_year, bau_end_year))){
    col <- mmr_country_projections(mmr_pivotwider_tibble, iso_code = calc_bau_arr(mmr_pivotwider_tibble, bau_start_year, bau_end_year)$iso[i])
    bau_tibble <- rbind(bau_tibble, col)
    colnames(bau_tibble) <- c("2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030")
  }
  
  namecountry2 <- select(calc_bau_arr(mmr_pivotwider_tibble, bau_start_year, bau_end_year), "iso" , "name", "arr")
  mmrprojcountry2 <- cbind(namecountry2, bau_tibble)
  
  return(mmrprojcountry2)
  
}