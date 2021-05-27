# Code: DPI ----------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse, readr, dplyr, car, googlesheets4, rvest, Hmisc)

# 2. Scrapp dpi --------------------------------------------------------------
# https://mydata.iadb.org/Reform-Modernization-of-the-State/Database-of-Political-Institutions-2017/938i-s2bw/data
dpi <- readr::read_csv("https://mydata.iadb.org/api/views/938i-s2bw/rows.csv?accessType=DOWNLOAD")
# glimpse(dpi) o str(dpi)

# 3. Recode and rename ---------------------------------------------------------------
## Fijense en como estan codificados NA (999, -999, etc)
dpi <- dpi %>% select(country_name = countryname, year,  elec_sys = system, if_military = military, exec_party = execme,
                      exec_party_or = execrlc, exec_party_rel = execrel, exec_party_maj = allhouse, oppo_party_sen = oppmajs, 
                      oppo_party_h = oppmajh, plural = pluralty, prop = pr, dhondt) %>% 
  mutate_at(vars(if_military, exec_party_rel, exec_party_maj, oppo_party_sen, oppo_party_h,
                 plural, prop, dhondt), funs(car::recode(.,c("'-999' = NA; 0 = 2")))) %>% 
  mutate_at(vars(if_military, exec_party_maj, oppo_party_sen, oppo_party_h,
                 plural, prop, dhondt), funs(factor(.,levels = c(1, 2),
                                                      labels = c('Yes', 'No')))) %>% 
  mutate_at(vars(elec_sys), funs(factor(.,levels = c(0, 1, 2),
                                        labels = c('Presidential',
                                                   'Assembly-elected president', 'Parlamentary')))) %>% 
  mutate_at(vars(elec_sys), funs(car::recode(.,"'-999' = NA"))) %>% 
  mutate_at(vars(exec_party_rel), funs(factor(.,levels = c(0, 1, 2, 3, 4, 5, 6),
                                                    labels = c('Otherwise', 'Christian','Catholic',
                                                               'Islamic', 'Hindu', 'Buddhist', 'Jewish')))) %>% 
  mutate_at(vars(exec_party_or), funs(factor(.,levels = c(0, 1, 2, 3),
                                              labels = c('No information or category',
                                                         'Right', 'Center', 'Left'))))

# 5. ISO3C ----------------------------------------------------------------
data_dpi <- dpi %>% 
  mutate(iso3c = countrycode(country_name, "country.name", "iso3c")) %>% 
  select(iso3c, everything(), -country_name)

# 6. Label -------------------------------------------------------------------
# Llamar etiquetas (en slice se indican los tramos)
labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                                      range = c("B5:C324"), col_names = F) %>%
  select(variables = 1, etiquetas = 2) %>% 
  filter(grepl("_dpi|year|iso3c", variables))

## Tranformar a vectornames
var.labels <- as.character(labels$etiquetas)
names(var.labels) <- labels$variables

## Etiquetar
Hmisc::label(data_dpi) = as.list(var.labels[match(names(data_dpi), names(data_dpi))])


# 7. Save -----------------------------------------------------------------
rm(list = ls(pattern = "s"))
saveRDS(data_dpi, file="output/data/proc/dpi.rds")

