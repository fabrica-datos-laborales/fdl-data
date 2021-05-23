# Code: ILOEPLX --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse,rvest, car)
#
# 2. Scrapping variables ------------------------------------------------------------
ftc <- read_html('https://eplex.ilo.org/fixed-term-contracts-ftcs/') %>% 
  html_node('.table') %>% 
  html_table() %>% 
  select(year = "Year(s)", country_name = 3,
         ftc_reg = 7, ftc_valid = 10, ftc_max_nocum = 13, ftc_max = 16)

lc <- read_html('https://eplex.ilo.org/legal-coverage/') %>% 
  html_node('.table') #%>% 
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
