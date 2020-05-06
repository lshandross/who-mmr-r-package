#' Calculate the global and regional MMR projections
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param mmr_proj_tibble A tibble of the projected MMRs for all countries during the desired year range
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to
#' @param births_iso A tibble with the births by country ISO code for the desired year
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_end_year A year to end the summary projections with
#'
#' @return A tibble of the global and regional MMR projections for the specified year range
#' @export
#'
#' @examples
mmr_proj_all_regions <- function(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, proj_start_year, proj_end_year) {

  #collect regional and global summaries, put into list
  Global = mmr_proj_global(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, proj_start_year, proj_end_year)
  ANZ = mmr_proj_regional(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, "Australia and New Zealand", proj_start_year, proj_end_year)
  CASA = mmr_proj_regional(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, "Central Asia and Southern Asia", proj_start_year, proj_end_year)
  EASA = mmr_proj_regional(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, "Eastern Asia and South-eastern Asia", proj_start_year, proj_end_year)
  LAC =  mmr_proj_regional(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, "Latin America and the Caribbean", proj_start_year, proj_end_year)
  NAE = mmr_proj_regional(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, "Northern America and Europe", proj_start_year, proj_end_year)
  OOeANZ = mmr_proj_regional(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, "Oceania / Oceania excluding Australia and New Zealand", proj_start_year, proj_end_year)
  SSA = mmr_proj_regional(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, "Sub-Saharan Africa", proj_start_year, proj_end_year)
  WANA = mmr_proj_regional(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, "Western Asia and Northern Africa", proj_start_year, proj_end_year)

  region_projections <- list(Global, ANZ, CASA, EASA, LAC, NAE, OOeANZ, SSA, WANA)

  mmr_summary_table <- do.call(rbind, region_projections)
  mmr_summary_table <- rename(mmr_summary_table, `SDG Region` = "sdg_1")
  mmr_summary_table
}



#' Calculate the global MMR projections
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param mmr_proj_tibble A tibble of the projected MMRs for all countries during the desired year range
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to
#' @param births_iso A tibble with the births by country ISO code for the desired year
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_end_year A year to end the summary projections with
#'
#' @return The global MMR projections for the specified year range
#' @export
#'
#' @examples
mmr_proj_global <- function(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, proj_start_year, proj_end_year) {
  mmr_df <- left_join(mmr_proj_tibble, countries_regions_tibble, by = c("iso" = "ISOCode")) %>%
    left_join(births_iso, by = c("ISONum" = "LocID"))

  nvars <- proj_end_year - proj_start_year + 3
  global_mmrs <- rep(NA, nvars)
  for (i in 3: nvars) {
    global_mmrs[i] <- (sum(mmr_df[,i] * mmr_df$Births)) / sum(mmr_df$Births)
  }
  global_mmrs <- na.omit(global_mmrs)
  nyears <- proj_end_year - proj_start_year + 1
  years <- seq(proj_start_year, proj_end_year)
  global <- data.frame(years, global_mmrs)
  global %>% pivot_wider(names_from = `years`, values_from = `global_mmrs`) %>%
    mutate(`sdg_1` = "Global") %>% select(c(sdg_1, 1:nyears))
}


#' Calculate MMR projections by region
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param mmr_proj_tibble A tibble of the projected MMRs for all countries during the desired year range
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to
#' @param births_iso A tibble with the births by country ISO code for the desired year
#' @param sdg1_region The exact name of the desired region (must be in quotes)
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_end_year A year to end the summary projections with
#'
#' @return The MMR projections by region for the specified year range
#' @export
#'
#' @examples
mmr_proj_regional <- function(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, sdg1_region, proj_start_year, proj_end_year) {
  #note that region must be in quotes
  mmr_df <- left_join(mmr_proj_tibble, countries_regions_tibble, by = c("iso" = "ISOCode")) %>%
    left_join(births_iso, by = c("ISONum" = "LocID"))

  mmr_df_region <- filter(mmr_df, sdg_1 == sdg1_region)

  nvars <- proj_end_year - proj_start_year + 3
  region_mmrs <- rep(NA, nvars)
  for (i in 3: nvars) {
    region_mmrs[i] <- (sum(mmr_df_region[,i] * mmr_df_region$Births)) / sum(mmr_df_region$Births)
  }
  region_mmrs <- na.omit(region_mmrs)
  nyears <- proj_end_year - proj_start_year + 1
  year <- seq(proj_start_year, proj_end_year)
  region <- data.frame(year, region_mmrs)
  region %>%
    pivot_wider(names_from = `year`, values_from = `region_mmrs`) %>%
    mutate(`sdg_1` = sdg1_region) %>%
    select(c(sdg_1, 1:nyears))
}


#' Graph the global and regional MMR projections
#'
#' @param mmr_pivotwider_tibble A tibble that includes all countries' observed MMR in the pivotwider format
#' @param mmr_proj_tibble A tibble of the projected MMRs for all countries during the desired year range
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to
#' @param births_iso A tibble with the births by country ISO code for the desired year
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_end_year A year to end the summary projections with
#'
#' @return A graph of the global and regional MMR projections for the specified year range
#' @export
#'
#' @examples
mmr_proj_all_regions_graph <- function(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, proj_start_year, proj_end_year) {
  mmr_proj_all_regions(mmr_pivotwider_tibble, mmr_proj_tibble, countries_regions_tibble, births_iso, proj_start_year, proj_end_year) %>%
    pivot_longer(2:(proj_end_year - proj_start_year + 1), names_to = "period",values_to = "mmr") %>%
    ggplot() + geom_point(aes(x = period,y = mmr, color = `SDG Region`)) +
    geom_line(mapping = aes(x = period, y = mmr, group = `SDG Region`, color = `SDG Region`)) +
    scale_x_discrete(breaks = c(2015, 2018, 2021, 2024, 2027, 2030))
}
