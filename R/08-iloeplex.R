# Code: ILOEPLX --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(Rilostat, tidyverse,rvest, car)

# 2. Scrapping variables ------------------------------------------------------------
ftc <- read_html('https://eplex.ilo.org/fixed-term-contracts-ftcs/') %>% 
  html_node('.table') %>% 
  html_table() %>% 
  select(year = "Year(s)", country_name = 3,
         ftc_reg = 7, ftc_valid = 10, ftc_max_nocum = 13, ftc_max = 16)

## repetir proceso

# 3. Recode and rename---------------------------------------------------------------
##Instrucciones: Similar a ocde02

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
