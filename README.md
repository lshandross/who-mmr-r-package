WHO MMR Final Package Write-Up
================
Li Shandross
5/6/2020

#### Description

This document serves as documentation for the package WHOmmr that aims
to help analyze the data collected by the World Health Organization
(WHO) on Maternal Mortality Ratio (MMR) around the world. WHO defines
MMR as “the number of maternal deaths per 100,000 live births.” WHOmmr
is a collection of functions that work on estimates of maternal
mortality between 2000 and 2017 (though we are focusing on 2010 to 2017)
to gain insight about the projected MMR for every country between 2016
and 2030. In particular, this package is meant to assist WHO in the
achieving the standard development goal (SDG) of a global MMR of 70 by
2030, with no single country having an MMR above 140, to reduce
inequality in this sector.

We compare MMR projections following the observed, Business As Usual
(BAU) trends with these SDG projections that WHO hopes to achieve. The
Average Rate of Reduction (ARR) is the average annual reduction in MMR a
particular country or region experiences, and this ARR is used to
calculate the desired projections.

Below, a description of each function is provided about its purpose and
an example is given for its implementation

#### Calc BAU ARR

Calculates the observed (BAU) ARR of each country based on the observed
ARR from time1 to time2.

**Base Equation:** ARR (for period t1 to t2) = -1/(t2 - t1) \*
log(MMR(t2) / MMR(t1))

**Tests**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in function.

``` r
bau_arr_tibble <- calc_bau_arr(mmr_est_unrounded_pwider, 3, 10)
kable(bau_arr_tibble[1:5, ])
```

| iso |       arr |
| :-- | --------: |
| AFG | 0.0503407 |
| ALB | 0.0397664 |
| DZA | 0.0033535 |
| AGO | 0.0375549 |
| ATG | 0.0054979 |

#### MMR Projections (single country)

Calculates the MMR projections for one country during a specified period
using data from baseyear 2015 and the country’s respective ARR. The
single country is specified by using its assigned ISO code. (This
function can be used for any MMR projections when provided with an
tibble of ARRs for each country.)

**Base Equation:** MMR(t) = MMR(2015) \* exp(-ARR \* (t - 2015))

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in function.

``` r
#BAU MMR Projections for Afghanistan
mmr_proj_single_country(mmr_est_unrounded_pwider, bau_arr_tibble, 2, "AFG", 2016, 2030) 
```

    ##  [1] 666.7393 634.0060 602.8798 573.2816 545.1366 518.3734 492.9240
    ##  [8] 468.7241 445.7123 423.8303 403.0225 383.2363 364.4215 346.5303
    ## [15] 329.5176

#### MMR Projections (all countries)

Calculates the MMR projections for all countries for a specified period
using data from baseyear 2015 and each country’s respective ARR. (This
function can be used for any MMR projections when provided with an
tibble of ARRs for each country.)

**Base Equation:** MMR(t) = MMR(2015) \* exp(-ARR \* (t - 2015))

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in function.  
\- Check that this function’s call to mmr\_proj\_single\_country
produces the correct results.

``` r
#BAU Projections for all countries between 2016 and 2030
bau_mmr_proj <- mmr_proj_all_countries(mmr_est_unrounded_pwider, bau_arr_tibble, 2, 2016, 2030)
bau_mmr_proj_rounded <- mutate_if(bau_mmr_proj, is.numeric, round, 2) #rounded to 2 decimal places
kable(bau_mmr_proj_rounded[1:6, ])
```

