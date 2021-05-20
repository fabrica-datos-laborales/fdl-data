# Code: ILOEPLX --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(Rilostat, tidyverse,rvest, car)
#
# 2. Scrapping variables ------------------------------------------------------------
ftc <- read_html('https://eplex.ilo.org/fixed-term-contracts-ftcs/') %>% 
  html_node('.table') %>% 
  html_table() %>% 
  select(year = "Year(s)", country_name = 3,
         ftc_reg = 7, ftc_valid = 10, ftc_max_nocum = 13, ftc_max = 16)

lc <- read_html('https://eplex.ilo.org/legal-coverage/') %>% 
  html_node('.table') %>% 
  # html_table() %>% 
  # select(year = "Year(s)", country_name = 3,
  #        ftc_reg = 7, ftc_valid = 10, ftc_max_nocum = 13, ftc_max = 16) 

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
         ftc_reg = 7, ftc_valid = 10, ftc_max_nocum = 13, ftc_max = 16)

# pd <- read_html('https://eplex.ilo.org/valid-and-prohibited-grounds-for-dismissal/') %>% 
#   html_node('.table,2') %>%  
#   html_table() %>% 
#   select(year = "Year(s)", country_name = 3,
#          ftc_reg = 7, ftc_valid = 10, ftc_max_nocum = 13, ftc_max = 16)


## repetir proceso

# 3. Recode and rename---------------------------------------------------------------
##Instrucciones: Similar a ocde02

##FTCs
ftc$ftc_reg <-  recode(ftc$ftc_reg, "c('Y')=1; c('N')=2") 
ftc$ftc_reg <-  factor(ftc$ftc_reg, 
                labels = c("Yes", "No"))

ftc$ftc_valid <- recode(ftc$ftc_valid, "'no limitation'=0; 
                        'no limitation on first FTC'=1; 
                        'objective and material reasons' = 2")

ftc$ftc_valid <- factor(ftc$ftc_valid,
                        labels=c('No limitation', 'No limitation on first FTC',
                                 'Objective and material reasons'))

ftc$ftc_max_nocum <- recode(ftc$ftc_max_nocum, "'no limitation'=0; 
                        'no limitation on first FTC'=1; 
                        'objective and material reasons' = 2")

ftc$ftc_max_nocum <- factor(ftc$ftc_max_nocum,
                        labels=c('No limitation', 'No limitation on first FTC',
                                 'Objective and material reasons'))


ftc$ftc_max <- recode(ftc$ftc_max, "'no limitation'=0")

##Legal coverage
 
##Special protection dismissal
spd$spd_pregnant <-  recode(spd$spd_pregnant, "c('Y')=1; c('N')=2") 
spd$spd_pregnant <-  factor(spd$spd_pregnant, 
                       labels = c("Yes", "No"))

spd$spd_familyresp <-  recode(spd$spd_familyresp, "c('Y')=1; c('N')=2")
spd$spd_familyresp <-  factor(spd$spd_familyresp, 
                       labels = c("Yes", "No"))

spd$spd_older <-  recode(spd$spd_older, "c('Y')=1; c('N')=2")
spd$spd_older <-  factor(spd$spd_older, 
                       labels = c("Yes", "No"))

spd$spd_wrep <-  recode(spd$spd_wrep, "c('Y')=1; c('N')=2")
spd$spd_wrep <-  factor(spd$spd_wrep, 
                       labels = c("Yes", "No"))

spd$spd_disab <-  recode(spd$spd_disab, "c('Y')=1; c('N')=2")
spd$spd_disab <-  factor(spd$spd_disab, 
                       labels = c("Yes", "No"))

spd$spd_familyresp <-  recode(spd$spd_familyresp, "c('Y')=1; c('N')=2")
spd$spd_familyresp <-  factor(spd$spd_familyresp, 
                       labels = c("Yes", "No"))

spd$spd_longperiod <-  recode(spd$spd_longperiod, "c('Y')=1; c('N')=2")
spd$spd_longperiod <-  factor(spd$spd_longperiod, 
                       labels = c("Yes", "No"))

spd$spd_occ_dis <-  recode(spd$spd_occ_dis, "c('Y')=1; c('N')=2")
spd$spd_occ_dis <-  factor(spd$spd_occ_dis, 
                              labels = c("Yes", "No"))


##Valid grounds for dismissal

## Prohibited grounds for dismissal

# %>%
#   mutate_at(vars(fct_valid,fct_max_nocum), funs(as_factor(.))))

## recode country_name https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2


# 4. Merge ----------------------------------------------------------------

## Merge all EPLEx------------------------------------
data_ilo <- lapply(ls(),get)
data_ilo <- Reduce(function(x,y) merge (x, y, by = c("country_name", "year")))

## Merge and scrap with iso ----------------------------
iso <- read_html('https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2') %>% 
  html_node('.wikitable.sortable') %>% 
  html_table() %>%
  group_by(Code) %>% 
  filter(Year == max(Year)) %>% 
  select(iso2c=Code, country_name = "Country name (using title case)")

data_iloeplx <- merge(data_ilo, iso,
                  by = "country_name")

# 5. Label ----------------------------------------------------------------

# 6. Select ------------------------------------------------------

# 8. Save -----------------------------------------------------------------
