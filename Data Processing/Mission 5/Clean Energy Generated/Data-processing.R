library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)
library(here)


df1 <- statcan_download_data("25-10-0015-01", "eng")
df2 <- statcan_download_data("25-10-0016-01", "eng")

df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)
df1$Month <- month(df1$DATE)

max <- df1 |>
  filter (Year == max(Year)) |>
  group_by(Year) |>
  summarise(max = max(Month))

df2$DATE <- ymd(df2$REF_DATE)
df2$Year <- year(df2$DATE)
df2$Month <- month(df2$DATE)

df1 <- df1 |> select(DATE, Year, Month, GEO, `Class of electricity producer`,
                     `Type of electricity generation`, UOM, VALUE )
df2 <- df2 |> select(DATE, Year, Month, GEO, `Electric power, components`, VALUE)

df1_1 <- df1 |> 
  group_by(Year, GEO, `Class of electricity producer`, `Type of electricity generation`, UOM) |>
  summarise(VALUE = sum(VALUE)) |>
  mutate (lastmonth = max$max)


# df2_1 <- df2 |>
#   group_by(Year, GEO, `Electric power, components`) |>
#   summarise(VALUE = sum(VALUE))

write.csv(df1_1, here("Data", "Clean_Energy_Generated_1.csv"), row.names = FALSE)
write.csv(df2, here("Data", "Clean_Energy_Generated_2.csv"), row.names = FALSE)
