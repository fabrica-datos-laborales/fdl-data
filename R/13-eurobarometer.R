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

euro1976 <- read_sav("input/data/euro/euro1976.sav")
euro1977 <- read_sav("input/data/euro/euro1977.sav")
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

# 4. Merge and recode d.f -----------------------------------------------------------
euro <- bind_rows(list( 
  # 1976 ----------------------------------------------------------------
  (`euro1976` %>% select(iso2c = isocntry, value_post_mat = v185, id=v2, weight = v3) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat)) %>% 
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("0=NA;
                                                                       1='Materialist'; 
                                                                       2='Mixed/Neither'; 
                                                                       3='Post-Materialist'"),
                                        as.factor = T, 
                                        levels = c('Materialist',
                                                   'Mixed/Neither',
                                                   'Post-Materialist')),
            year = 1976)),

  # 1977 ----------------------------------------------------------------
  (`euro1977` %>% select(iso2c = isocntry, value_post_mat = v140, id=v4, weight = v5) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat)) %>% 
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("0=NA;
                                                                       1='Materialist'; 
                                                                       2='Mixed/Neither'; 
                                                                       3='Post-Materialist'"),
                                        as.factor = T, 
                                        levels = c('Materialist',
                                                   'Mixed/Neither',
                                                   'Post-Materialist')),
            year = 1977)),

  # 1979 ----------------------------------------------------------------
  (`euro1979` %>% select(iso2c = isocntry, value_post_mat = v56, id = v4, weight = v5) %>%
     mutate(value_post_mat = as.numeric(value_post_mat)) %>%
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("0=NA;
                                                                       1='Materialist'; 
                                                                       2='Mixed/Neither'; 
                                                                       3='Post-Materialist'"),
                                        as.factor = T, 
                                        levels = c('Materialist',
                                                   'Mixed/Neither',
                                                   'Post-Materialist')),
            year = 1979)),

  # 1980 ----------------------------------------------------------------
  (`euro1980` %>%  
     select(iso2c = isocntry, value_post_mat = v80, ind_strikes_next = v10, id = v4, 
            weight = v6) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat), 
            ind_strikes_next = as.numeric(ind_strikes_next)) %>%
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("0=NA;
                                                                       1='Materialist'; 
                                                                       2='Mixed/Neither'; 
                                                                       3='Post-Materialist'"),
                                        as.factor = T, 
                                        levels = c('Materialist',
                                                   'Mixed/Neither',
                                                   'Post-Materialist')),
            ind_strikes_next = car::recode(.$ind_strikes_next, recodes = c("0 = NA;
                                                                           1 = 'Increase';
                                                                           2 = 'Remain the same';
                                                                           3 = 'Decrease'"),
                                           as.factor = T,
                                           levels = c('Increase',
                                                      'Remain the same',
                                                      'Decrease')),
            year = 1980)),
  
  # 1981 ----------------------------------------------------------------
  (`euro1981` %>% 
     select(iso2c = isocntry, value_post_mat = v91, ind_strikes_next = v11, 
            id = v4, weight = v7) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat), 
            ind_strikes_next = as.numeric(ind_strikes_next)) %>%
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("0=NA;
                                                                       1='Materialist'; 
                                                                       2='Mixed/Neither'; 
                                                                       3='Post-Materialist'"),
                                        as.factor=T, 
                                        levels = c('Materialist',
                                                   'Mixed/Neither',
                                                   'Post-Materialist')),
            ind_strikes_next = car::recode(.$ind_strikes_next, recodes = c("0 = NA;
                                                                           1 = 'Increase';
                                                                           2 = 'Remain the same';
                                                                           3 = 'Decrease'"),
                                           as.factor = T,
                                           levels = c('Increase',
                                                      'Remain the same',
                                                      'Decrease')),
            year = 1981)),
  # 1982 ----------------------------------------------------------------
  (`euro1982` %>% 
     select(iso2c = isocntry, value_post_mat = v87, ind_strikes_next = v10, 
            id = v4, weight = v8) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat), 
            ind_strikes_next = as.numeric(ind_strikes_next)) %>%
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("0=NA;
                                                                       1='Materialist'; 
                                                                       2='Mixed/Neither'; 
                                                                       3='Post-Materialist'"),
                                         as.factor=T, 
                                         levels = c('Materialist',
                                                    'Mixed/Neither',
                                                    'Post-Materialist')),
            ind_strikes_next = car::recode(.$ind_strikes_next, recodes = c("0 = NA;
                                                                           1 = 'Increase';
                                                                           2 = 'Remain the same';
                                                                           3 = 'Decrease'"),
                                           as.factor = T,
                                           levels = c('Increase',
                                                      'Remain the same',
                                                      'Decrease')),
            year = 1982)),

  # 1983 --------------------------------------------------------------------
  (`euro1983` %>% 
   select(iso2c = isocntry, value_post_mat = v466, ind_strikes_next = v11, 
          id = v4, weight = v9) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat), 
            ind_strikes_next = as.numeric(ind_strikes_next)) %>%
   mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("4=NA;
                                                                     1='Materialist'; 
                                                                     2='Mixed/Neither'; 
                                                                     3='Post-Materialist'"),
                                      as.factor=T, 
                                      levels = c('Materialist',
                                                 'Mixed/Neither',
                                                 'Post-Materialist')),
          ind_strikes_next = car::recode(.$ind_strikes_next, recodes = c("0 = NA;
                                                                          1 = 'Increase';
                                                                          2 = 'Remain the same';
                                                                          3 = 'Decrease'"),
                                         as.factor = T,
                                         levels = c('Increase',
                                                    'Remain the same',
                                                    'Decrease')),
          year = 1983)),
  
  # 1984 --------------------------------------------------------------------
  (`euro1984` %>% 
   select(iso2c = isocntry, value_post_mat = v188, ind_strikes_next = v12, 
          id = v4, weight = v9) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat), 
            ind_strikes_next = as.numeric(ind_strikes_next)) %>%
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("4=NA;
                                                                     1='Materialist'; 
                                                                     2='Mixed/Neither'; 
                                                                     3='Post-Materialist'"),
                                         as.factor=T, 
                                         levels = c('Materialist',
                                                    'Mixed/Neither',
                                                    'Post-Materialist')),
            ind_strikes_next = car::recode(.$ind_strikes_next, recodes = c("0 = NA;
                                                                          1 = 'Increase';
                                                                          2 = 'Remain the same';
                                                                          3 = 'Decrease'"),
                                           as.factor = T,
                                           levels = c('Increase',
                                                      'Remain the same',
                                                      'Decrease')),
          year = 1984)),

  # 1985 --------------------------------------------------------------------
  (`euro1985` %>% 
   select(iso2c = isocntry, value_post_mat = v93, ind_strikes_next = v12, 
          id = v4, weight = v9) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat), 
            ind_strikes_next = as.numeric(ind_strikes_next)) %>%
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("4=NA;
                                                                     1='Materialist'; 
                                                                     2='Mixed/Neither'; 
                                                                     3='Post-Materialist'"),
                                         as.factor=T, 
                                         levels = c('Materialist',
                                                    'Mixed/Neither',
                                                    'Post-Materialist')),
            ind_strikes_next = car::recode(.$ind_strikes_next, recodes = c("0 = NA;
                                                                          1 = 'Increase';
                                                                          2 = 'Remain the same';
                                                                          3 = 'Decrease'"),
                                           as.factor = T,
                                           levels = c('Increase',
                                                      'Remain the same',
                                                      'Decrease')),
          year = 1985)),

  # 1986 --------------------------------------------------------------------
  (`euro1986` %>% 
   select(iso2c = isocntry, value_post_mat = v228, ind_strikes_next = v12, 
          id = v4, weight = v9) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat), 
            ind_strikes_next = as.numeric(ind_strikes_next)) %>%
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("4=NA;
                                                                     1='Materialist'; 
                                                                     2='Mixed/Neither'; 
                                                                     3='Post-Materialist'"),
                                         as.factor=T, 
                                         levels = c('Materialist',
                                                    'Mixed/Neither',
                                                    'Post-Materialist')),
            ind_strikes_next = car::recode(.$ind_strikes_next, recodes = c("0 = NA;
                                                                          1 = 'Increase';
                                                                          2 = 'Remain the same';
                                                                          3 = 'Decrease'"),
                                           as.factor = T,
                                           levels = c('Increase',
                                                      'Remain the same',
                                                      'Decrease')),
          year = 1986)),
 
  # 1987 --------------------------------------------------------------------
  (`euro1987` %>% 
   select(iso2c = isocntry, value_post_mat = v473, tum_whynot = v302, 
          id = v5, weight = v10) %>% 
   mutate(value_post_mat = as.numeric(value_post_mat),
          tum_whynot = as.numeric(tum_whynot)) %>% 
   mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("4=NA;
                                                                     1='Materialist'; 
                                                                     2='Mixed/Neither'; 
                                                                     3='Post-Materialist'"),
                                      as.factor=T, 
                                      levels = c('Materialist',
                                                 'Mixed/Neither',
                                                 'Post-Materialist')),
          year = 1987)),

  # 1988 --------------------------------------------------------------------
  (`euro1988` %>% 
   select(iso2c = isocntry, value_post_mat = v724, ind_strikes_next = v12, 
          id = v4, weight = v9) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat), 
            ind_strikes_next = as.numeric(ind_strikes_next)) %>%
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("4=NA;
                                                                     1='Materialist'; 
                                                                     2='Mixed/Neither'; 
                                                                     3='Post-Materialist'"),
                                         as.factor=T, 
                                         levels = c('Materialist',
                                                    'Mixed/Neither',
                                                    'Post-Materialist')),
            ind_strikes_next = car::recode(.$ind_strikes_next, recodes = c("0 = NA;
                                                                          1 = 'Increase';
                                                                          2 = 'Remain the same';
                                                                          3 = 'Decrease'"),
                                           as.factor = T,
                                           levels = c('Increase',
                                                      'Remain the same',
                                                      'Decrease')),
          year = 1988)),

  # 1989 --------------------------------------------------------------------
  (`euro1989` %>% 
   select(iso2c = isocntry, value_post_mat = v1379, id = v4, weight = v9) %>% 
   mutate(value_post_mat = as.numeric(value_post_mat)) %>% 
   mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("4=NA;
                                                                     1='Materialist'; 
                                                                     2='Mixed/Neither'; 
                                                                     3='Post-Materialist'"),
                                      as.factor=T, 
                                      levels = c('Materialist',
                                                 'Mixed/Neither',
                                                 'Post-Materialist')),
          year = 1989)),

  # 1990 --------------------------------------------------------------------
  (`euro1990` %>% 
   select(iso2c = isocntry, value_post_mat = v501, id = v5, weight = v15) %>% 
   mutate(value_post_mat = as.numeric(value_post_mat)) %>%   
   mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("0=NA;
                                                                     1='Materialist'; 
                                                                     2='Mixed/Neither'; 
                                                                     3='Post-Materialist'"),
                                      as.factor=T, 
                                      levels = c('Materialist',
                                                 'Mixed/Neither',
                                                 'Post-Materialist')),
          year = 1990)),

  # 1991 --------------------------------------------------------------------
  (`euro1991` %>% 
   select(iso2c = isocntry, value_post_mat = v470, id = v5, weight = v16) %>% 
     mutate(value_post_mat = as.numeric(value_post_mat)) %>%   
     mutate(value_post_mat = car::recode(.$value_post_mat, recodes = c("0=NA;
                                                                     1='Materialist'; 
                                                                     2='Mixed/Neither'; 
                                                                     3='Post-Materialist'"),
                                      as.factor=T, 
                                      levels = c('Materialist',
                                                 'Mixed/Neither',
                                                 'Post-Materialist')),
          year = 1991))))

