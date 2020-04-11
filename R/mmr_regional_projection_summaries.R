#' Get MMR Projections between 2016 and 2030 by Region and Globally
#'
#' @param mmr_pivotwider_tibble A tibble that contains all countries' MMR in the pivotwider format
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to 
#' @param birth_projections_tibble A tibble with the births by country for 2030
#' @param arr_start_year A year to begin the arr calculation from
#' @param arr_start_year A year to end the arr calculation with
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_start_year A year to end the summary projections with
#'
#' @return A tibble summarizing regional and global MMR projections for a specified time period
#' @export
#'
#' @examples
bau_mmr_regional_projection_summaries <- function(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, arr_start_year, arr_end_year, proj_start_year, proj_end_year) {
  
  #collect regional and global summaries, put into list
  Global = global_mmr_summary(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, arr_start_year, arr_end_year, proj_start_year, proj_end_year) 
  ANZ = regional_mmr_summary(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, "Australia and New Zealand", proj_start_year, proj_end_year)
  CASA = regional_mmr_summary(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, "Central Asia and Southern Asia", proj_start_year, proj_end_year)
  EASA = regional_mmr_summary(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, "Eastern Asia and South-eastern Asia", proj_start_year, proj_end_year)
  LAC = regional_mmr_summary(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, "Latin America and the Caribbean", proj_start_year, proj_end_year)
  NAE = regional_mmr_summary(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, "Northern America and Europe", proj_start_year, proj_end_year)
  OOeANZ = regional_mmr_summary(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, "Oceania / Oceania excluding Australia and New Zealand", proj_start_year, proj_end_year)
  SSA = regional_mmr_summary(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, "Sub-Saharan Africa", proj_start_year, proj_end_year)
  WANA = regional_mmr_summary(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, "Western Asia and Northern Africa", proj_start_year, proj_end_year)
  
  region_projections <- list(Global, ANZ, CASA, EASA, LAC, NAE, OOeANZ, 
                             SSA, WANA)

  summary_table <- do.call(rbind, region_projections)
  rename(summary_table, region = "sdg_1")
  
  summary_table
}


#' Get Global MMR Projections between 2016 and 2030
#'
#' @param mmr_pivotwider_tibble A tibble that contains all countries' MMR in the pivotwider format
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to 
#' @param birth_projections_tibble A tibble with the births by country for 2030
#' @param arr_start_year A year to begin the arr calculation from
#' @param arr_start_year A year to end the arr calculation with
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_start_year A year to end the summary projections with
#'
#' @return A one-line tibble summarizing global MMR projections from 2016 to 2030
#' @export
#'
#' @examples
global_mmr_summary <-
  function(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, arr_start_year, arr_end_year, proj_start_year, proj_end_year){
    mmr_df <- left_join(mmr_allcountries_projections(mmr_pivotwider_tibble, arr_start_year, arr_end_year, proj_start_year, proj_end_year) %>% select(-c(`name`, `arr`)), countries_regions_tibble, by = c("iso" = "ISOCode")) %>% left_join(birth_projections_tibble %>% select(`LocID`, `Births`), by = c("ISONum" = "LocID"))
    
    nvars <- ncol(mmr_df) -  4
    global_mmrs <- rep(NA, nvars) 
    for (i in 2:nvars){ 
      global_mmrs[i] <- (sum(mmr_df[,i] * mmr_df$Births)) / (sum(mmr_df$Births)) 
    } 
    
    global <- na.omit(global_mmrs)
    global
    nyears <- proj_end_year - proj_start_year + 1
    years <- seq(proj_start_year, proj_end_year)
    gm <- data.frame(years, global)
    gm %>% 
      pivot_wider(names_from = `years`, values_from = `global`) %>%
      mutate(`sdg_1` = "Global") %>%
      select(c(sdg_1, 1:nyears))
  }


#' Get Regional MMR Projections between 2016 and 2030
#'
#' @param mmr_pivotwider_tibble A tibble that contains all countries' MMR in the pivotwider format
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to 
#' @param birth_projections_tibble A tibble with the births by country for 2030
#' @param sdg1_region The exact name of the desired region (must be in quotes)
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_start_year A year to end the summary projections with
#'
#' @return A one-line tibble summarizing the specificed region's MMR projections from 2016 to 2030
#' @export
#'
#' @examples
regional_mmr_summary <- function(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, sdg1_region, proj_start_year, proj_end_year) {
  #note that region must be in quotes
  md_region <- filter(md, sdg_1 == sdg1_region)
  
  nvars <- ncol(md_region) -  4
  region_mmrs <- rep(NA, nvars) 
  for (i in 2:nvars){ 
    region_mmrs[i] <- (sum(md_region[,i] * md_region$Births)) / (sum(md_region$Births)) 
  } 
  
  region_mmrs <- na.omit(region_mmrs)
  region_mmrs
  nyears <- proj_end_year - proj_start_year + 1
  year <- seq(proj_start_year, proj_end_year)
  region <- data.frame(year, region_mmrs)
  region %>% 
    pivot_wider(names_from = `year`, values_from = `region_mmrs`) %>%
    mutate(`sdg_1` = sdg1_region) %>%
    select(c(sdg_1, 1:nyears))
}



#' Get Graph of Regional MMR Projections between 2016 and 2030
#'
#' @param mmr_pivotwider_tibble A tibble that contains all countries' MMR in the pivotwider format
#' @param countries_regions_tibble A tibble that lists all countries and the region they belong to 
#' @param birth_projections_tibble A tibble with the births by country for 2030
#' @param arr_start_year A year to begin the arr calculation from
#' @param arr_start_year A year to end the arr calculation with
#' @param proj_start_year A year to begin the summary projections from
#' @param proj_start_year A year to end the summary projections with
#'
#' @return Line graph summarizing regional and global MMR projections for a specified time period
#' @export
#'
#' @examples
bau_mmr_regional_global_graph <- function(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble, arr_start_year, arr_end_year, proj_start_year, proj_end_year) {
  bau_mmr_regional_projection_summaries(mmr_est_unrounded_pwider, countries_and_regions, live_birth_projections2030, arr_start_year, arr_end_year, proj_start_year, proj_end_year) %>%
    pivot_longer(2:(proj_end_year - proj_start_year + 1), names_to = "period",values_to = "mmr") %>%
    ggplot() + geom_point(aes(x = period,y = mmr, color = sdg_1)) +
    geom_line(mapping = aes(x = period, y = mmr, group = sdg_1, color = sdg_1))
}