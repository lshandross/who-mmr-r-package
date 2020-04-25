##' Calculate the BAU MMR projections for all countries for a given period
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param bau_sdg_arr_tibble A tibble that includes all of the BAU and SDG ARRs
#' @param mmr_start_year A year to start BAU MMR projections from
#' @param mmr_end_year A year to end BAU MMR projections on
#'
#' @return The SDG MMR projections for all countries for the specified year range
#' @export
#'
#' @examples

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
