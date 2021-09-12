# Code: ILOEPLX --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse,rvest, car, readxl,Hmisc, countrycode)

# 2. Scrapping variables ------------------------------------------------------------

# 2.1 Fixed-term contracts (FTCs) 

ftc <- read_html('https://eplex.ilo.org/fixed-term-contracts-ftcs/') %>% 
  html_node('.table') %>% 
  html_table() %>% 
  select(year = "Year(s)", country_name = 3,
         ftc_reg = 7, ftc_valid = 10, ftc_max_nocum = 13, ftc_max = 16)


# 2.2 Legal Coverage ----------------------------------------

lc <- read_html('https://eplex.ilo.org/legal-coverage/') %>%
  html_node('.table#employment-protection-table') %>%
  html_table()%>% 
  select(year = 'Year(s)', country_name = 3, 
                lc_mine = 52, lc_bcollar = 13, lc_civilser = 19,
                lc_domestic = 22, lc_dockers = 79, lc_managerial = 61,
                lc_agric = 31, lc_teachers = 70)

# 2.3 Wrokers Enjoying Special Protection Against Dismissal ---------------------------------------------------------------------

spd <- read_html('https://eplex.ilo.org/workers-enjoying-special-protection-against-dismissal/') %>% 
  html_node('.table') %>% 
  html_table() %>% 
  select(year = "Year(s)", country_name = 2,
         spd_pregnant = 5, spd_familyresp = 8, 
         spd_older = 17, spd_wrep = 11,
         spd_disab=20, spd_occ_dis=26, 
         spd_longperiod=38)

# 2.4 Valid Grounds for Dismissal ----------------------------------------------------------------------

vd <- read_html('https://eplex.ilo.org/valid-and-prohibited-grounds-for-dismissal/') %>% 
  html_node('.table') %>% 
  html_table() %>%
  select(year = "Year(s)", country_name = 2,
         vd_conduct = 11, vd_capacity = 14, vd_economic = 17)

# 2.5 Prohibited Grounds for Dismissal  ----------------------------------------------------------------------

pd <- read_html('https://eplex.ilo.org/valid-and-prohibited-grounds-for-dismissal/') %>%
  html_nodes('.table')  %>% 
  html_table()
pd <- pd[[2]] %>% 
  select(year = "Year(s)", country_name = 3,
         pd_tum = 44, pd_strike = 31, pd_pol_op = 28, pd_pregnant = 27,
         pd_disab = 16, pd_complain = 15)

# 3. Recode and rename---------------------------------------------------------------
##Instrucciones: Similar a ocde02

##FTCs

ftc$ftc_max_nocum <- car::recode(ftc$ftc_max_nocum, c("'no limitation' = 0; 
                                               'no limitation on first FTC' = 1; 
                                               'objective and material reasons' = 2")) %>%  
                                         factor(ftc$ftc_max_nocum, levels = c(0:2), labels = 
                                                                      c('No limitation',
                                                                     'No limitation on first FTC',
                                                                     'Objective and material reasons')) 

ftc$ftc_valid <- car::recode(ftc$ftc_valid, c("'no limitation' = 0; 
                                               'no limitation on first FTC' = 1; 
                                               'objective and material reasons' = 2")) %>%  
  factor(ftc$ftc_valid, levels = c(0:2), labels = 
           c('No limitation',
             'No limitation on first FTC',
             'Objective and material reasons')) 

ftc$ftc_reg <-  recode(ftc$ftc_reg, "'Y'=1; 'N'=2") 
ftc$ftc_reg <-  factor(ftc$ftc_reg, 
                labels = c("Yes", "No"))

ftc$ftc_max <- recode(ftc$ftc_max, "'no limitation'=0")

ftc$year <- as.numeric(ftc$year)

##Legal coverage
 
lc <- lc %>% mutate_at(vars(starts_with("lc")), 
                        funs(car::recode(., c("'Y' = 'Yes'; '' = 'No'"),
                                         as.factor = T, levels = c('Yes', 'No')))) %>% 
                        mutate(year = as.numeric(year))

##Special protection dismissal

spd <- spd %>% mutate_at(vars(starts_with("spd")), 
                         funs(car::recode(., c("'Y' = 'Yes'; 'N' = 'No'"),
                                          as.factor = T, levels = c('Yes', 'No')))) %>% 
                         mutate(year = as.numeric(year))


##Valid grounds for dismissal

vd <- vd %>% mutate_at(vars(starts_with("vd")), 
                         funs(car::recode(., c("'Y' = 'Yes'; 'N' = 'No'"),
                                          as.factor = T, levels = c('Yes', 'No')))) %>% 
                         mutate(year = as.numeric(year))

## Prohibited grounds for dismissal

pd <- pd %>% mutate_at(vars(starts_with("pd")), 
                       funs(car::recode(., c("'Y' = 'Yes'; '' = 'No'"), 
                                        as.factor = T, levels = c('Yes','No')))) %>%
             mutate(year = as.numeric(year))
 

## recode country_name https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2


# 4. Merge al data --------------------------------------------------------

iloeplex <- Reduce(function(x,y) merge(x = x, y = y, by = c("country_name", "year"),
                                   all = T),
               list(ftc,lc,spd,vd,pd))

# 5. ISO3C ----------------------------------------------------------------

iloeplex <- iloeplex %>% 
  mutate(iso3c = countrycode(country_name, "country.name", "iso3c")) %>% 
  select(iso3c, everything(), -country_name) %>% filter(!is.na(iso3c))


# 6. Label ----------------------------------------------------------------
# Llamar etiquetas (en slice se indican los tramos)

labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                                    range = c("B2:C900"), col_names = F) %>%
  select(variables = 1, etiquetas = 2) %>% 
  filter(grepl("_eplex|year|iso3c", variables))


## Tranformar a vectornames

var.labels <- as.character(labels$etiquetas)
names(var.labels) <- labels$variables

## Etiquetar

label(iloeplex) = as.list(var.labels[match(names(iloeplex), names(iloeplex))])

# 7. Save -----------------------------------------------------------------
rm(list = ls(pattern = "s|v|f|d|c"))#remover lo que no sirve
saveRDS(iloeplex, file="output/data/proc/iloeplex.rds")
