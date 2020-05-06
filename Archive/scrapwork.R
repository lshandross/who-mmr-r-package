macp <- function(mmr_pivotwider_tibble) {
  start_year = 2016
  end_year = 2030
  nyears <- end_year - start_year +1
  year <- c()
  year[1] = start_year
  for (i in 2:nyears) {
    year[i] <- year[i - 1] + 1
  }
  
  bau_tibble  <- NULL
  for(i in 1:nrow(calc_bau_arr(mmr_est_unrounded_pwider, 2010, 2017))){
    col <- mmr_country_projections(mmr_est_unrounded_pwider, iso_code = calc_bau_arr(mmr_est_unrounded_pwider, 2010, 2017)$iso[i])
    bau_tibble <- rbind(bau_tibble, col)
  }
  colnames(bau_tibble) <- year
  bau_tibble
  
  namecountry2 <- select(calc_bau_arr(mmr_pivotwider_tibble, 2010, 2017), "iso" , "name", "arr")
  mmrprojcountry2 <- cbind(namecountry2, bau_tibble)
  
  return(mmrprojcountry2)
}

###
start_year = 2016
end_year = 2030
nyears <- end_year - start_year +1
year <- c()
year[1] = start_year
for (i in 2:nyears) {
  year[i] <- year[i - 1] + 1
}

bau_tibble  <- NULL
for(i in 1:nrow(calc_bau_arr(mmr_est_unrounded_pwider, 2010, 2017))){
  col <- mmr_country_projections(mmr_est_unrounded_pwider, iso_code = calc_bau_arr(mmr_est_unrounded_pwider, 2010, 2017)$iso[i])
  bau_tibble <- rbind(bau_tibble, col)
  colnames(bau_tibble) <- year
}

namecountry2 <- select(calc_bau_arr(mmr_pivotwider_tibble, 2010, 2017), "iso" , "name", "arr")
mmrprojcountry2 <- cbind(namecountry2, bau_tibble)

return(mmrprojcountry2)


macp(mmr_est_unrounded_pwider)