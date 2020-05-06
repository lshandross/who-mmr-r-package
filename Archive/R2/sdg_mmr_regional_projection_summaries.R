#' Get SDG MMR Projections for a Specified Period by Region and Globally
#'
#' @param mmr_pivotwider_tibble A tibble that contains all countries' MMR in the pivotwider format
#' @param bau_sdg_arr_tibble A tibble that includes all of the BAU and SDG ARRs
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to
#' @param birth_projections_tibble A tibble with the births by country for 2030
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_end_year A year to end the summary projections with
#'
#' @return A tibble summarizing regional and global SDG MMR projections for a specified time period
#' @export
#'
#' @examples
sdg_mmr_regional_projection_summaries <- function(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, proj_start_year, proj_end_year) {

  #collect regional and global summaries, put into list
  Global = global_sdg_mmr_summary(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, proj_start_year, proj_end_year)
  ANZ = regional_sdg_mmr_summary(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, "Australia and New Zealand", proj_start_year, proj_end_year)
  CASA = regional_sdg_mmr_summary(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, "Central Asia and Southern Asia", proj_start_year, proj_end_year)
  EASA = regional_sdg_mmr_summary(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, "Eastern Asia and South-eastern Asia", proj_start_year, proj_end_year)
  LAC = regional_sdg_mmr_summary(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, "Latin America and the Caribbean", proj_start_year, proj_end_year)
  NAE = regional_sdg_mmr_summary(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, "Northern America and Europe", proj_start_year, proj_end_year)
  OOeANZ = regional_sdg_mmr_summary(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, "Oceania / Oceania excluding Australia and New Zealand", proj_start_year, proj_end_year)
  SSA = regional_sdg_mmr_summary(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, "Sub-Saharan Africa", proj_start_year, proj_end_year)
  WANA = regional_sdg_mmr_summary(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, "Western Asia and Northern Africa", proj_start_year, proj_end_year)

  region_projections <- list(Global, ANZ, CASA, EASA, LAC, NAE, OOeANZ, SSA, WANA)

  sdg_summary_table <- do.call(rbind, region_projections)
  sdg_summary_table <- rename(sdg_summary_table, `SDG Region` = "sdg_1")
  sdg_summary_table
}


#' Get Global SDG MMR Projections for a Specified Period
#'
#' @param mmr_pivotwider_tibble A tibble that contains all countries' MMR in the pivotwider format
#' @param bau_sdg_arr_tibble A tibble that includes all of the BAU and SDG ARRs
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to
#' @param birth_projections_tibble A tibble with the births by country for 2030
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_end_year A year to end the summary projections with
#'
#' @return A tibble summarizing regional and global SDG MMR projections for a specified time period
#' @export
#'
#' @examples
global_sdg_mmr_summary <- function(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, proj_start_year, proj_end_year){

  mmr_sdg_df <- left_join(sdg_mmr_allcountries_proj(mmr_est_unrounded_pwider, bau_sdg_arr_tibble, proj_start_year, proj_end_year) %>% select(-c("bau arr", "name")), countries_regions_tibble, by = c("iso" = "ISOCode")) %>% left_join(birth_projections_tibble %>% select(`LocID`, `Births`), by = c("ISONum" = "LocID"))

  nvars <- ncol(mmr_sdg_df) -  4
  global_sdg_mmrs <- rep(NA, nvars)
  for (i in 3:nvars){
    global_sdg_mmrs[i] <- (sum(mmr_sdg_df[,i] * mmr_sdg_df$Births)) / (sum(mmr_sdg_df$Births))
  }

  global_sdg <- na.omit(global_sdg_mmrs)
  global_sdg
  nyears <- proj_end_year - proj_start_year + 1
  years <- seq(proj_start_year, proj_end_year)
  gsm <- data.frame(years, global_sdg)
  gsm %>%
    pivot_wider(names_from = `years`, values_from = `global_sdg`) %>%
    mutate(`sdg_1` = "Global") %>%
    select(c(sdg_1, 1:nyears))
}


#' Get Regional SDG MMR Projections between 2016 and 2030
#'
#' @param mmr_pivotwider_tibble A tibble that contains all countries' MMR in the pivotwider format
#' @param bau_sdg_arr_tibble A tibble that includes all of the BAU and SDG ARRs
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to
#' @param birth_projections_tibble A tibble with the births by country for 2030
#' @param proj_start_year A year to begin the summary projections from
#' @param sdg1_region The exact name of the desired region (must be in quotes)
#' @param proj_end_year A year to end the summary projections with
#'
#' @return A tibble summarizing regional and global SDG MMR projections for a specified time period
#' @export
#'
#' @examples
regional_sdg_mmr_summary <- function(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, sdg1_region, proj_start_year, proj_end_year) {
  #note that region must be in quotes
  mmr_sdg_df <- left_join(sdg_mmr_allcountries_proj(mmr_est_unrounded_pwider, bau_sdg_arr_tibble, proj_start_year, proj_end_year) %>% select(-c("bau arr", "name")), countries_regions_tibble, by = c("iso" = "ISOCode")) %>% left_join(birth_projections_tibble %>% select(`LocID`, `Births`), by = c("ISONum" = "LocID"))

  mmr_sdg_df_region <- filter(mmr_sdg_df, sdg_1 == sdg1_region)

  nvars <- ncol(mmr_sdg_df_region) -  4
  region_sdg_mmrs <- rep(NA, nvars)
  for (i in 3:nvars){
    region_sdg_mmrs[i] <- (sum(mmr_sdg_df_region[,i] * mmr_sdg_df_region$Births)) / (sum(mmr_sdg_df_region$Births))
  }

  region_sdg_mmrs <- na.omit(region_sdg_mmrs)
  region_sdg_mmrs
  nyears <- proj_end_year - proj_start_year + 1
  year <- seq(proj_start_year, proj_end_year)
  region <- data.frame(year, region_sdg_mmrs)
  region %>%
    pivot_wider(names_from = `year`, values_from = `region_sdg_mmrs`) %>%
    mutate(`sdg_1` = sdg1_region) %>%
    select(c(sdg_1, 1:nyears))
}


#' Get Graph of Regional SDG MMR Projections between 2016 and 2030
#'
#' @param mmr_pivotwider_tibble A tibble that contains all countries' MMR in the pivotwider format
#' @param bau_sdg_arr_tibble A tibble that includes all of the BAU and SDG ARRs
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to
#' @param birth_projections_tibble A tibble with the births by country for 2030
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_end_year A year to end the summary projections with
#'
#' @return A tibble summarizing regional and global SDG MMR projections for a specified time period
#' @export
#'
#' @examples
sdg_mmr_regional_global_graph <- function(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, proj_start_year, proj_end_year) {

  sdg_mmr_regional_projection_summaries(mmr_pivotwider_tibble, bau_sdg_arr_tibble, countries_regions_tibble, birth_projections_tibble, proj_start_year, proj_end_year) %>%
    pivot_longer(2:(proj_end_year - proj_start_year + 1), names_to = "period",values_to = "mmr") %>%
    ggplot() + geom_point(aes(x = period,y = mmr, color = `SDG Region`)) +
    geom_line(mapping = aes(x = period, y = mmr, group = `SDG Region`, color = `SDG Region`)) +
    scale_x_discrete(breaks = c(2015, 2018, 2021, 2024, 2027, 2030))
}