# 5. Group ----------------------------------------------------------------
rm(list = ls(pattern = "19|list")) #limpiar

euro <- euro %>%
  pivot_longer(cols = c("value_post_mat", "ind_strikes_next"), names_to = "variable", values_to = "value") %>% 
  as_survey_design(ids = 3, weights = weight) %>%
  group_by(iso2c, year, variable, value) %>%
  filter(!is.na(value)) %>% 
  summarise(prop = survey_mean(vartype = "ci",na.rm = TRUE)) %>% 
  mutate(prop = prop*100) %>% select(1:prop) %>% 
  mutate(value = str_replace_all(tolower(value), " ", "_")) %>%
  mutate(value = str_replace_all(tolower(value), "_value_post_mat|_ind_strikes_next", ""),
         value = str_replace_all(tolower(value), "_and_", "/")) %>% 
  pivot_wider(names_from = c("variable", "value"),
              values_from = "prop")  

# 6. Label -------------------------------------------------------------------
# Llamar etiquetas (en slice se indican los tramos)
labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                                    range = c("B4:C900"), col_names = F) %>%
  select(variables = 1, etiquetas = 2) %>% 
  filter(grepl("_euro|year|iso2c", variables))

## Tranformar a vectornames
var.labels <- as.character(labels$etiquetas)
names(var.labels) <- labels$variables

## Etiquetar
Hmisc::label(euro) = as.list(var.labels[match(names(euro), names(euro))])

# 7. Save -----------------------------------------------------------------
saveRDS(euro, file="output/data/proc/euro.rds")
