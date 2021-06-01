# Code 4 : World Value Survey ---------------------------------------------------------------

# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse,rvest, Hmisc, countrycode, survey, srvyr)

# 2. Read rds WVS ---------------------------------------------------------
wvs <- readRDS("input/data/wvs/WVS_TimeSeries_R_v1_6.rds")

# 3. Select variables -----------------------------------------------------
wvs_dat <- wvs %>%  select(id = "S007", iso1c = "S003", year = "S020",
                tu ="E069_05",um = "A067", um_a = "A101", weight_eq = "S018") %>%
# 4. Mutate ---------------------------------------------------------------
  mutate(tu = car::recode(.$tu, c("1='A great deal';2='Quite a lot';3='Not very much';4='None at all'"), as.factor = T,
                            levels = c('A great deal','Quite a lot','Not very much','None at all')),
         um = car::recode(.$um, c("0='Not a member';1='Member'"), as.factor = T,
                         levels = c('Not a member','Member')),
         um_a = car::recode(.$um_a, c("0='Not a member'; 1='Inactive member'; 2='Active member'"), as.factor = T,
                            levels = c('Not a member', 'Inactive member', 'Active member')),
         iso3c = countrycode(iso1c, "wvs", "iso3c")) %>% 
  select(iso3c, everything(), -iso1c)

# 5. Group ----------------------------------------------------------------
lc <- wvs_dat %>%
  pivot_longer(cols = contains("u"), names_to = "variable", values_to = "value") %>%
  filter(!is.na(value)) %>% 
  as_survey_design(ids = 1, weights = weight_eq) %>%
  group_by(iso3c, year, variable, value) %>% 
  summarise(prop = survey_mean(vartype = "ci",na.rm = TRUE),
            total = survey_total(vartype = "ci",na.rm = TRUE))

