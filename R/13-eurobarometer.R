# Code 13 : Eurobarometer --------------------------------------------------


# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse,rvest, sjlabelled, Hmisc, countrycode, survey, srvyr, sjmisc, haven)

# 2. Load data ------------------------------------------------------------

## File names

file_names=as.list(dir(path ="input/data/euro/", pattern="*.sav"))

file_names = lapply(file_names, function(x) paste0('input/data/euro/', x))

## List of data frames
r <- lapply(file_names, haven::read_sav)

# 2. Proc -----------------------------------------------------------------
names(r) <- gsub("input/data/euro/euro|1970|1973|1974|1975|1976|1977|
                 1978|1979|1980|1981|1982|1983|1984|1985|1986|1987|1988|1989|
                 1990|1991|1996|.sav","", file_names)

r <- Map(function(x, y) {names(x) <- paste0(names(x), '_',  y); x}, r, names(r))

list_eu <- r

rm(list = ls(pattern = "r|file_names"))

# 3. Unlist ---------------------------------------------------------------
list2env(list_eu, envir=.GlobalEnv)

# 0. Apertura provisional de datos -------------------------------------------

euro1970 <- read_sav("input/data/euro/euro1970.sav")
euro1973 <- read_sav("input/data/euro/euro1973.sav")
euro1974 <- read_sav("input/data/euro/euro1974.sav")
euro1975 <- read_sav("input/data/euro/euro1975.sav")
euro1976 <- read_sav("input/data/euro/euro1976.sav")
euro1977 <- read_sav("input/data/euro/euro1977.sav")
euro1978 <- read_sav("input/data/euro/euro1978.sav")
euro1979 <- read_sav("input/data/euro/euro1979.sav")
euro1980 <- read_sav("input/data/euro/euro1980.sav")
euro1981 <- read_sav("input/data/euro/euro1981.sav")
euro1982 <- read_sav("input/data/euro/euro1982.sav")
euro1983 <- read_sav("input/data/euro/euro1983.sav")
euro1984 <- read_sav("input/data/euro/euro1984.sav")
euro1985 <- read_sav("input/data/euro/euro1985.sav")
euro1986 <- read_sav("input/data/euro/euro1986.sav")
euro1987 <- read_sav("input/data/euro/euro1987.sav")
euro1988 <- read_sav("input/data/euro/euro1988.sav")
euro1989 <- read_sav("input/data/euro/euro1989.sav")
euro1990 <- read_sav("input/data/euro/euro1990.sav")
euro1991 <- read_sav("input/data/euro/euro1991.sav")
euro1996 <- read_sav("input/data/euro/euro1996.sav")

# 4. Merge and recode d.f -----------------------------------------------------------
euro <- bind_rows(list(
  # 1970 ----------------------------------------------------------
  (`euro1970` %>% 
     select(iso2c = isocntry, value_post_mat = v118) %>% 
     mutate(value_post_mat, car::recode(., recodes = '9=NA',
                                        as.factor=T, 
                                        levels = c('Materialist',
                                                   'Mixed/Neither',
                                                   'Post-Materialist')),
            year = 1970)),
# 1973 ----------------------------------------------------------------
  (`1973` %>%
     select(iso2c = isocntry, value_post_mat = v128) %>% 
     mutate(value_post_mat, car::recode(., recodes = '0=NA',
                                        as.factor=T, 
                                        levels = c('Materialist',
                                                   'Mixed/Neither',
                                                   'Post-Materialist')),
            year = 1973)),
  # 1976 ----------------------------------------------------------------
  (`1976` %>% select(iso2c = isocntry, value_post_mat = v185, weight = v3) %>% 
     mutate(value_post_mat, car::recode(., recodes = '0=NA',
                                        as.factor=T, 
                                        levels = c('Materialist',
                                                   'Mixed/Neither',
                                                   'Post-Materialist')),
            year = 1976)),
  # 1977 ----------------------------------------------------------------
  (`1977` %>% select(iso2c = iscntry, value_post_mat = v140, weight = v5) %>% 
     mutate(value_post_mat, car::recode(., recodes = '0=NA',
                                        as.factor=T, 
                                        levels = c('Materialist',
                                                   'Mixed/Neither',
                                                   'Post-Materialist')),
            year = 1977)),
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

