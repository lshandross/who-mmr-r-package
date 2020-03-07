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