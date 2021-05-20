# Code: ILOSTAT --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(Rilostat, tidyverse)

# 2. Scrapping ------------------------------------------------------------
ud_ilostat <- Rilostat::get_ilostat("ILR_TUMT_NOC_RT_A") %>% 
  select(iso3c = ref_area, year=time, ud= obs_value) #Trade union density rate (%)

cbc_ilostat <- Rilostat::get_ilostat("ILR_CBCT_NOC_RT_A")  %>% 
  select(iso3c = ref_area, year=time, cbc= obs_value) #Collective bargaining coverage rate (%)

hour_earn_ilostat <- Rilostat::get_ilostat("EAR_4HRL_SEX_OCU_CUR_NB_A") %>% 
  select(iso3c = ref_area, year=time, hour_earn= obs_value, sex, classif1) #Mean nominal hourly earning of employees (U.S. dollars)
table(hour_earn_ilostat$sex) #Hay tres sexos (F, M y T)

month_earn_ilostat <- Rilostat::get_ilostat("EAR_XEES_SEX_ECO_NB_M") %>% 
  select(iso3c = ref_area, year=time, month_earn= obs_value, sex, classif1) #Mean nominal monthly earning of employees (U.S. dollars)
#Los años están separados en meses, ¿juntar todos los meses de un mismo año?

labor_inc_share_ilostat	<- Rilostat::get_ilostat("LAP_2GDP_NOC_RT_A") %>% 
  select(iso3c = ref_area, year=time, labor_inc_share= obs_value) #Labour income share as a percent of GDP

emp_inst_ilostat <- Rilostat::get_ilostat("EMP_TEMP_SEX_INS_NB_A") %>% 
  select(iso3c = ref_area, year=time, emp_inst= obs_value, sex, classif1) #Employment by sex and institutional sector (thousands)

emp_status_ilostat	<- Rilostat::get_ilostat("EMP_2EMP_SEX_STE_NB_A") %>% 
  select(iso3c = ref_area, year=time, emp_status= obs_value, sex, classif1) #Employment by sex and status in employment

nstrikes_act_ilostat <- Rilostat::get_ilostat("STR_TSTR_ECO_NB_A") %>% 
  select(iso3c = ref_area, year=time, nstrikes_act= obs_value, activiy=classif1) #Number of strikes and lockouts by economic activity

ndays_strikes_ilostat	<- Rilostat::get_ilostat("STR_DAYS_ECO_NB_A") %>% 
  select(iso3c = ref_area, year=time, ndays_strikes= obs_value, activiy=classif1) #Days not worked due to strikes and lockouts by economic activity

ndays_strikes_ilostat1	<- Rilostat::get_ilostat("STR_DAYS_ECO_NB_A") %>% 
  select(iso3c = ref_area, year=time, ndays_strikes= obs_value, activity=classif1) %>%
  pivot_wider(names_from = c("activity"), values_from = ("ndays_strikes"))

nworkers_strikes_ilostat	<- Rilostat::get_ilostat("STR_WORK_ECO_NB_A") %>% 
  select(iso3c = ref_area, year=time, nworkers_strikes= obs_value, classif1) #Workers involved in strikes and lockouts by economic activity (thousands)

unemployment_rate_ilostat	<- Rilostat::get_ilostat("SDG_0852_SEX_AGE_RT_A") %>% 
  select(iso3c = ref_area, year=time, unemployment_rate= obs_value, sex, classif1)  #Unemployment rate (%) -- Annual

unemployment_rate_ilostat1	<- Rilostat::get_ilostat("SDG_0852_SEX_AGE_RT_A") %>% 
  select(iso3c = ref_area, year=time, unemployment_rate= obs_value, sex, classif1) %>%
  pivot_wider(names_from = c("classif1", "sex"), values_from = "unemployment_rate") #Unemployment rate (%) -- Annual

#Classif1 tiene la edad en este caso

# 3. Recode and rename---------------------------------------------------------------
## Similar a ocde02

# 4. Merge ----------------------------------------------------------------
data_ilo <- lapply(ls(),get)
data_ilo <- Reduce(function(x,y) merge (x, y, by = c("iso3c", "year")))

# 5. Label ----------------------------------------------------------------

# 6. Save -----------------------------------------------------------------
## save data_ilo.rds
