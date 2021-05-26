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
  mutate_at(vars(exec_party_rel), funs(factor(.,levels = c(0, 1, 2, 3, 4, 5, 6),
                                                    labels = c('Otherwise', 'Christian','Catholic',
                                                               'Islamic', 'Hindu', 'Buddhist', 'Jewish')))) %>% 
  mutate_at(vars(exec_party_or), funs(factor(.,levels = c(0, 1, 2, 3),
                                              labels = c('No information or category',
                                                         'Right', 'Center', 'Left'))))



# 4. Merge -----------------------------------------------------------------

## Merge and scrap with iso ----------------------------
iso <- read_html('https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2') %>% 
  html_node('.wikitable.sortable') %>% 
  html_table() %>%
  group_by(Code) %>% 
  filter(Year == max(Year)) %>% 
  select(iso2c=Code, country_name = "Country name (using title case)") 

data_dpi <- merge(dpi, iso,
                      by = "country_name") %>% 
  select(iso2c, everything(), -country_name)
#SCRAPPING NOMBRES

#5. Label -------------------------------------------------------------------

# Llamar etiquetas (en slice se indican los tramos)
labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                                      range = c("B4:C324"), col_names = F) %>%
  slice(c(1,3,311:321)) %>% # selecciono 1, 2, donde parte -5, donde termina -5
  select(variables = 1, etiquetas = 2)
## Tranformar a vectornames
var.labels <- as.character(labels$etiquetas)
names(var.labels) <- labels$variables

## Etiquetar
label(data_dpi) = as.list(var.labels[match(names(data_dpi), names(data_dpi))])

# 7. Save -----------------------------------------------------------------
rm(list = ls(pattern = "s"))#remover lo que no sirve
saveRDS(data_dpi, file="output/data/proc/dpi.rds")

