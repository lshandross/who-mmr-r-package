#' Calculate Squared Difference of actual MMR versus the SDG MMR
#'
#' @param global_arr The calculated global ARR
#' @param mmr2015_country A vector with MMR for 2015 for all countries
#' @param births_tibble A tibble with the births by country for 2030
#' @param nproject The number of years to project, number of years since the base year, 2015
#'
#' @return The average squared difference between the current global MMR and the SDG goal of global MMR of 70
#' @export
#'
#' @examples
squared_diff <- function(global_arr, mmr2015_country, births_tibble, nproject){
  sdg_prediction <- get_mmr_sdg_proj(mmr2015_country, global_arr, nproject)

  #in case the births_tibble has extra rows not in the mmr_pivot_wider_tibble
  testbirths <- births_tibble %>%
    right_join(mmr_est_unrounded_pwider, by = c("name" = "name")) %>%
    select(`Births`)

  mmr_births <-  testbirths * sdg_prediction
  mmr_births1 <- filter(mmr_births, `Births` >1000) #data filtered due to large amounts that must be processed
  mmr_births2 <- filter(mmr_births, `Births`<=1000)
  births1 <- filter(testbirths, `Births`>500)
  births2 <- filter(testbirths, `Births`<=500)
  mmr_global <- (sum(mmr_births1) + sum(mmr_births2)) / (sum(births1) + sum(births2))
  (mmr_global - 70)^2

}
