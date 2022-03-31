
# Temporal and regional coverage ------------------------------------------

rm(list = ls())
# Install packages --------------------------------------------------------
pacman::p_load(tidyverse, writexl)

# Import data -------------------------------------------------------------
ictwss <- readRDS("output/data/proc/ictwss.rds")
ocde <- readRDS("output/data/proc/oecd.rds")
wdi <- readRDS("output/data/proc/wdi.rds")
wvs <- readRDS("output/data/proc/wvs.rds")
issp <- readRDS("output/data/proc/issp.rds")
dpi <- readRDS("output/data/proc/dpi.rds")
eplex <- readRDS("output/data/proc/iloeplex.rds")
ilostat <- readRDS("output/data/proc/ilo-stat.rds")
vdem <- readRDS("output/data/proc/vdem.rds")
latino <- readRDS("output/data/proc/latino.rds")
euro <- readRDS("output/data/proc/euro.rds")


# merge -------------------------------------------------------------------

fdl <- list(ictwss, ocde, wdi, wvs, issp, dpi, eplex, ilostat, vdem, latino, euro) %>% 
  Reduce(function(x,y) merge(x,y, by = c("iso3c", "year"), all = T), . ) 
             

# Pivot longer ------------------------------------------------------------

fdl <- fdl %>% 
  mutate_all(~(as.character(.))) %>% 
  pivot_longer(cols = c(3:786),
                    names_to = "vars",
                    values_to = "valores") %>% 
  group_by(vars) %>% 
  mutate(temporal = paste0(min(.$year), "-", max(.$year)),
         regional = sum(iso3c)) %>% 
  ungroup() %>% 
  select(vars, temporal, regional)

# Create coverage table ---------------------------------------------------

writexl::write_xlsx(fdl, "output/data/coverage.xlsx")