| iso | name                |   2016 |   2017 |   2018 |   2019 |   2020 |   2021 |   2022 |   2023 |   2024 |   2025 |   2026 |   2027 |   2028 |   2029 |   2030 |
| :-- | :------------------ | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
| AFG | Afghanistan         | 666.74 | 634.01 | 602.88 | 573.28 | 545.14 | 518.37 | 492.92 | 468.72 | 445.71 | 423.83 | 403.02 | 383.24 | 364.42 | 346.53 | 329.52 |
| ALB | Albania             |  14.38 |  13.82 |  13.28 |  12.77 |  12.27 |  11.79 |  11.33 |  10.89 |  10.46 |  10.06 |   9.66 |   9.29 |   8.92 |   8.58 |   8.24 |
| DZA | Algeria             | 113.18 | 112.81 | 112.43 | 112.05 | 111.68 | 111.30 | 110.93 | 110.56 | 110.19 | 109.82 | 109.45 | 109.08 | 108.72 | 108.36 | 107.99 |
| AGO | Angola              | 241.63 | 232.72 | 224.14 | 215.88 | 207.93 | 200.26 | 192.88 | 185.77 | 178.92 | 172.33 | 165.98 | 159.86 | 153.97 | 148.29 | 142.83 |
| ATG | Antigua and Barbuda |  43.07 |  42.83 |  42.60 |  42.37 |  42.13 |  41.90 |  41.67 |  41.44 |  41.22 |  40.99 |  40.77 |  40.54 |  40.32 |  40.10 |  39.88 |
| ARG | Argentina           |  40.07 |  38.78 |  37.54 |  36.33 |  35.16 |  34.03 |  32.93 |  31.88 |  30.85 |  29.86 |  28.90 |  27.97 |  27.07 |  26.20 |  25.36 |

#### MMR Projections (by region)

1.  Produces a table of all the projected MMRs by SDG region for a
    specified period.  
2.  Produces a line graph of all the projected MMRs by SDG region.

These main two functions can be used for any MMR projections when
provided with an tibble of MMR projections for all countries. However,
note that the large, wrapper functions can only be used on data
formatted in exactly the same way as the WHO MMR data with the same
region definitions and names. Using the individual global and regional
prediction functions is suitable for data formatted slightly
differently.

**Base Equation:** MMR(region) = sum(region\_mmr\_proj \*
region\_total\_births) / sum(region\_total\_births)

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if the correct values are returned (using toy data) based
on base equation in the function.  
\- Check that this function’s call to the two helper functions produces
the correct results.

``` r
#Part 1: Table - BAU Regional Projections for 2016 to 2030
bau_regional_proj_summaries <- 
  mmr_proj_all_regions(mmr_est_unrounded_pwider, 
                       bau_mmr_proj, 
                       countries_and_regions, 
                       births2030, 
                       2016, 
                       2030)
bau_regional_proj_rounded <- mutate_if(bau_regional_proj_summaries, is.numeric, round, 2) #rounded to 2 decimal places
kable(bau_regional_proj_rounded)
```

| SDG Region                                            |   2016 |   2017 |   2018 |   2019 |   2020 |   2021 |   2022 |   2023 |   2024 |   2025 |   2026 |   2027 |   2028 |   2029 |   2030 |
| :---------------------------------------------------- | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
| Global                                                | 244.67 | 238.76 | 233.04 | 227.53 | 222.20 | 217.06 | 212.09 | 207.28 | 202.64 | 198.15 | 193.82 | 189.62 | 185.57 | 181.64 | 177.84 |
| Australia and New Zealand                             |   7.01 |   7.09 |   7.17 |   7.26 |   7.34 |   7.43 |   7.53 |   7.63 |   7.73 |   7.83 |   7.94 |   8.05 |   8.17 |   8.29 |   8.41 |
| Central Asia and Southern Asia                        | 160.81 | 153.55 | 146.62 | 140.01 | 133.69 | 127.67 | 121.92 | 116.43 | 111.19 | 106.19 | 101.42 |  96.86 |  92.51 |  88.36 |  84.40 |
| Eastern Asia and South-eastern Asia                   |  75.52 |  73.53 |  71.61 |  69.74 |  67.93 |  66.17 |  64.46 |  62.81 |  61.20 |  59.65 |  58.13 |  56.67 |  55.24 |  53.86 |  52.51 |
| Latin America and the Caribbean                       |  76.05 |  74.80 |  73.59 |  72.41 |  71.27 |  70.16 |  69.09 |  68.06 |  67.05 |  66.07 |  65.13 |  64.21 |  63.32 |  62.45 |  61.61 |
| Northern America and Europe                           |  12.53 |  12.53 |  12.55 |  12.58 |  12.62 |  12.68 |  12.75 |  12.84 |  12.94 |  13.05 |  13.18 |  13.32 |  13.48 |  13.65 |  13.83 |
| Oceania / Oceania excluding Australia and New Zealand | 133.47 | 130.83 | 128.25 | 125.72 | 123.24 | 120.82 | 118.44 | 116.12 | 113.84 | 111.61 | 109.43 | 107.29 | 105.20 | 103.15 | 101.14 |
| Sub-Saharan Africa                                    | 558.68 | 547.89 | 537.40 | 527.21 | 517.31 | 507.68 | 498.31 | 489.20 | 480.33 | 471.71 | 463.31 | 455.14 | 447.18 | 439.43 | 431.88 |
| Western Asia and Northern Africa                      |  93.94 |  91.68 |  89.51 |  87.43 |  85.43 |  83.51 |  81.68 |  79.92 |  78.23 |  76.62 |  75.07 |  73.59 |  72.18 |  70.83 |  69.54 |

