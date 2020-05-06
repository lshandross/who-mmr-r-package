#' Calculate BAU MMR projections for all countries for a given range
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param arr_start_year_colnum The column number of the year to start the BAU ARR calculation with
#' @param arr_end_year_colnum The column number of the to end the BAU ARR calculation with
#' @param mmr_start_year A year to start BAU MMR projections from
#' @param mmr_end_year A year to end BAU MMR projections on
#'
#' @return The BAU MMR projections for all countries for the specified year range
#' @export
#'
#' @examples
bau_mmr_all_countries_proj <- function(mmr_pivotwider_tibble, arr_start_year_colnum, arr_end_year_colnum, mmr_start_year, mmr_end_year) {
  nyears <- mmr_end_year - mmr_start_year +1
  years <- seq(mmr_start_year, mmr_end_year)

  bau_tibble  <- NULL
  for(i in 1:nrow(calc_bau_arr(mmr_pivotwider_tibble, arr_start_year_colnum, arr_end_year_colnum))){
    col <- bau_mmr_single_country_proj(mmr_pivotwider_tibble, iso_code = calc_bau_arr(mmr_pivotwider_tibble, arr_start_year_colnum, arr_end_year_colnum)$iso[i], arr_start_year_colnum, arr_end_year_colnum, mmr_start_year, mmr_end_year)
    bau_tibble <- rbind(bau_tibble, col)
    colnames(bau_tibble) <- years
  }

  namecountry <- select(mmr_pivotwider_tibble, "iso" , "name")
  mmrprojcountry <- cbind(namecountry, bau_tibble)

  return(mmrprojcountry)
}
