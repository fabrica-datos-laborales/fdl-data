# Code 1: Process ICTWSS ---------------------------------------------------------

# 1. Load packages  -------------------------------------------------------
pacman::p_load(tidyverse, haven, rvest, countrycode, Hmisc)

# 2. Load data base -------------------------------------------------------
ictwss <- haven::read_dta(url("https://aias.s3.eu-central-1.amazonaws.com/website/uploads/ICTWSS_v6_1_Stata_release.dta"))

# 3. ISO3C ----------------------------------------------------------------
ictwss <- ictwss %>%
  mutate(iso2c = case_when(iso2c == "UK" ~ "GB", TRUE ~ iso2c)) %>% 
  mutate(iso3c = countrycode(iso2c, "iso2c", "iso3c")) %>% 
  select(iso3c, everything())

# 4. Label ----------------------------------------------------------------
label(ictwss$iso3c) <- "Country code ISO3"
label(ictwss$year) <- "Year"

# 5. Save ----------------------------------------------------------------------
saveRDS(ictwss, file="output/data/proc/ictwss.rds")

