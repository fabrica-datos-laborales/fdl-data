# Code: ILOEPLX --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse,rvest, car, readxl, janitor)
#
# 2. Scrapping variables ------------------------------------------------------------
ftc <- read_html('https://eplex.ilo.org/fixed-term-contracts-ftcs/') %>% 
  html_node('.table') %>% 
  html_table() %>% 
  select(year = "Year(s)", country_name = 3,
         ftc_reg = 7, ftc_valid = 10, ftc_max_nocum = 13, ftc_max = 16)

#Legal Coverage: por mientras
lc <- read_excel("C:/Users/nicol/OneDrive/Documentos/GitHub/fdl-data/input/data/ILO-EPLex Legal Coverage.xlsx")

lc <- lc %>%
  row_to_names(row_number = 1) %>%
  select(year = 'Year(s)', country_name = 'Country', lc_bcollar = `blue-collar workers`, lc_civilser = `civil/public servants`,
         lc_domestic = `domestic workers`, lc_coopmembers = `members of cooperatives`,
         lc_managerial = `managerial / executive positions`, lc_admin = `administrative body`)
  
  # lc <- read_html('https://eplex.ilo.org/legal-coverage/') %>% 
#   html_node('.table') %>% 
#   html_table() %>% 
  # select(year = "Year(s)", country_name = 3,
  #        ftc_reg = 7, ftc_valid = 10, ftc_max_nocum = 13, ftc_max = 16) 

## AVISAR LO DE LOS NUMEROS
  
spd <- read_html('https://eplex.ilo.org/workers-enjoying-special-protection-against-dismissal/') %>% 
  html_node('.table') %>% 
  html_table() %>% 
  select(year = "Year(s)", country_name = 3,
         spd_pregnant = 5, spd_familyresp = 8, 
         spd_older = 17, spd_wrep = 11,
         spd_disab=20, spd_occ_dis=26, 
         spd_longperiod=38)

vd <- read_html('https://eplex.ilo.org/valid-and-prohibited-grounds-for-dismissal/') %>% 
  html_node('.table') %>% 
  html_table() %>%
  select(year = "Year(s)", country_name = 3,
         vd_conduct = 11, vd_capacity = 14, vd_economic = 17)
#Ojo

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

ftc <- ftc %>% mutate_at(vars(ends_with("valid")|ends_with("nocum")), 
                         funs(car::recode(., c("'no limitation' = 0; 'no limitation on first FTC' = 1; 
                                               'objective and material reasons' = 2")))) %>% 
               mutate_at(vars(ends_with("valid")|ends_with("nocum")), 
                         funs(factor(., levels = c(0, 1, 2), 
                                     labels = c('No limitation', 'No limitation on first FTC', 
                                     'Objective and material reasons'))))

ftc$ftc_reg <-  recode(ftc$ftc_reg, "'Y'=1; 'N'=2") 
ftc$ftc_reg <-  factor(ftc$ftc_reg, 
                labels = c("Y", "N"))

ftc$ftc_max <- recode(ftc$ftc_max, "'no limitation'=0")

##Legal coverage
 
lc <- lc %>% mutate_at(vars(starts_with("lc")), 
                        funs(car::recode(., c("'Y' = 1; 'N' = 2")))) %>% 
             mutate_at(vars(starts_with("lc")),
             funs(factor(., levels = c(1, 2),
                        labels = c('Y', 'N'))))

##Special protection dismissal

spd <- spd %>% mutate_at(vars(starts_with("spd")), 
                         funs(car::recode(., c("'Y' = 1; 'N' = 2")))) %>% 
               mutate_at(vars(starts_with("spd")),
                         funs(factor(., levels = c(1, 2),
                                     labels = c('Y', 'N'))))


##Valid grounds for dismissal

vd <- vd %>% mutate_at(vars(starts_with("vd")), 
                         funs(car::recode(., c("'Y' = 1; 'N' = 2")))) %>% 
             mutate_at(vars(starts_with("vd")),
                         funs(factor(., levels = c(1, 2),
                                     labels = c('Y', 'N'))))

## Prohibited grounds for dismissal

pd <- pd %>% mutate_at(vars(starts_with("pd")), 
                       funs(car::recode(., c("'Y' = 1; 'N' = 2")))) %>% 
  mutate_at(vars(starts_with("pd")),
            funs(factor(., levels = c(1, 2),
                        labels = c('Y', 'N'))))


## recode country_name https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2


# 4. Merge al data --------------------------------------------------------
iloeplex <- Reduce(function(x,y) merge(x = x, y = y, by = c("year", "country_name"),
                                   all = T),
               list(vd, spd, pd, lc, ftc))


# 6. Label ----------------------------------------------------------------
# Llamar etiquetas (en slice se indican los tramos)
labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                                    range = c("B2:C352"), col_names = F) %>%
  slice(c(1,5,326:351)) %>% # selecciono 1, 2, donde parte -5, donde termina -5
  select(variables = 1, etiquetas = 2)
## Tranformar a vectornames
var.labels <- as.character(labels$etiquetas)
names(var.labels) <- labels$variables
## Etiquetar
label(iloeplex) = as.list(var.labels[match(names(iloeplex), names(iloeplex))])

# 7. Save -----------------------------------------------------------------
rm(list = ls(pattern = "wl|b|p|h"))#remover lo que no sirve
saveRDS(iloeplex, file="output/data/proc/iloeplex.rds")
