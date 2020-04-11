#note that this is all hardcoded and needs to be changed
mmr_regional_global_summarize <-
  function(mmr_pivotwider_tibble, countries_regions_tibble, birth_projections_tibble){
    mmr_df <- left_join(mmr_allcountries_projections(mmr_pivotwider_tibble, 2010, 2017, 2016, 2030), countries_regions_tibble, by = c("iso" = "ISOCode")) %>%
      left_join(birth_projections_tibble, by = c("ISONum" = "LocID"))
    global <- mmr_df %>%
      summarise(`MMR in 2016` = (sum(`2016`*`Births`))/(sum(`Births`)),
                `MMR in 2017` = (sum(`2017`*`Births`))/(sum(`Births`)),
                `MMR in 2018` = (sum(`2018`*`Births`))/(sum(`Births`)),
                `MMR in 2019` = (sum(`2019`*`Births`))/(sum(`Births`)),
                `MMR in 2020` = (sum(`2020`*`Births`))/(sum(`Births`)),
                `MMR in 2021` = (sum(`2021`*`Births`))/(sum(`Births`)),
                `MMR in 2022` = (sum(`2022`*`Births`))/(sum(`Births`)),
                `MMR in 2023` = (sum(`2023`*`Births`))/(sum(`Births`)),
                `MMR in 2024` = (sum(`2024`*`Births`))/(sum(`Births`)),
                `MMR in 2025` = (sum(`2025`*`Births`))/(sum(`Births`)),
                `MMR in 2026` = (sum(`2026`*`Births`))/(sum(`Births`)),
                `MMR in 2027` = (sum(`2027`*`Births`))/(sum(`Births`)),
                `MMR in 2028` = (sum(`2028`*`Births`))/(sum(`Births`)),
                `MMR in 2029` = (sum(`2029`*`Births`))/(sum(`Births`)),
                `MMR in 2030` = (sum(`2030`*`Births`))/(sum(`Births`))) %>%
      mutate(`sdg_1` = "Global") %>%
      select(`sdg_1`, `MMR in 2016`, `MMR in 2017`, `MMR in 2018`, `MMR in 2019`, `MMR in 2020`, `MMR in 2021`, `MMR in 2022`, `MMR in 2023`, `MMR in 2024`, `MMR in 2025`, `MMR in 2026`, `MMR in 2027`, `MMR in 2028`, `MMR in 2029`, `MMR in 2030`)
    
    regional <- mmr_df %>%
      group_by(sdg_1) %>%
      summarise(`MMR in 2016` = (sum(`2016`*`Births`))/(sum(`Births`)),
                `MMR in 2017` = (sum(`2017`*`Births`))/(sum(`Births`)),
                `MMR in 2018` = (sum(`2018`*`Births`))/(sum(`Births`)),
                `MMR in 2019` = (sum(`2019`*`Births`))/(sum(`Births`)),
                `MMR in 2020` = (sum(`2020`*`Births`))/(sum(`Births`)),
                `MMR in 2021` = (sum(`2021`*`Births`))/(sum(`Births`)),
                `MMR in 2022` = (sum(`2022`*`Births`))/(sum(`Births`)),
                `MMR in 2023` = (sum(`2023`*`Births`))/(sum(`Births`)),
                `MMR in 2024` = (sum(`2024`*`Births`))/(sum(`Births`)),
                `MMR in 2025` = (sum(`2025`*`Births`))/(sum(`Births`)),
                `MMR in 2026` = (sum(`2026`*`Births`))/(sum(`Births`)),
                `MMR in 2027` = (sum(`2027`*`Births`))/(sum(`Births`)),
                `MMR in 2028` = (sum(`2028`*`Births`))/(sum(`Births`)),
                `MMR in 2029` = (sum(`2029`*`Births`))/(sum(`Births`)),
                `MMR in 2030` = (sum(`2030`*`Births`))/(sum(`Births`)))
    rbind(global, regional) %>%
      rename(Region=sdg_1)
  }
