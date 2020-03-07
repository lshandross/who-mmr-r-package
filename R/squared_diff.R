squared_diff <- function(global_arr, mmr2015_country,
                births_tibble, nproject){
  sdg_2030_prediction <- get_mmr2030_sdg_projections(mmr2015_country, global_arr, 15)
  testbirths <- live_birth_projections2030 %>%
    right_join(mmr_est_unrounded_pwider, by = c("name" = "name")) %>%
    select(`Births`)
  
  mmr_births <- sdg_2030_prediction * testbirths
  mmr_births1 <- filter(mmr_births, `Births` >1000)
  mmr_births2 <- filter(mmr_births, `Births`<=1000)
  births1 <- filter(testbirths, `Births`>500)
  births2 <- filter(testbirths, `Births`<=500)
  mmr_global <- (sum(mmr_births1) + sum(mmr_births2)) / (sum(births1) + sum(births2)) 
  (mmr_global - 70)^2
  
}