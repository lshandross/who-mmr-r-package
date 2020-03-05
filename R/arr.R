
get_arr <- function(start_value, end_value, length_period){
  1/length_period*log(start_value/end_value)
}

# calc_bau_arr <- function(mmr_pivotwider_tibble, start_year, end_year) {
#   #  length_years = end_year - start_year
#   arr <- get_arr(mmr_pivotwider_tibble[["2010"]], mmr_pivotwider_tibble[["2017"]], end_year - start_year)
#   #(-1/(length_years))*log(mmr_pivotwider_tibble[["2017"]]/mmr_pivotwider_tibble$`2010`)
#   return(cbind(mmr_pivotwider_tibble, arr))
# }
