WHO MMR MD 5\_4\_20
================
Li Shandross
5/4/2020

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

Each function below has more information about its purpose.

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
calc_bau_arr_tibble <- calc_bau_arr(mmr_est_unrounded_pwider, 3, 10)
kable(calc_bau_arr_tibble[1:5, ])
```

| iso |       arr |
| :-- | --------: |
| AFG | 0.0575322 |
| ALB | 0.0454474 |
| DZA | 0.0038326 |
| AGO | 0.0429199 |
| ATG | 0.0062833 |

#### MMR Projections (for one country)

Calculates the MMR projections for one country for a specified period
using data from baseyear 2015 and the country’s respective BAU ARR. The
single country is specified by using its assigned ISO code.

**Base Equation:** MMR(t) = MMR(2015) \* exp(-ARR \* (t - 2015))

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in function.  
\- Check that this function’s call to calc\_bau\_arr produces the
correct
results.

``` r
bau_mmr_single_country_proj(mmr_est_unrounded_pwider, "AFG", 3, 10, 2016, 2030)
```

    ##  [1] 661.9616 624.9523 590.0122 557.0255 525.8830 496.4817 468.7241
    ##  [8] 442.5185 417.7779 394.4206 372.3691 351.5505 331.8959 313.3401
    ## [15] 295.8217

#### MMR Projections (all countries)

Calculates the MMR projections for all countries for a specified period
using data from baseyear 2015 and each country’s respective BAU ARR.

**Base Equation:** MMR(t) = MMR(2015) \* exp(-ARR \* (t - 2015))

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in function.  
\- Check that this function’s call to bau\_mmr\_single\_country\_proj
(and thus calc\_bau\_arr, as well) produces the correct
results.

``` r
bau_mmr_proj_tibble <- bau_mmr_all_countries_proj(mmr_est_unrounded_pwider,3, 10, 2016, 2030)
kable(bau_mmr_proj_tibble[1:6, ])
```

|       | iso | name                |      2016 |      2017 |      2018 |      2019 |      2020 |      2021 |      2022 |      2023 |       2024 |       2025 |       2026 |       2027 |       2028 |       2029 |       2030 |
| ----- | :-- | :------------------ | --------: | --------: | --------: | --------: | --------: | --------: | --------: | --------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: |
| col   | AFG | Afghanistan         | 661.96164 | 624.95235 | 590.01220 | 557.02549 | 525.88303 | 496.48169 | 468.72414 | 442.51848 | 417.777928 | 394.420587 | 372.369121 | 351.550519 | 331.895854 | 313.340052 | 295.821677 |
| col.1 | ALB | Albania             |  14.30160 |  13.66618 |  13.05899 |  12.47878 |  11.92434 |  11.39454 |  10.88828 |  10.40451 |   9.942241 |   9.500507 |   9.078398 |   8.675044 |   8.289611 |   7.921302 |   7.569358 |
| col.2 | DZA | Algeria             | 113.12986 | 112.69711 | 112.26602 | 111.83658 | 111.40877 | 110.98261 | 110.55807 | 110.13516 | 109.713871 | 109.294190 | 108.876114 | 108.459637 | 108.044753 | 107.631457 | 107.219741 |
| col.3 | AGO | Angola              | 240.33472 | 230.23781 | 220.56510 | 211.29875 | 202.42170 | 193.91759 | 185.77075 | 177.96618 | 170.489489 | 163.326910 | 156.465245 | 149.891850 | 143.594616 | 137.561941 | 131.782709 |
| col.4 | ATG | Antigua and Barbuda |  43.03696 |  42.76739 |  42.49951 |  42.23331 |  41.96878 |  41.70590 |  41.44467 |  41.18508 |  40.927115 |  40.670764 |  40.416019 |  40.162869 |  39.911305 |  39.661316 |  39.412894 |
| col.5 | ARG | Argentina           |  39.88447 |  38.42193 |  37.01301 |  35.65576 |  34.34828 |  33.08875 |  31.87540 |  30.70654 |  29.580550 |  28.495846 |  27.450917 |  26.444305 |  25.474605 |  24.540464 |  23.640577 |

#### SDG MMR Calculation, Categorization, and Adjustment

Calculates the MMR projections for all using a fixed value of the ARR
for a single year t \> 2015 using baseyear 2015, then adjusts the
projections to be less than or equal to 140, as specified by the WHO’s
SDG.

**Base Equation:** MMR(t) = MMR(2015) \* exp(-ARR \* (t - 2015))  
For countries with mmr\_target2030 \> 140, replace mmr\_target by 140

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in function.

``` r
mmr_sdg_proj <- get_mmr_sdg_proj(mmr2015, global_arr, 15)
kable(mmr_sdg_proj[1:5, ])
```

|          x |
| ---------: |
| 140.000000 |
|   9.937566 |
|  75.404901 |
| 140.000000 |
|  28.755982 |

#### Squared Diff

Calculates the squared difference of the global mmr of a specified year
and the SDG goal of a global MMR of 70.

**Base Equation:** (global\_mmr - 70)^2

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in function.  
\- Check that this function’s call to get\_mmr\_sdg\_proj produces the
correct results.

``` r
squared_diff(global_arr, mmr2015, live_birth_projections2030, 15)
```

    ## [1] 257.1634

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
\- Check that this function’s call to squared\_diff (and thus
get\_mmr\_sdg\_proj, as well) produces the correct results.

``` r
get_arr_sdg_target(mmr2015, live_birth_projections2030, 15)
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
arr_sdg_target_country <- calc_sdg_arr(mmr_est_unrounded_pwider, mmr2015, live_birth_projections2030, 15)
kable(arr_sdg_target_country[1:5, ])
```

| iso |  sdg\_arr |
| :-- | --------: |
| AFG | 0.1074065 |
| ALB | 0.0560323 |
| DZA | 0.0560323 |
| AGO | 0.0560323 |
| ATG | 0.0560323 |

#### (BAU) MMR Regional Summaries

1.  Produces a table of all the projected BAU MMRs by SDG region for a
    specified period.  
2.  Produces a line graph of all the projected BAU MMRs by SDG region.

**Base Equation:** MMR(region) = sum(region\_mmr\_proj \*
region\_total\_births) / sum(region\_total\_births)

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in the function.  
\- Check that this function’s call to the two helper functions and
bau\_mmr\_all\_countries\_proj (and thus
bau\_mmr\_single\_countriy\_proj, as well) produces the correct results.

``` r
#Part 1: Table
regional_proj_summaries <- bau_mmr_regional_projection_summaries(mmr_est_unrounded_pwider, countries_and_regions, live_birth_projections2030, 3, 10, 2016, 2030)
knitr::kable(regional_proj_summaries)
```

| SDG Region                                            |       2016 |       2017 |       2018 |       2019 |       2020 |       2021 |       2022 |       2023 |       2024 |       2025 |       2026 |       2027 |       2028 |       2029 |       2030 |
| :---------------------------------------------------- | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: |
| Global                                                | 243.814883 | 237.103765 | 230.656921 | 224.462487 | 218.509179 | 212.786268 | 207.283548 | 201.991310 | 196.900320 | 192.001788 | 187.287356 | 182.749065 | 178.379344 | 174.170986 | 170.117132 |
| Australia and New Zealand                             |   7.025024 |   7.114045 |   7.207496 |   7.305417 |   7.407852 |   7.514844 |   7.626444 |   7.742701 |   7.863672 |   7.989413 |   8.119984 |   8.255448 |   8.395873 |   8.541327 |   8.691883 |
| Central Asia and Southern Asia                        | 159.756448 | 151.538318 | 143.747630 | 136.361943 | 129.360007 | 122.721698 | 116.427960 | 110.460742 | 104.802953 |  99.438400 |  94.351748 |  89.528472 |  84.954813 |  80.617735 |  76.504891 |
| Eastern Asia and South-eastern Asia                   |  75.232046 |  72.977137 |  70.799787 |  68.697071 |  66.666183 |  64.704435 |  62.809245 |  60.978140 |  59.208745 |  57.498782 |  55.846064 |  54.248493 |  52.704051 |  51.210806 |  49.766897 |
| Latin America and the Caribbean                       |  75.871411 |  74.449118 |  73.077279 |  71.753886 |  70.477021 |  69.244848 |  68.055611 |  66.907632 |  65.799304 |  64.729088 |  63.695516 |  62.697178 |  61.732729 |  60.800879 |  59.900394 |
| Northern America and Europe                           |  12.527506 |  12.532424 |  12.556428 |  12.599236 |  12.660604 |  12.740322 |  12.838221 |  12.954165 |  13.088052 |  13.239813 |  13.409412 |  13.596845 |  13.802138 |  14.025347 |  14.266560 |
| Oceania / Oceania excluding Australia and New Zealand | 133.088692 | 130.086088 | 127.155523 | 124.295103 | 121.502993 | 118.777409 | 116.116619 | 113.518944 | 110.982752 | 108.506457 | 106.088521 | 103.727448 | 101.421787 |  99.170126 |  96.971095 |
| Sub-Saharan Africa                                    | 557.115234 | 544.861528 | 533.001751 | 521.520237 | 510.402020 | 499.632809 | 489.198953 | 479.087407 | 469.285708 | 459.781944 | 450.564728 | 441.623174 | 432.946872 | 424.525867 | 416.350636 |
| Western Asia and Northern Africa                      |  93.611651 |  91.049495 |  88.605206 |  86.274129 |  84.051823 |  81.934056 |  79.916789 |  77.996175 |  76.168544 |  74.430401 |  72.778415 |  71.209415 |  69.720379 |  68.308433 |  66.970840 |

``` r
#Part 2: Graph
bau_mmr_regional_global_graph(mmr_est_unrounded_pwider, countries_and_regions, live_birth_projections2030, 3, 10, 2016, 2030)
```

![](WHO-MMR-MD-5_4_20_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

#### SDG MMR Projections

Calculates the SDG MMR projections for all countries for a specified
period using data from baseyear 2015 and each country’s respective BAU
ARR.

**Base Equation:** MMR(t) = MMR(2015) \* exp(-ARR \* (t - 2015))

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in the function.  
\- Check that this function’s call to sdg\_mmr\_single\_country\_proj
produces the correct
results.

``` r
sdg_mmr_single_country_proj(mmr_est_unrounded_pwider, arr_tibble, "AFG", 2016, 2030)
```

    ##  [1] 629.7565 565.6225 508.0198 456.2833 409.8156 368.0802 330.5951
    ##  [8] 296.9275 266.6885 239.5291 215.1356 193.2263 173.5482 155.8741
    ## [15] 140.0000

``` r
sdg_mmr_proj <- sdg_mmr_allcountries_proj(mmr_est_unrounded_pwider, arr_tibble, 2016, 2030) %>%
  select(-c("bau arr"))
