# Code: VDEM ----------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse, readr, Hmisc, vdemdata)

# 2. Scrapp vdem --------------------------------------------------------------
vdemdata::find_var("polyarchy")
vdem <- vdemdata::vdem
#vparty <- vdemdata::vparty
labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                                  range = c("A755:C810"), col_names = F) %>% 
  select(variables_original = 1, variables = 2, etiquetas = 3)

# 4. Select ------------------------------------------------------------------
variable_original <- as.vector(labels$variables_original)

vdem <- vdem %>% select(iso3c=country_text_id, year,variable_original)
# 5. Recode -----------------------------------------------------------------
vdem <- vdem %>% 
  mutate_at(vars(v2elcomvot:v2x_regime,e_boix_regime), funs(as_factor(.))) %>% 
  mutate(e_boix_regime = car::recode(e_boix_regime, c("0='No';1='Yes'"), as.factor = T,
                                     levels = c("Yes", "No")))
# 6. Label ----------------------------------------------------------------
# Llamar etiquetas (en slice se indican los tramos)
## Tranformar a vectornames
var.labels <- as.character(labels$etiquetas)
var.labels <- c("Country code ISO3", "Year", var.labels)
names(var.labels) <- labels$variables
## Etiquetar
label(vdem) = as.list(var.labels[match(names(vdem), names(vdem))])

# 7. Save -----------------------------------------------------------------
saveRDS(vdem, file="output/data/proc/vdem.rds")