``` r
#Part 2: Graph - BAU Regional Projections for 2016 to 2030
mmr_proj_all_regions_graph(mmr_est_unrounded_pwider, bau_mmr_proj, countries_and_regions, births2030, 2016, 2030)
```

![](WHO-MMR-Final-Package-Write-Up_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

#### Get ARR SDG Target

Calculates the target ARR needed to achieve WHO’s SDG goal of a global
MMR of 70, with no country with an MMR above 140, by 2030.

**Base Equation:** N/A, R minimizes the results of the squared\_diff
function which calls get\_mmr\_sdg\_proj

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in the function.  
\- Check that this function’s call to its inner function, squared\_diff
(and thus get\_mmr\_sdg\_proj, as well) produces the correct results.

``` r
get_arr_sdg_target(mmr2015, births, 15)
```

    ## $minimum
    ## [1] 0.05603232
    ## 
    ## $objective
    ## [1] 6.010324e-05

#### Calculate SDG ARR for each country Based on SDG MMR

Calculates the specific ARR for each country needed to achieve WHO’s SDG
goal of a global MMR of 70, with no country with an MMR above 140, by
2030. Each country-specific ARR is based on the single target SDG ARR
calculated.

**Base Equation:** -1/nproject \*
log(mmr\_sdg\_projections\_using\_sdg\_arr/2015\_mmr\_all\_countries)

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in the function.  
\- Check that this function’s call to get\_mmr\_sdg\_proj and
get\_arr\_sdg\_proj (and thus squared\_diff, as well) produces the
correct
results.

``` r
sdg_arr_tibble <- calc_sdg_arr(mmr_est_unrounded_pwider, sdg_arr_target, mmr2015, births, 15)
kable(sdg_arr_tibble[1:5, ])
```

| iso |  sdg\_arr |
| :-- | --------: |
| AFG | 0.1074065 |
| ALB | 0.0560323 |
| DZA | 0.0560323 |
| AGO | 0.0560323 |
| ATG | 0.0560323 |

#### SDG MMR Projections

These are calculated by the general mmr\_proj\_all\_countries,
mmr\_proj\_all\_regions, and mmr\_proj\_all\_regions\_graph,
respectively. See above for more details.

**SDG MMR Projections for 2016 to
2030**

``` r
sdg_mmr_proj <- mmr_proj_all_countries(mmr_est_unrounded_pwider, sdg_arr_tibble, 2, 2016, 2030) 
sdg_mmr_proj_rounded <- mutate_if(sdg_mmr_proj, is.numeric, round, 2) #rounded to 2 decimal places
kable(sdg_mmr_proj_rounded[1:6, ])
```

| iso | name                |   2016 |   2017 |   2018 |   2019 |   2020 |   2021 |   2022 |   2023 |   2024 |   2025 |   2026 |   2027 |   2028 |   2029 |   2030 |
| :-- | :------------------ | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
| AFG | Afghanistan         | 629.76 | 565.62 | 508.02 | 456.28 | 409.82 | 368.08 | 330.60 | 296.93 | 266.69 | 239.53 | 215.14 | 193.23 | 173.55 | 155.87 | 140.00 |
| ALB | Albania             |  14.15 |  13.38 |  12.65 |  11.96 |  11.31 |  10.69 |  10.11 |   9.56 |   9.04 |   8.55 |   8.08 |   7.64 |   7.22 |   6.83 |   6.46 |
| DZA | Algeria             | 107.38 | 101.52 |  95.99 |  90.76 |  85.82 |  81.14 |  76.72 |  72.54 |  68.59 |  64.85 |  61.31 |  57.97 |  54.81 |  51.83 |  49.00 |
| AGO | Angola              | 237.20 | 224.28 | 212.06 | 200.50 | 189.58 | 179.25 | 169.48 | 160.24 | 151.51 | 143.26 | 135.45 | 128.07 | 121.09 | 114.49 | 108.25 |
| ATG | Antigua and Barbuda |  40.95 |  38.72 |  36.61 |  34.61 |  32.73 |  30.94 |  29.26 |  27.66 |  26.16 |  24.73 |  23.38 |  22.11 |  20.90 |  19.76 |  18.69 |
| ARG | Argentina           |  39.15 |  37.01 |  35.00 |  33.09 |  31.29 |  29.58 |  27.97 |  26.45 |  25.00 |  23.64 |  22.35 |  21.14 |  19.98 |  18.89 |  17.87 |

**SDG MMR Regional Projections**

``` r
#Part 1: Table - SDG Regional Projections for 2016 to 2030
sdg_regional_proj_summaries <- mmr_proj_all_regions(mmr_est_unrounded_pwider, sdg_mmr_proj, countries_and_regions, births2030, 2016, 2030)
sdg_regional_proj_rounded <- mutate_if(sdg_regional_proj_summaries, is.numeric, round, 2) #rounded to 2 decimal places
kable(sdg_regional_proj_rounded)
```

| SDG Region                                            |   2016 |   2017 |   2018 |   2019 |   2020 |   2021 |   2022 |   2023 |   2024 |   2025 |   2026 |   2027 |   2028 |   2029 |   2030 |
| :---------------------------------------------------- | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
| Global                                                | 229.45 | 210.11 | 192.57 | 176.64 | 162.18 | 149.02 | 137.05 | 126.15 | 116.21 | 107.13 |  98.85 |  91.27 |  84.34 |  77.99 |  72.18 |
| Australia and New Zealand                             |   6.56 |   6.20 |   5.87 |   5.55 |   5.24 |   4.96 |   4.69 |   4.43 |   4.19 |   3.96 |   3.75 |   3.54 |   3.35 |   3.17 |   2.99 |
| Central Asia and Southern Asia                        | 158.13 | 148.50 | 139.51 | 131.09 | 123.22 | 115.85 | 108.95 | 102.48 |  96.42 |  90.74 |  85.41 |  80.41 |  75.72 |  71.32 |  67.18 |
| Eastern Asia and South-eastern Asia                   |  73.34 |  69.34 |  65.57 |  61.99 |  58.61 |  55.42 |  52.40 |  49.55 |  46.85 |  44.29 |  41.88 |  39.60 |  37.44 |  35.40 |  33.47 |
| Latin America and the Caribbean                       |  72.80 |  68.53 |  64.51 |  60.74 |  57.19 |  53.86 |  50.72 |  47.77 |  45.00 |  42.39 |  39.94 |  37.63 |  35.45 |  33.41 |  31.49 |
| Northern America and Europe                           |  11.86 |  11.21 |  10.60 |  10.02 |   9.48 |   8.96 |   8.47 |   8.01 |   7.57 |   7.16 |   6.77 |   6.40 |   6.05 |   5.72 |   5.41 |
| Oceania / Oceania excluding Australia and New Zealand | 128.75 | 121.73 | 115.10 | 108.82 | 102.89 |  97.29 |  91.99 |  86.97 |  82.23 |  77.75 |  73.52 |  69.51 |  65.72 |  62.14 |  58.76 |
| Sub-Saharan Africa                                    | 515.07 | 465.95 | 421.81 | 382.13 | 346.43 | 314.29 | 285.34 | 259.24 | 235.70 | 214.45 | 195.25 | 177.90 | 162.21 | 148.00 | 135.14 |
| Western Asia and Northern Africa                      |  91.05 |  86.09 |  81.40 |  76.96 |  72.77 |  68.80 |  65.05 |  61.51 |  58.16 |  54.99 |  51.99 |  49.16 |  46.48 |  43.95 |  41.55 |

``` r
#Part 2: Graph - SDG Regional Projections for 2016 to 2030
mmr_proj_all_regions_graph(mmr_est_unrounded_pwider, sdg_mmr_proj, countries_and_regions, births2030, 2016, 2030)
```

![](WHO-MMR-Final-Package-Write-Up_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->
