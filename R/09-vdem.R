# Code: VDEM ----------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse, readr, Hmisc, devtools, vdemdata)
#devtools::install_github("vdeminstitute/vdemdata")

# 2. Scrapp vdem --------------------------------------------------------------
vdemdata::find_var("polyarchy")
vdem <- vdemdata::vdem
#vparty <- vdemdata::vparty
labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                                  range = c("A5:C810"), sheet = "Variables", col_names = F) %>% 
  select(variables_original = 1, variables = 2, etiquetas = 3) %>% 
  filter(grepl("_vdem", variables)| variables %in% c("iso3c", "year")) %>% 
  mutate(variables_original = ifelse(is.na(variables_original) & variables == "year", "year",
                                     ifelse(is.na(variables_original) & variables == "iso3c", "iso3c",
                                            variables_original)))



# 4. Select ------------------------------------------------------------------
variable_original <- as.vector(labels$variables_original)

vdem <- vdem %>%
  select(iso3c = country_text_id, year,variable_original)

# 5. Recode -----------------------------------------------------------------
vdem$e_boix_regime <- car::recode(vdem$e_boix_regime, recodes = c("0='No';1='Yes'"), as.factor = T,
                                     levels = c("No", "Yes"))

vdem$v2elcomvot <- car::recode(vdem$v2elcomvot, recodes = c("1 = 'Yes. But there are no sanctions or sanctions are not enforced';
                                                       2 = 'Yes. Sanctions exist and are enforced, but they impose minimal costs upon the offending voter';
                                                       3 = 'Yes. Sanctions exist, they are enforced, and they impose considerable costs upon the offending voter'"),
                                     as.factor = T, levels = c('Yes. But there are no sanctions or sanctions are not enforced',
                                                               'Yes. Sanctions exist and are enforced, but they impose minimal costs upon the offending voter',
                                                               'Yes. Sanctions exist, they are enforced, and they impose considerable costs upon the offending voter')) 

vdem$v2elfemrst <-  car::recode(vdem$v2elfemrst, recodes = c("0 = 'No female suffrage';
                                               1 = 'Restricted female suffrage';
                                               2 = 'Universal female suffrage'"), as.factor = T,
                                 levels = c("No female suffrage", "Restricted female suffrage", "Universal female suffrage")) 

vdem$v3peminwage <- car::recode(vdem$v3peminwage, recodes = c("0 = 'No';
                                                 1 = 'Yes, the state imposes a minimum wage';
                                                 2 = 'Yes, there are corporate bargaining arrangements that effectively ensure a minimum wage';
                                                 3 = 'Yes, there is a tripartite committee that sets the wage'"),
                                  as.factor = T, levels = c('No', 'Yes, the state imposes a minimum wage',
                                                            'Yes, there are corporate bargaining arrangements that effectively ensure a minimum wage',
                                                            'Yes, there is a tripartite committee that sets the wage')) 

vdem$v2x_regime <- car::recode(vdem$v2x_regime, recodes = c("0 = 'Closed autocracy';
                                               1 = 'Electoral autocracy';
                                               2 = 'Electoral democracy';
                                               3 = 'Liberal democracy'"),
                                 as.factor = T, levels = c('Closed autocracy',
                                                           'Electoral autocracy',
                                                           'Electoral democracy',
                                                           'Liberal democracy')) 
  


# 6. Rename ---------------------------------------------------------------

names(vdem) <- ifelse(match(labels$variables_original, names(x)), labels$variables, NA)

# 7. Label ----------------------------------------------------------------

labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                                    sheet = 'Variables', range = c("B2:C900"), col_names = F) %>%
  select(variables = 1, etiquetas = 2) %>% 
  filter(grepl("_vdem|year|iso3c", variables))

## Tranformar a vectornames
var.labels <- as.character(labels$etiquetas)
names(var.labels) <- labels$variables
## Etiquetar
label(vdem) = as.list(var.labels[match(names(vdem), names(vdem))])

# 7. Save -----------------------------------------------------------------
saveRDS(vdem, file="output/data/proc/vdem.rds")