kable(sdg_mmr_proj[1:6, ])
```

|       | name                | iso |   sdg arr |      2016 |      2017 |      2018 |      2019 |      2020 |      2021 |      2022 |       2023 |       2024 |       2025 |       2026 |       2027 |       2028 |       2029 |       2030 |
| ----- | :------------------ | :-- | --------: | --------: | --------: | --------: | --------: | --------: | --------: | --------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: |
| col   | Afghanistan         | AFG | 0.1074065 | 629.75655 | 565.62246 | 508.01975 | 456.28327 | 409.81562 | 368.08020 | 330.59510 | 296.927460 | 266.688517 | 239.529093 | 215.135571 | 193.226272 | 173.548206 | 155.874144 | 140.000000 |
| col.1 | Albania             | ALB | 0.0560323 |  14.15102 |  13.37991 |  12.65082 |  11.96146 |  11.30966 |  10.69338 |  10.11068 |   9.559737 |   9.038814 |   8.546276 |   8.080577 |   7.640255 |   7.223927 |   6.830285 |   6.458093 |
| col.2 | Algeria             | DZA | 0.0560323 | 107.37599 | 101.52492 |  95.99268 |  90.76191 |  85.81616 |  81.13992 |  76.71849 |  72.537988 |  68.585290 |  64.847980 |  61.314321 |  57.973216 |  54.814173 |  51.827271 |  49.003130 |
| col.3 | Angola              | AGO | 0.0560323 | 237.20391 | 224.27833 | 212.05709 | 200.50180 | 189.57617 | 179.24589 | 169.47853 | 160.243403 | 151.511513 | 143.255435 | 135.449242 | 128.068421 | 121.089790 | 114.491435 | 108.252634 |
| col.4 | Antigua and Barbuda | ATG | 0.0560323 |  40.94830 |  38.71696 |  36.60722 |  34.61244 |  32.72636 |  30.94306 |  29.25692 |  27.662673 |  26.155294 |  24.730055 |  23.382479 |  22.108335 |  20.903620 |  19.764552 |  18.687554 |
| col.5 | Argentina           | ARG | 0.0560323 |  39.14660 |  37.01344 |  34.99653 |  33.08952 |  31.28642 |  29.58158 |  27.96964 |  26.445532 |  25.004478 |  23.641948 |  22.353665 |  21.135582 |  19.983874 |  18.894924 |  17.865313 |

#### SDG MMR Regional Summaries

1.  Produces a table of all the projected SDG MMRs by SDG region for a
    specified period.  
2.  Produces a line graph of all the projected SDG MMRs by SDG region.

**Base Equation:** MMR(region) = sum(region\_mmr\_proj \*
region\_total\_births) / sum(region\_total\_births)

**Tests:**  
\- Check inputs (stop if inputs for arguments are not as expected), both
in terms of data type and in terms of if the numerical arguments are
within an acceptable range.  
\- Test to see if correct values are returned (using toy data) based on
base equation in the function.  
\- Check that this function’s call to the two helper functions and
get\_arr\_sdg\_proj (and thus squared\_diff and get\_mmr\_sdg\_proj,, as
well) produces the correct results.

``` r
#Part 1: Table
sdg_regional_proj_summaries <- sdg_mmr_regional_projection_summaries(mmr_est_unrounded_pwider, arr_tibble, countries_and_regions, live_birth_projections2030, 2016, 2030)
knitr::kable(sdg_regional_proj_summaries)
```

| SDG Region                                            |       2016 |      2017 |       2018 |       2019 |       2020 |       2021 |       2022 |       2023 |       2024 |       2025 |       2026 |       2027 |       2028 |       2029 |       2030 |
| :---------------------------------------------------- | ---------: | --------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: |
| Global                                                | 229.452590 | 210.10812 | 192.565454 | 176.642628 | 162.177178 | 149.023954 | 137.053193 | 126.148824 | 116.206947 | 107.134505 |  98.848092 |  91.272900 |  84.341790 |  77.994459 |  72.176707 |
| Australia and New Zealand                             |   6.562204 |   6.20462 |   5.866522 |   5.546847 |   5.244591 |   4.958806 |   4.688593 |   4.433105 |   4.191539 |   3.963136 |   3.747179 |   3.542990 |   3.349928 |   3.167385 |   2.994790 |
| Central Asia and Southern Asia                        | 158.126174 | 148.50211 | 139.505084 | 131.090476 | 123.217165 | 115.847225 | 108.945656 | 102.480135 |  96.420795 |  90.740015 |  85.412242 |  80.413813 |  75.722809 |  71.318906 |  67.183256 |
| Eastern Asia and South-eastern Asia                   |  73.340798 |  69.34435 |  65.565681 |  61.992914 |  58.614832 |  55.420826 |  52.400867 |  49.545469 |  46.845666 |  44.292979 |  41.879392 |  39.597324 |  37.439610 |  35.399472 |  33.470504 |
| Latin America and the Caribbean                       |  72.799933 |  68.52786 |  64.512960 |  60.739280 |  57.191880 |  53.856777 |  50.720887 |  47.771955 |  44.998510 |  42.389805 |  39.935777 |  37.626994 |  35.454622 |  33.410380 |  31.486506 |
| Northern America and Europe                           |  11.858567 |  11.21238 |  10.601398 |  10.023713 |   9.477507 |   8.961064 |   8.472763 |   8.011070 |   7.574535 |   7.161788 |   6.771532 |   6.402542 |   6.053658 |   5.723786 |   5.411888 |
| Oceania / Oceania excluding Australia and New Zealand | 128.745444 | 121.72992 | 115.096685 | 108.824903 | 102.894879 |  97.287991 |  91.986630 |  86.974148 |  82.234803 |  77.753711 |  73.516801 |  69.510766 |  65.723026 |  62.141684 |  58.755496 |
| Sub-Saharan Africa                                    | 515.071694 | 465.94836 | 421.811415 | 382.129313 | 346.429297 | 314.290712 | 285.339099 | 259.240977 | 235.699222 | 214.448984 | 195.254066 | 177.903725 | 162.209832 | 148.004368 | 135.137189 |
| Western Asia and Northern Africa                      |  91.049218 |  86.08782 |  81.396769 |  76.961343 |  72.767610 |  68.802400 |  65.053259 |  61.508415 |  58.156734 |  54.987690 |  51.991333 |  49.158251 |  46.479548 |  43.946812 |  41.552087 |

``` r
#Part 2: Graph
sdg_mmr_regional_global_graph(mmr_est_unrounded_pwider, arr_tibble, countries_and_regions, live_birth_projections2030, 2016, 2030)
```

![](WHO-MMR-MD-5_4_20_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->
