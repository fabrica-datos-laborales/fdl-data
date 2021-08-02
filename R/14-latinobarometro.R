# Code 14 : Latinobarometro  --------------------------------------------------


# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse,rvest, sjlabelled, Hmisc, countrycode, survey, srvyr, sjmisc, haven)

# 2. Load data ------------------------------------------------------------

## File names

file_names=as.list(dir(path ="input/data/lat/", pattern="*.sav"))

file_names = lapply(file_names, function(x) paste0('input/data/lat/', x))

## List of data frames
r <- lapply(file_names, haven::read_sav)

# 2. Proc -----------------------------------------------------------------
names(r) <- gsub("input/data/lat/latino|1995|1996|1997|1998|2000|2001|2002|
                 2003|2004|2005|2006|2007|2008|2009|2010|2011|2013|2015|2016|
                 2017|2018|.sav","", file_names)

r <- Map(function(x, y) {names(x) <- paste0(names(x), '_',  y); x}, r, names(r))

list_lat <- r

rm(list = ls(pattern = "r|file_names"))

# 3. Unlist ---------------------------------------------------------------
list2env(list_lat, envir = .GlobalEnv)


# 0. Apertura provisional de datos -------------------------------------------

latino1995 <- read_sav("input/data/lat/latino1995.sav")
latino1996 <- read_sav("input/data/lat/latino1996.sav")
latino1997 <- read_sav("input/data/lat/latino1997.sav")
latino1998 <- read_sav("input/data/lat/latino1998.sav")
latino2000 <- read_sav("input/data/lat/latino2000.sav")
latino2001 <- read_sav("input/data/lat/latino2001.sav")
latino2002 <- read_sav("input/data/lat/latino2002.sav")
latino2003 <- read_sav("input/data/lat/latino2003.sav")
latino2004 <- read_sav("input/data/lat/latino2004.sav")
latino2005 <- read_sav("input/data/lat/latino2005.sav")
latino2006 <- read_sav("input/data/lat/latino2005.sav")
latino2007 <- read_sav("input/data/lat/latino2006.sav")
latino2008 <- read_sav("input/data/lat/latino2008.sav")
latino2009 <- read_sav("input/data/lat/latino2009.sav")
latino2010 <- read_sav("input/data/lat/latino2010.sav")
latino2011 <- read_sav("input/data/lat/latino2011.sav")
latino2013 <- read_sav("input/data/lat/latino2013.sav")
latino2015 <- read_sav("input/data/lat/latino2015.sav")
latino2016 <- read_sav("input/data/lat/latino2016.sav")
latino2017 <- read_sav("input/data/lat/latino2017.sav")
latino2018 <- read_sav("input/data/lat/latino2018.sav")

# 4. Merge and recode d.f -----------------------------------------------------------
lat <- bind_rows(list(
  # 1995 ----------------------------------------------------------
  (`latino1995` %>% 
     select(iso3c = pais, distr_inc_fair = p19, most_power1 = p61a1, weight = wt) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 76='BRA';
                                152='CHL'; 484='MEX'; 600='PRY'; 604='PER';
                                858='URY'; 862='VEN'"),
            dist_inc_fair = car::recode(.$distr_inc_fair, recodes = c("-4:-1=NA"),
                                        as.factor = T, 
                                        levels = c('Very Fair', 'Fair',
                                                   'Neither fair nor unfair',
                                                   'Unfair', 'Very Unfair')),
            most_power1 = car::recode(.$most_power1, recodes = c("-4:-1=NA"),
                                      as.factor = T,
                                      levels = c('Large companies', 
                                                 'The military',
                                                 'Trade unions',
                                                 'Mass media',
                                                 'Banks',
                                                 'Political parties',
                                                 'Transnational companies',
                                                 'The government',
                                                 'Parliament/Congress')),
                                         
            year = 1995))),
  # 1996 ----------------------------------------------------------------
  (`latino1996` %>%
     select(iso3c = pais, trust_union= p33c, trust_private_comp = p33f, 
            trust_comp_asso = p33k, trust_gov = p33m, most_power1 = p63a,
            trust_pub_adm = p33g, weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                         as.factor = T, 
                                         levels = c('A lot of confidence',
                                                    'Some confidence',
                                                    'Little confidence',
                                                    'No confidence at all'))) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 218='ECU'; 
                                222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 558='NIC';
                                600='PRY'; 604='PER'; 724='ESP'; 858='URY'; 862='VEN'")),
            most_power1 = car::recode(.$most_power1, recodes = c("-4:-1=NA"),
                                      as.factor = T,
                                      levels = c('Large companies', 
                                                 'The military',
                                                 'Trade unions',
                                                 'Mass media',
                                                 'Banks',
                                                 'Political parties',
                                                 'Transnational companies',
                                                 'The government',
                                                 'Parliament/Congress')),
            year = 1996))),
   
  # 1997 ----------------------------------------------------------------
  (`latino1997` %>% select(iso3c = idenpa, distr_inc_fair = nsp20, labor_law_prot = sp83,
                     most_power1 = sp55a, weight = wt) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 218='ECU'; 
                                222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 558='NIC';
                                591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 858='URY'; 
                                862='VEN'")),
            dist_inc_fair = car::recode(.$distr_inc_fair, recodes = c("-4:-1=NA"),
                                        as.factor = T, 
                                        levels = c('Very Fair', 'Fair',
                                                   'Neither fair nor unfair',
                                                   'Unfair', 'Very Unfair')),
            labor_law_prot = car::recode(.$labor_law_prot, recodes = c("-4:-1=NA"),
                                         as.factor = T,
                                         levels = c('Very protected', 'Fairly protected',
                                                    'A little protected', 'Not at all protected')),
            most_power1 = car::recode(.$most_power1, recodes = c("-4:-1=NA"),
                                      as.factor = T,
                                      levels = c('Large companies', 
                                                 'The military',
                                                 'Trade unions',
                                                 'Mass media',
                                                 'Banks',
                                                 'Political parties',
                                                 'Transnational companies',
                                                 'The government',
                                                 'Parliament/Congress')),
     year = 1997)),
  
  # 1998 ----------------------------------------------------------------
  (`latino1998` %>% select(iso3c = idenpa, most_power1 = sp51a, weight = pondera) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            most_power1 = car::recode(.$most_power1, recodes = c("-4:-1=NA"),
                                      as.factor = T,
                                      levels = c('Large companies', 
                                                 'The military',
                                                 'Trade unions',
                                                 'Mass media',
                                                 'Banks',
                                                 'Political parties',
                                                 'Transnational companies',
                                                 'The government',
                                                 'Parliament/Congress')),
            year = 1998)),
  # 2000 ----------------------------------------------------------------
  (`latino2000` %>% select(iso3c = IDENPA, labor_law_prot = P74ST, most_power1 = P51ST.A,
                     weight = WT) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
           labor_law_prot = car::recode(.$labor_law_prot, recodes = c("c(-4:-1, 16)=NA"),
                                          as.factor = T,
                                          levels = c('Very protected', 'Fairly protected',
                                                     'A little protected', 'Not at all protected')),
           most_power1 = car::recode(.$most_power1, recodes = c("-4:-1=NA"),
                                       as.factor = T,
                                       levels = c('Large companies', 
                                                  'The military',
                                                  'Trade unions',
                                                  'Mass media',
                                                  'Banks',
                                                  'The government',
                                                  'Parliament/Congress',
                                                  'The judiciary',
                                                  'Transnational companies',
                                                  'Warfare',
                                                  'Medium-sized companies')),
             year = 2000)),
  # 2001 ----------------------------------------------------------------
  (`latino2001` %>%  
     select(iso3c = idenpa, distr_inc_fair = p11st, trust_pub_adm = p63stb, 
            trust_priv_comp = p63std, most_power1 = p64sta, weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                                           as.factor = T, 
                                                           levels = c('A lot of confidence',
                                                                      'Some confidence',
                                                                      'Little confidence',
                                                                      'No confidence at all')))) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            distr_inc_fair = car::recode(.$distr_inc_fair, recodes = c("-4:-1=NA"),
                                         as.factor = T, 
                                         levels = c('Very Fair', 'Fair',
                                                    'Neither fair nor unfair',
                                                    'Unfair', 'Very Unfair')),
            most_power1 = car::recode(.$most_power1, recodes = c("-4:-1=NA"),
                                      as.factor = T,
                                      levels = c('Large companies', 
                                                 'The military',
                                                 'Trade unions',
                                                 'The judiciary',
                                                 'Banks',
                                                 'Political parties',
                                                 'Transnational companies',
                                                 'The government',
                                                 'Parliament/Congress')),
            year = 2001)),
  
  # 2002 ----------------------------------------------------------------
  (`latino2002` %>% 
     select(iso3c = idenpa, dist_inc_fair = p16st, trust_banks = p34stb, 
            trust_gov = p34std, trust_private_comp = p34ste, 
            op_strong_tu = p22essh, weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                                            as.factor = T, 
                                                            levels = c('A lot of confidence',
                                                                       'Some confidence',
                                                                       'Little confidence',
                                                                       'No confidence at all')))) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            distr_inc_fair = car::recode(.$distr_inc_fair, recodes = c("-4:-1=NA"),
                                         as.factor = T, 
                                         levels = c('Very Fair', 'Fair',
                                                    'Neither fair nor unfair',
                                                    'Unfair', 'Very Unfair')),
            op_strong_tu = car::recode(.$op_strong_tu, recodes = c("-4:-1=NA"),
                                       as.factor = T,
                                       levels = c('Strongly agree', 'Agree',
                                                  'Disagree', 'Strongly disagree')),
            year = 2002)),
  # 2003 ----------------------------------------------------------------
  (`latino2003` %>% 
     select(iso3c = idenpa, trust_union = p23sta, trust_private_comp = p23stb, 
            trust_banks = p23std, trust_gov = p23stg, most_power1 = p10st.1,
            weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                                            as.factor = T, 
                                                            levels = c('A lot of confidence',
                                                                       'Some confidence',
                                                                       'Little confidence',
                                                                       'No confidence at all')))) %>%
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            most_power1 = car::recode(.$most_power1, recodes = c("-4:-1=NA"),
                                      as.factor = T,
                                      levels = c('Large companies', 
                                                 'The military',
                                                 'Trade unions',
                                                 'Mass media',
                                                 'Banks',
                                                 'Political parties',
                                                 'The government',
                                                 'Parliament/Congress')),
            year = 2003)),
  
  # 2004 --------------------------------------------------------------------
  (`latino2004` %>% 
     select(iso3c = idenpa, gov_pow_people = p24wvs, most_power1 = p15st.1,
            trust_banks = p32sta, trust_gov = p32std, trust_union = p32ste,
            trust_private_comp = p34sta, weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                                            as.factor = T, 
                                                            levels = c('A lot of confidence',
                                                                       'Some confidence',
                                                                       'Little confidence',
                                                                       'No confidence at all')))) %>%
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            gov_pow_people = car::recode(.$gov_pow_people, recodes = '-4:-1=NA',
                                         as.factor=T, 
                                         levels = c('Benefit of powerful interests',
                                                    'For the good of all')),
            most_power1 = car::recode(.$most_power1, recodes = c("-4:-1=NA"),
                                      as.factor = T,
                                      levels = c('Large companies', 
                                                 'The military',
                                                 'Trade unions',
                                                 'Mass media',
                                                 'Banks',
                                                 'Political parties',
                                                 'The government',
                                                 'Parliament/Congress')),
            year = 2004)),
  
  # 2005 --------------------------------------------------------------------
  (`latino2005` %>% 
     select(iso3c = idenpa, gov_pow_people = p22st, trust_union = p42stc, 
            trust_gov = p45stc, trust_priv_comp = p45std, trust_banks = p45ste,
            trust_pub_adm = p45stf, trust_comp_asso = p47stg, most_power1 = p27st_1,
            weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                                            as.factor = T, 
                                                            levels = c('A lot of confidence',
                                                                       'Some confidence',
                                                                       'Little confidence',
                                                                       'No confidence at all')))) %>%
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            gov_pow_people = car::recode(.$gov_pow_people, recodes = '-4:-1=NA',
                                         as.factor=T, 
                                         levels = c('Benefit of powerful interests',
                                                    'For the good of all')),
            most_power1 = car::recode(.$most_power1, recodes = c("-4:0=NA"),
                                      as.factor = T,
                                      levels = c('Large companies', 
                                                 'The military',
                                                 'Trade unions',
                                                 'Mass media',
                                                 'Banks',
                                                 'Political parties',
                                                 'The government',
                                                 'Parliament/Congress',
                                                 'The judiciary',
                                                 'Transnational companies',
                                                 'Warfare',
                                                 'Medium-sized companies')),
            year = 2005)),
  
  # 2006 --------------------------------------------------------------------
  (`2006` %>% 
     select(iso3c = idenpa, gov_pow_people = p22st, most_power1 = p27st_1, 
            trust_union = p42stc, trust_gov = p45stc, trust_priv_comp = p45std,
            trust_banks = p45ste, trust_pub_adm = p45stf, trust_comp_asso = p47stg, 
            weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                                            as.factor = T, 
                                                            levels = c('A lot of confidence',
                                                                       'Some confidence',
                                                                       'Little confidence',
                                                                       'No confidence at all')))) %>%
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            gov_pow_people = car::recode(.$gov_pow_people, recodes = '-4:-1=NA',
                                         as.factor=T, 
                                         levels = c('Benefit of powerful interests',
                                                    'For the good of all')),
            most_power1 = car::recode(.$most_power1, recodes = c("-4:0=NA"),
                                      as.factor = T,
                                      levels = c('Large companies', 
                                                 'The military',
                                                 'Trade unions',
                                                 'Mass media',
                                                 'Banks',
                                                 'Political parties',
                                                 'The government',
                                                 'Parliament/Congress',
                                                 'The judiciary',
                                                 'Transnational companies',
                                                 'Warfare',
                                                 'Medium-sized companies')),
            year = 2006)),
  
  # 2007 --------------------------------------------------------------------
  (`latino2007` %>% #Falta agregar MOST POWER 
     select(iso3c = idenpa, gov_pow_people = p20stm, trust_gov = p32st.a, 
            trust_priv_comp = p32st.b, weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                                            as.factor = T, 
                                                            levels = c('A lot of confidence',
                                                                       'Some confidence',
                                                                       'Little confidence',
                                                                       'No confidence at all')))) %>%
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            gov_pow_people = car::recode(.$gov_pow_people, recodes = '-4:-1=NA',
                                         as.factor=T, 
                                         levels = c('Benefit of powerful interests',
                                                    'For the good of all')),
            year = 2007)),
  
  # 2008 --------------------------------------------------------------------
  (`latino2008` %>% 
     select(iso3c = idenpa, gov_pow_people = p25st, conflict_rp = p69st.a, 
            conflict_man_workers = p69st.c, trust_pub_adm = p28st.e, trust_gov = p31s.ta,  
            trust_banks = p31st.b, trust_union = p31st.g, trust_priv_comp = p31st.h,
            weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                                            as.factor = T, 
                                                            levels = c('A lot of confidence',
                                                                       'Some confidence',
                                                                       'Little confidence',
                                                                       'No confidence at all')))) %>%
     mutate_at(vars(starts_with('conflict'), funs(car::recode(., recodes = '-4:-1=NA',
                                                              as.factor = T,
                                                              levels = c('Very strong',
                                                                         'Strong',
                                                                         'Weak',
                                                                         "It doesn't exist conflict"))))) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            gov_pow_people = car::recode(.$gov_pow_people, recodes = '-4:-1=NA',
                                         as.factor=T, 
                                         levels = c('Benefit of powerful interests',
                                                    'For the good of all')),
            year = 2008)),
  
  # 2009 --------------------------------------------------------------------
  (`latino2009` %>% 
     select(iso3c = idenpa, gov_pow_people = p22st, conflict_rp = p34stm.a, 
            conflict_man_workers = p34stm.b, trust_gov = p24st.a, trust_banks = p24st.b,
            trust_union = p24st.g, trust_priv_comp = p24st.h, trust_pub_adm = p26st.e,
            weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                                            as.factor = T, 
                                                            levels = c('A lot of confidence',
                                                                       'Some confidence',
                                                                       'Little confidence',
                                                                       'No confidence at all')))) %>%
     mutate_at(vars(starts_with('conflict'), funs(car::recode(., recodes = '-4:-1=NA',
                                                              as.factor = T,
                                                              levels = c('Very strong',
                                                                         'Strong',
                                                                         'Weak',
                                                                         "It doesn't exist conflict"))))) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            gov_pow_people = car::recode(.$gov_pow_people, recodes = '-4:-1=NA',
                                         as.factor=T, 
                                         levels = c('Benefit of powerful interests',
                                                    'For the good of all')),
            year = 2009)),
  
  # 2010 --------------------------------------------------------------------
  (`latino2010` %>% # FALTA MOST POWER
     select(iso3c = IDENPA, gov_pow_people = P17ST, distr_inc_fair = P12ST, 
            conflict_rp = P27ST.A, conflict_man_workers = P27ST.B, trust_gov = P18ST.A,
            trust_banks = P18ST.B, trust_union = P18ST.G, trust_priv_comp = P18ST.H,
            trust_pub_adm = P20ST.E, trust_state = P20ST.I, weight = wt) %>% 
     mutate_at(vars(starts_with('trust')), funs(car::recode(., recodes = '-4:-1=NA',
                                                            as.factor = T, 
                                                            levels = c('A lot of confidence',
                                                                       'Some confidence',
                                                                       'Little confidence',
                                                                       'No confidence at all')))) %>%
     mutate_at(vars(starts_with('conflict'), funs(car::recode(., recodes = '-4:-1=NA',
                                                              as.factor = T,
                                                              levels = c('Very strong',
                                                                         'Strong',
                                                                         'Weak',
                                                                         "It doesn't exist conflict"))))) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            gov_pow_people = car::recode(.$gov_pow_people, recodes = '-4:-1=NA',
                                         as.factor=T, 
                                         levels = c('Benefit of powerful interests',
                                                    'For the good of all')),
            dist_inc_fair = car::recode(.$distr_inc_fair, recodes = c("-4:-1=NA"),
                                        as.factor = T, 
                                        levels = c('Very Fair', 'Fair',
                                                   'Neither fair nor unfair',
                                                   'Unfair', 'Very Unfair')),
            year = 2010)),
  
  # 2011 --------------------------------------------------------------------
  (`latino2011` %>% 
     select(iso3c = IDENPA, gov_pow_people = P19ST, distr_inc_fair = P12ST, 
            weight = v15) %>% 
     mutate(iso3c = car::recode(.$iso3c, recodes = c("-5:-1=NA; 32='ARG'; 68='BOL';
                                76='BRA'; 152='CHL'; 170='COL'; 188='CRI'; 214='DOM';
                                218='ECU'; 222='SLV'; 320='GTM'; 340='HND'; 484='MEX'; 
                                558='NIC'; 591= 'PAN'; 600='PRY'; 604='PER'; 724='ESP'; 
                                858='URY'; 862='VEN'")),
            gov_pow_people = car::recode(.$gov_pow_people, recodes = '-4:-1=NA',
                                         as.factor=T, 
                                         levels = c('Benefit of powerful interests',
                                                    'For the good of all')),
            dist_inc_fair = car::recode(.$distr_inc_fair, recodes = c("-4:-1=NA"),
                                        as.factor = T, 
                                        levels = c('Very Fair', 'Fair',
                                                   'Neither fair nor unfair',
                                                   'Unfair', 'Very Unfair')),
            year = 2011)),
  
  # 1991 --------------------------------------------------------------------
  (`1991` %>% 
     select(iso2c = isocntry, value_post_mat = v470, weight = v16) %>% 
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = '0=NA',
                                         as.factor=T, 
                                         levels = c('Materialist',
                                                    'Mixed/Neither',
                                                    'Post-Materialist')),
            year = 1991) %>% 
     mutate(iso3c = countrycode(iso3c, "iso2c", "iso3c"))),
  
))
