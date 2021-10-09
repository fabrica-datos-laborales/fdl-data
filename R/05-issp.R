# Code 5 : ISSP ---------------------------------------------------------------

# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse,rvest, Hmisc, countrycode, survey, srvyr, Hmisc)

# 2. Load data ------------------------------------------------------------
## File names

file_names=as.list(dir(path ="input/data/issp/", pattern="*.dta"))

file_names = lapply(file_names, function(x) paste0('input/data/issp/', x))

## List of data frames
r <- lapply(file_names, haven::read_dta)

# 2. Proc -----------------------------------------------------------------
names(r) <- gsub("input/data/issp/ZA|1680-|1840-|2310-|3090-|3430-|4350_v2-0-0-|5400_v4-0-0-|6770_v2-1-0-|.dta","", file_names)

r <- Map(function(x, y) {names(x) <- paste0(names(x), '_',  y); x}, r, names(r))

list_issp <- r

rm(list = ls(pattern = "r|file_names"))

# 3. Unlist ---------------------------------------------------------------
list2env(list_issp, .GlobalEnv)

# 4. Merge and recode d.f -----------------------------------------------------------
issp <- bind_rows(list(
# 1987 - SI ----------------------------------------------------------
(`1987` %>% 
  select(iso3c = v3_1987, ess = v65_1987, weight = v107_1987) %>% 
  mutate_all(., ~as.numeric(.)) %>% 
  mutate(iso3c = car::recode(.$iso3c, c("1='AUS';2='DEU';3='GBR';4='USA';5='AUT';
                                          6='HUN';7='NLD';8='ITA';11='CHE';12='POL'")),
         ess = car::recode(.$ess,c("c(97,98,99)=NA")),
         year = 1987)),
# 1989 - WO ---------------------------------------------------------------
(`1989` %>%
  mutate_all(., ~as.numeric(.)) %>% 
  select(iso3c = v3_1989, class = v110_1989, conflict = v22_1989, weight = v136_1989) %>% 
  mutate(iso3c = car::recode(.$iso3c, c("1='AUS';2='DEU';3='GBR';4='USA';5='AUT';
                                          6='HUN';7='NLD';8='ITA';c(9,10)='IRL';11='NOR';12='ISR'")),
         class = car::recode(.$class,c("1='Lower class';2='Working class';
                                   4='Middle class';5='Upper middle class'; 6='Upper class'; c(3,8,9)=NA"), as.factor = T,
                             levels = c("Lower class", "Working class", "Middle class", "Upper middle class", "Upper class")),
         conflict = car::recode(.$conflict,c("c(1,2)='Very Strong and strong conflicts';c(3,4,5)='Not very and no conflicts'; c(8,9)=NA"), as.factor = T,
                                levels = c("Very Strong and strong conflicts", "Not very and no conflicts")),
         year =1989)),
# 1992 - SI ---------------------------------------------------------------
(`1992` %>% mutate_all(., ~as.numeric(.)) %>% 
  select(iso3c = v3_1992, ess = v73_1992, class= v125_1992, conflict = v70_1992, weight = v176_1992) %>% 
  mutate(iso3c = car::recode(.$iso3c, c("1='AUS';c(2,3)='DEU';4='GBR';5='USA';6='AUT';
                                          7='HUN';8='ITA';9='NOR';10='SWE';11='CSK';12='SLO';
                                          13='POL';14='BGR';15='RUS';16='NZL';17='CAN';18='PHL'")),
         ess = car::recode(.$ess,c("c(97,98,99)=NA")),
         class = car::recode(.$class,c("1='Lower class';c(2,3)='Working class';
                                   4='Middle class';5='Upper middle class'; 6='Upper class'; c(0,8,9)=NA"), as.factor = T,
                             levels = c("Lower class", "Working class", "Middle class", "Upper middle class", "Upper class")),
         conflict = car::recode(.$conflict,c("c(1,2)='Very Strong and strong conflicts';c(3,4,5)='Not very and no conflicts'; c(8,9)=NA"), as.factor = T,
                                levels = c("Very Strong and strong conflicts", "Not very and no conflicts")),
         year = 1992)),
# 1997 - WO ---------------------------------------------------------------
(`1997` %>% mutate_all(., ~as.numeric(.))  %>% 
  select(iso3c = v3_1997, class =class_1997, conflict = v52_1997, weight = weight_1997) %>% 
  mutate(iso3c = car::recode(.$iso3c, c("1='AUS';c(2,3)='DEU';4='GBR';6='USA';
                                          8='HUN';9='ITA';11='NLD';12='NOR';13='SWE';14='CSK';15='SLO';
                                          16='POL';17='BGR';18='RUS';19='NZL';20='CAN';21='PHI';
                                          c(22,23)='ISR';24='JPN';25='ESP';27='FRA';28='CYP';
                                          29='PRT';30='DNK';31='CHE';32='BGD'")),
         class = car::recode(.$class,c("1='Lower class';2='Working class';
                                   c(3,4)='Middle class';5='Upper middle class'; 6='Upper class'; c(3,8,9)=NA"), as.factor = T,
                             levels = c("Lower class", "Working class", "Middle class", "Upper middle class", "Upper class")),
         conflict = car::recode(.$conflict,c("c(5,4)='Very Strong and strong conflicts';c(3,1,2)='Not very and no conflicts'; c(7,8,9)=NA"), as.factor = T,
                                levels = c("Very Strong and strong conflicts", "Not very and no conflicts")),
         year = 1997)),
# 1999 - SI ---------------------------------------------------------------
(`1999` %>% mutate_all(., ~as.numeric(.)) %>% 
  select(iso3c = v3_1999, ess = v46_1999, class= class_1999, conflict = v43_1999, weight = weight_1999) %>% 
  mutate(iso3c = car::recode(.$iso3c, c("1='AUS';c(2,3)='DEU';4='GBR';c(10,5)='IRL';6='USA'; 7 ='AUT';
                                          8='HUN';9='ITA';11='NLD';12='NOR';13='SWE';14='CSK';15='SLO';
                                          16='POL';17='BGR';18='RUS';19='NZL';20='CAN';21='PHI';
                                          c(22,23)='ISR';24='JPN';25='ESP';26='LVA';27='FRA';28='CYP';
                                          29='PRT';30='CHL';31='CHE';32='BGD';33='SVK'")),
         ess = car::recode(.$ess,c("c(97,98,99)=NA")),
         class = car::recode(.$class,c("1='Lower class';c(2,3)='Working class';
                                   4='Middle class';5='Upper middle class'; 6='Upper class'; c(0,8,9)=NA"), as.factor = T,
                             levels = c("Lower class", "Working class", "Middle class", "Upper middle class", "Upper class")),
         conflict = car::recode(.$conflict,c("c(1,2)='Very Strong and strong conflicts';c(3,4,5)='Not very and no conflicts'; c(8,9)=NA"), as.factor = T,
                                levels = c("Very Strong and strong conflicts", "Not very and no conflicts")),
         year = 1999)),
# 2005 - WO ---------------------------------------------------------------
(`2005` %>%  
  select(iso3c = C_ALPHAN_2005, ess = TOPBOT_2005,  conflict = V49_2005, weight = WEIGHT_2005) %>%
  mutate_at(vars(-iso3c), ~as.numeric(.)) %>%
  mutate(iso3c= car::recode(.$iso3c,c("c('DE-E','DE-W')='DE';'BE-FLA'='BE';'GB-GBN'='GB'")),
           ess = car::recode(.$ess,c("c(97,98,99)=NA")),
         conflict = car::recode(.$conflict,c("c(5,4)='Very Strong and strong conflicts';c(3,1,2)='Not very and no conflicts'; c(7,8,9)=NA"), as.factor = T,
                                levels = c("Very Strong and strong conflicts", "Not very and no conflicts")),
         year = 2005) %>% 
  mutate(iso3c = countrycode(iso3c, "iso2c", "iso3c"))),
# 2009 - SI ---------------------------------------------------------------
(`2009` %>% 
  select(iso3c = C_ALPHAN_2009, ess = V44_2009, class= V66_2009, conflict = V42_2009, weight = WEIGHT_2009) %>%
  mutate_at(vars(-iso3c), ~as.numeric(.)) %>%
  mutate(iso3c= car::recode(.$iso3c,c("'BE-FLA'='BE';'GB-GBN'='GB'")),
         ess = car::recode(.$ess,c("c(97,98,99)=NA")),
         class = car::recode(.$class,c("1='Lower class';2='Working class';
                                   c(3,4)='Middle class';5='Upper middle class'; 6='Upper class'; c(0,8,9)=NA"), as.factor = T,
                             levels = c("Lower class", "Working class", "Middle class", "Upper middle class", "Upper class")),
         conflict = car::recode(.$conflict,c("c(1,2)='Very Strong and strong conflicts';c(3,4)='Not very and no conflicts'; c(7,8,9)=NA"), as.factor = T,
                                levels = c("Very Strong and strong conflicts", "Not very and no conflicts")),
         year = 2009) %>% 
  mutate(iso3c = countrycode(iso3c, "iso2c", "iso3c"))),
# 2015 - SI ---------------------------------------------------------------
(`2015` %>% 
  select(iso3c = c_alphan_2015, ess = TOPBOT_2015, conflict = v42_2015, weight = WEIGHT_2015) %>% 
  mutate_at(vars(-iso3c), ~as.numeric(.)) %>%
  mutate(iso3c= car::recode(.$iso3c,c("'GB-GBN'='GB'")),
         ess = car::recode(.$ess,c("c(0,97,98,99)=NA")),
         conflict = car::recode(.$conflict,c("c(5,4)='Very Strong and strong conflicts';c(3,1,2)='Not very and no conflicts'; c(7,8,9)=NA"), as.factor = T,
                                levels = c("Very Strong and strong conflicts", "Not very and no conflicts")),
         year = 2015) %>% 
  mutate(iso3c = countrycode(iso3c, "iso2c", "iso3c")))))

# 5. Group ----------------------------------------------------------------
rm(list = ls(pattern = "19|20|list")) #limpiar
issp <- merge((issp %>%
  pivot_longer(cols = c("class", "conflict"), names_to = "variable", values_to = "value") %>% 
  as_survey_design(ids = 1, weights = weight) %>%
  group_by(iso3c, year, variable, value) %>%
  filter(!is.na(value)) %>% 
  summarise(prop = survey_mean(vartype = "ci",na.rm = TRUE)) %>% 
  mutate(prop = prop*100) %>% select(1:prop) %>% 
    mutate(value = str_replace_all(tolower(value), " ", "_")) %>%
    mutate(value = str_replace_all(tolower(value), "_class|_conflicts", ""),
           value = str_replace_all(tolower(value), "_and_", "/")) %>% 
    pivot_wider(names_from = c("variable", "value"),
                values_from = "prop")),
  (issp %>%
  as_survey_design(ids = 1, weights = weight) %>%
  group_by(iso3c, year) %>%
  filter(!is.na(ess)) %>% 
  summarise(ess_mean = survey_mean(ess, na.rm = TRUE),
            ess_median = survey_median(ess, na.rm = TRUE)) %>% 
    select(-contains("se"))), by = c("iso3c", "year"), all = T) %>% 
  select(-contains("not_very"))

# 6. Label -------------------------------------------------------------------
# Llamar etiquetas (en slice se indican los tramos)
labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                                    sheet = 'Variables', range = c("B5:C900"), col_names = F) %>%
  select(variables = 1, etiquetas = 2) %>% 
  filter(grepl("_issp|year|iso3c", variables))

## Tranformar a vectornames
var.labels <- as.character(labels$etiquetas)
names(var.labels) <- labels$variables

## Etiquetar
Hmisc::label(issp) = as.list(var.labels[match(names(issp), names(issp))])

# 7. Save -----------------------------------------------------------------
saveRDS(issp, file="output/data/proc/issp.rds")