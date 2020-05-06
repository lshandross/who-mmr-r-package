#' Calculate the MMR projections for a specified country
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param arr_tibble A tibble that includes the desired ARR for every country along w/ each country's ISO code
#' @param arr_col_num The column number of the column of arr_tibble that lists each country's ARR
#' @param mmr_start_year A year to start MMR projections from
#' @param mmr_end_year A year to end MMR projections on
#'
#' @return The MMR projections for one country for the specified year range
#' @export
#'
#' @examples
mmr_proj_all_countries <- function(mmr_pivotwider_tibble, arr_tibble, arr_col_num, mmr_start_year, mmr_end_year) {
  mmr_proj_tibble <- NULL
  for(i in 1: nrow(arr_tibble)){
    col <- mmr_proj_single_country(mmr_pivotwider_tibble, arr_tibble, arr_col_num, iso_code = arr_tibble$iso[i], mmr_start_year, mmr_end_year)
    mmr_proj_tibble <- rbind(mmr_proj_tibble, col)
  }

  colnames(mmr_proj_tibble) <- seq(mmr_start_year, mmr_end_year)
  mmr_tibble <- cbind(select(arr_tibble, -c(arr_col_num)), mmr_proj_tibble)
  mmr_tibble
}
