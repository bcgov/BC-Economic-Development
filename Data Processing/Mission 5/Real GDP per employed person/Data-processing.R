library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)
library(here)


df1 <- statcan_download_data("36-10-0222-01", "eng")
df2 <- statcan_download_data("14-10-0023-01", "eng")



df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)
df1 <- df1 |>
  filter(
    Prices == "Chained (2017) dollars",
    Estimates == "Gross domestic product at market prices",
    Year >= 2000
  ) |>
  rename(GDP = VALUE) |>
  select(Year, GEO, GDP) 
  
df2$DATE <- ymd(df2$REF_DATE)
df2$Year <- year(df2$DATE)
df2 <- df2 |>
  filter(
    `Labour force characteristics` == "Employment",
    `North American Industry Classification System (NAICS)` == "Total, all industries", 
    Sex == "Both sexes",
    `Age group` == "15 years and over",
    Year >= 2000
  ) |>
  rename(Employment = VALUE) |>
  select(Year, GEO, Employment)


merged_df <- merge(df1, df2, by = c("Year", "GEO"))

merged_df <- merged_df |> 
  mutate(GDPE = GDP / Employment)

write.csv(merged_df, here("Data", "Real_GDP_per_Employment_1.csv"), row.names = FALSE)
