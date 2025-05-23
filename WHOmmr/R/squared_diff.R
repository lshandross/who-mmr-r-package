#' Calculate Squared Difference of actual MMR versus the SDG MMR
#'
#' @param global_arr The calculated global ARR
#' @param mmr2015_country A vector with MMR for 2015 for all countries
#' @param births_vector A tibble with the births by country for desired year, must have same number of rows as mmr2015_country with the column of births titled `Births`
#' @param nproject The number of years to project, number of years since the base year, 2015
#'
#' @return The average squared difference between the current global MMR and the SDG goal of global MMR of 70
#' @export
#'
#' @examples
squared_diff <- function(global_arr, mmr2015_country, births_vector, nproject){
  sdg_prediction <- get_mmr_sdg_proj(mmr2015_country, global_arr, nproject)

  mmr_births <-  births_vector * sdg_prediction
  mmr_births1 <- filter(mmr_births, `Births` >1000) #data filtered due to large amounts that must be processed
  mmr_births2 <- filter(mmr_births, `Births`<=1000)
  births1 <- filter(births_vector, `Births`>500)
  births2 <- filter(births_vector, `Births`<=500)
  mmr_global <- (sum(mmr_births1) + sum(mmr_births2)) / (sum(births1) + sum(births2))
  (mmr_global - 70)^2

}
