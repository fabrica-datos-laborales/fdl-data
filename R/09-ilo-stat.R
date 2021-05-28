# Code: ILOSTAT --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(Rilostat, tidyverse, googlesheets4, Hmisc)

# 2. Scrapping ------------------------------------------------------------
# Trade union density rate (%) -----------------
ud <- Rilostat::get_ilostat("ILR_TUMT_NOC_RT_A") %>% 
  select(iso3c = ref_area, year=time, ud= obs_value)  %>% 
  mutate(year = as.numeric(year)) 

# Collective bargaining coverage rate (%) -----------------
cbc <- Rilostat::get_ilostat("ILR_CBCT_NOC_RT_A")  %>% 
  select(iso3c = ref_area, year=time, cbc= obs_value) %>% 
  mutate(year = as.numeric(year)) 

# Mean nominal hourly earning of employees (U.S. dollars) -----------------
hour_earn <- Rilostat::get_ilostat("EAR_4HRL_SEX_OCU_CUR_NB_A") %>%
  filter(classif2 == "CUR_TYPE_PPP") %>% 
  select(iso3c = ref_area, year=time, hour_earn= obs_value, sex, classif1) %>% 
  pivot_wider(names_from = c("sex", "classif1"), values_from = "hour_earn") %>% 
  mutate(year = as.numeric(year)) %>%
  select(iso3c, year, hourearn_isco08_total=SEX_T_OCU_ISCO08_TOTAL, hourearn_isco08_1=SEX_T_OCU_ISCO08_1,
         hourearn_isco08_2=SEX_T_OCU_ISCO08_2, hourearn_isco08_3=SEX_T_OCU_ISCO08_3, 
         hourearn_isco08_4=SEX_T_OCU_ISCO08_4, hourearn_isco08_5=SEX_T_OCU_ISCO08_5, 
         hourearn_isco08_6=SEX_T_OCU_ISCO08_6, hourearn_isco08_7=SEX_T_OCU_ISCO08_7, 
         hourearn_isco08_8=SEX_T_OCU_ISCO08_8, hourearn_isco08_9=SEX_T_OCU_ISCO08_9, 
         hourearn_isco08_0=SEX_T_OCU_ISCO08_0, hourearn_isco08_X=SEX_T_OCU_ISCO08_X, 
         hourearn_masc_isco08_total=SEX_M_OCU_ISCO08_TOTAL, hourearn_masc_isco08_1=SEX_M_OCU_ISCO08_1, 
         hourearn_masc_isco08_2=SEX_M_OCU_ISCO08_2, hourearn_masc_isco08_3=SEX_M_OCU_ISCO08_3, 
         hourearn_masc_isco08_4=SEX_M_OCU_ISCO08_4, hourearn_masc_isco08_5=SEX_M_OCU_ISCO08_5, 
         hourearn_masc_isco08_6=SEX_M_OCU_ISCO08_6, hourearn_masc_isco08_7=SEX_M_OCU_ISCO08_7, 
         hourearn_masc_isco08_8=SEX_M_OCU_ISCO08_8, hourearn_masc_isco08_9=SEX_M_OCU_ISCO08_9, 
         hourearn_masc_isco08_0=SEX_M_OCU_ISCO08_0, hourearn_masc_isco08_X=SEX_M_OCU_ISCO08_X, 
         hourearn_fem_isco08_total=SEX_F_OCU_ISCO08_TOTAL, hourearn_fem_isco08_1=SEX_F_OCU_ISCO08_1, 
         hourearn_fem_isco08_2=SEX_F_OCU_ISCO08_2, hourearn_fem_isco08_3=SEX_F_OCU_ISCO08_3, 
         hourearn_fem_isco08_4=SEX_F_OCU_ISCO08_4, hourearn_fem_isco08_5=SEX_F_OCU_ISCO08_5, 
         hourearn_fem_isco08_6=SEX_F_OCU_ISCO08_6, hourearn_fem_isco08_7=SEX_F_OCU_ISCO08_7,
         hourearn_fem_isco08_8=SEX_F_OCU_ISCO08_8, hourearn_fem_isco08_9=SEX_F_OCU_ISCO08_9, 
         hourearn_fem_isco08_0=SEX_F_OCU_ISCO08_0, hourearn_fem_isco08_X=SEX_F_OCU_ISCO08_X, 
         hourearn_isco88_total=SEX_T_OCU_ISCO88_TOTAL, hourearn_isco88_1=SEX_T_OCU_ISCO88_1, 
         hourearn_isco88_2=SEX_T_OCU_ISCO88_2, hourearn_isco88_3=SEX_T_OCU_ISCO88_3, 
         hourearn_isco88_4=SEX_T_OCU_ISCO88_4, hourearn_isco88_5=SEX_T_OCU_ISCO88_5, 
         hourearn_isco88_6=SEX_T_OCU_ISCO88_6, hourearn_isco88_7=SEX_T_OCU_ISCO88_7, 
         hourearn_isco88_8=SEX_T_OCU_ISCO88_8, hourearn_isco88_9=SEX_T_OCU_ISCO88_9, 
         hourearn_isco88_X=SEX_T_OCU_ISCO88_X, hourearn_masc_isco88_total=SEX_M_OCU_ISCO88_TOTAL, 
         hourearn_masc_isco88_1=SEX_M_OCU_ISCO88_1, hourearn_masc_isco88_2=SEX_M_OCU_ISCO88_2, 
         hourearn_masc_isco88_3=SEX_M_OCU_ISCO88_3, hourearn_masc_isco88_4=SEX_M_OCU_ISCO88_4, 
         hourearn_masc_isco88_5=SEX_M_OCU_ISCO88_5, hourearn_masc_isco88_6=SEX_M_OCU_ISCO88_6, 
         hourearn_masc_isco88_7=SEX_M_OCU_ISCO88_7, hourearn_masc_isco88_8=SEX_M_OCU_ISCO88_8, 
         hourearn_masc_isco88_9=SEX_M_OCU_ISCO88_9, hourearn_masc_isco88_X=SEX_M_OCU_ISCO88_X, 
         hourearn_fem_isco88_total=SEX_F_OCU_ISCO88_TOTAL, hourearn_fem_isco88_1=SEX_F_OCU_ISCO88_1,
         hourearn_fem_isco88_2=SEX_F_OCU_ISCO88_2, hourearn_fem_isco88_3=SEX_F_OCU_ISCO88_3, 
         hourearn_fem_isco88_4=SEX_F_OCU_ISCO88_4, hourearn_fem_isco88_5=SEX_F_OCU_ISCO88_5, 
         hourearn_fem_isco88_6=SEX_F_OCU_ISCO88_6, hourearn_fem_isco88_7=SEX_F_OCU_ISCO88_7, 
         hourearn_fem_isco88_8=SEX_F_OCU_ISCO88_8, hourearn_fem_isco88_9=SEX_F_OCU_ISCO88_9, 
         hourearn_fem_isco88_X=SEX_F_OCU_ISCO88_X)
        

# Mean nominal monthly earning of employees (U.S. dollars) ----------------- 
month_earn <- Rilostat::get_ilostat("EAR_XEES_SEX_ECO_NB_M") %>%
  select(iso3c = ref_area, year=time, month_earn= obs_value, sex, classif1, obs_status) %>%
  pivot_wider(names_from = c("obs_status"), values_from = "month_earn") %>%
  group_by(iso3c, year) %>%
  select(G=5, everything()) %>%
  mutate(month_earn = if_else(is.na(G)& is.na(B), U,
                              if_else(is.na(G)&is.na(U), B, G))) %>%
  select(iso3c, year, month_earn) %>%
  mutate(year = str_replace(year, "M", "-")) %>%
  separate(year, c("year", "month"), sep = "-") %>% 
  group_by(iso3c, year) %>%
  summarise(month_earn = mean(month_earn))

#Se filtraron aquellas variables agregadas, los datos son poco fiables y de ruptura de serie
# Se saca un promedio mensual por país y año

# Labour income share as a percent of GDP -----------------
labor_inc_share	<- Rilostat::get_ilostat("LAP_2GDP_NOC_RT_A") %>%
  select(iso3c = ref_area, year=time, labor_inc_share= obs_value, obs_status) %>%
  pivot_wider(names_from = c("obs_status"), values_from = "labor_inc_share") %>%
  group_by(iso3c, year) %>%
  select(G=4, everything()) %>% 
  mutate(labor_inc_share = if_else(is.na(I)&is.na(M), G,
                                   if_else(is.na(I)&is.na(G), M,
                                   if_else(is.na(M)&is.na(G), I, G)))) %>% 
  select(iso3c, year, labor_inc_share)


# Employment by sex and institutional sector (thousands) -----------------
emp_inst <- Rilostat::get_ilostat("EMP_TEMP_SEX_INS_NB_A") %>%
  filter(obs_status != "U") %>% 
  select(iso3c = ref_area, year=time, emp_inst= obs_value,sex, classif1) %>% 
  pivot_wider(names_from = c("sex", "classif1"), values_from = "emp_inst") %>% 
  select(iso3c, year, emp_total=SEX_T_INS_SECTOR_TOTAL, emp_pub=SEX_T_INS_SECTOR_PUB, 
         emp_pri=SEX_T_INS_SECTOR_PRI, emp_masc_total=SEX_M_INS_SECTOR_TOTAL, 
         emp_masc_pub=SEX_M_INS_SECTOR_PUB, emp_masc_pri=SEX_M_INS_SECTOR_PRI, 
         emp_fem_total=SEX_F_INS_SECTOR_TOTAL, emp_fem_pub=SEX_F_INS_SECTOR_PUB, 
         emp_fem_pri=SEX_F_INS_SECTOR_PRI) 

# Employment by sex and status in employment -----------------
emp_status <- Rilostat::get_ilostat("EMP_2EMP_SEX_STE_NB_A") %>% 
  select(iso3c = ref_area, year=time, emp_status= obs_value, sex, classif1) %>% 
  pivot_wider(names_from = c("sex", "classif1"), values_from = "emp_status") %>% 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, emp_total_icse93=SEX_T_STE_ICSE93_TOTAL, emp_total_icse93_1=SEX_T_STE_ICSE93_1, 
         emp_total_icse93_2=SEX_T_STE_ICSE93_2, emp_total_icse93_3=SEX_T_STE_ICSE93_3, 
         emp_total_icse93_5=SEX_T_STE_ICSE93_5, emp_masc_icse93_total=SEX_M_STE_ICSE93_TOTAL, 
         emp_masc_icse93_1=SEX_M_STE_ICSE93_1, emp_masc_icse93_2=SEX_M_STE_ICSE93_2, 
         emp_masc_icse93_3=SEX_M_STE_ICSE93_3, emp_masc_icse93_5=SEX_M_STE_ICSE93_5, 
         emp_fem_icse93_total=SEX_F_STE_ICSE93_TOTAL, emp_fem_icse93_1=SEX_F_STE_ICSE93_1, 
         emp_fem_icse93_2=SEX_F_STE_ICSE93_2, emp_fem_icse93_3=SEX_F_STE_ICSE93_3, 
         emp_fem_icse93_5=SEX_F_STE_ICSE93_5)

# Number of strikes and lockouts by economic activity -----------------
nstrikes_act <- Rilostat::get_ilostat("STR_TSTR_ECO_NB_A") %>%
  select(iso3c = ref_area, year=time, nstrikes_act= obs_value, obs_status,  activity=classif1) %>%
  group_by(iso3c, year) %>% 
  mutate(obs_status = NA)%>% 
  ungroup()  %>% 
  pivot_wider(names_from = c("activity"), values_from = "nstrikes_act") %>%
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, nstrikes_isic31_total=ECO_ISIC3_TOTAL, nstrikes_isic31_D=ECO_ISIC3_D, 
         nstrikes_isic31_E=ECO_ISIC3_E, nstrikes_isic31_F=ECO_ISIC3_F, nstrikes_isic31_G=ECO_ISIC3_G, 
         nstrikes_isic31_H=ECO_ISIC3_H, nstrikes_isic31_I=ECO_ISIC3_I, nstrikes_isic31_J=ECO_ISIC3_J, 
         nstrikes_isic31_N=ECO_ISIC3_N, nstrikes_isic31_X=ECO_ISIC3_X, nstrikes_sector_total=ECO_SECTOR_TOTAL, 
         nstrikes_isic31_K=ECO_ISIC3_K, nstrikes_isic2_total=ECO_ISIC2_TOTAL, nstrikes_isic2_6=ECO_ISIC2_6, 
         nstrikes_isic2_5=ECO_ISIC2_5, nstrikes_isic2_2=ECO_ISIC2_2, nstrikes_isic2_3=ECO_ISIC2_3, 
         nstrikes_isic2_4=ECO_ISIC2_4, nstrikes_isic2_7=ECO_ISIC2_7, nstrikes_isic2_8=ECO_ISIC2_8, 
         nstrikes_isic2_9=ECO_ISIC2_9, nstrikes_isic31_A=ECO_ISIC3_A, nstrikes_isic31_B=ECO_ISIC3_B, 
         nstrikes_isic31_C=ECO_ISIC3_C, nstrikes_isic31_L=ECO_ISIC3_L, nstrikes_isic31_M=ECO_ISIC3_M, 
         nstrikes_isic31_O=ECO_ISIC3_O, nstrikes_isic31_Q=ECO_ISIC3_Q, nstrikes_isic2_1=ECO_ISIC2_1, 
         nstrikes_isic4_total=ECO_ISIC4_TOTAL, nstrikes_isic2_0=ECO_ISIC2_0, nstrikes_isic4_B=ECO_ISIC4_B, 
         nstrikes_isic4_C=ECO_ISIC4_C, nstrikes_isic4_D=ECO_ISIC4_D, nstrikes_isic4_E=ECO_ISIC4_E, 
         nstrikes_isic4_F=ECO_ISIC4_F, nstrikes_isic4_G=ECO_ISIC4_G, nstrikes_isic4_H=ECO_ISIC4_H, 
         nstrikes_isic4_I=ECO_ISIC4_I, nstrikes_isic4_J=ECO_ISIC4_J, nstrikes_isic4_M=ECO_ISIC4_M, 
         nstrikes_isic4_N=ECO_ISIC4_N, nstrikes_isic4_O=ECO_ISIC4_O, nstrikes_isic4_P=ECO_ISIC4_P, 
         nstrikes_isic4_Q=ECO_ISIC4_Q, nstrikes_isic4_R=ECO_ISIC4_R, nstrikes_isic4_S=ECO_ISIC4_S,
         nstrikes_isic4_K=ECO_ISIC4_K, nstrikes_isic4_A=ECO_ISIC4_A, nstrikes_isic4_L=ECO_ISIC4_L, 
         nstrikes_isic4_T=ECO_ISIC4_T, nstrikes_isic4_U=ECO_ISIC4_U, nstrikes_isic4_X=ECO_ISIC4_X, 
         nstrikes_isic31_P=ECO_ISIC3_P)

# Days not worked due to strikes and lockouts by economic activity -----------------
ndays_strikes	<- Rilostat::get_ilostat("STR_DAYS_ECO_NB_A") %>% 
  select(iso3c = ref_area, year=time, ndays_strikes= obs_value, activity=classif1, obs_status) %>%
  group_by(iso3c, year) %>% 
  mutate(obs_status = NA) %>% 
  ungroup() %>%
  pivot_wider(names_from = c("activity"), values_from = ("ndays_strikes")) %>% 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, ndays_isic31_total=ECO_ISIC3_TOTAL, ndays_isic31_D=ECO_ISIC3_D, 
         ndays_isic31_E=ECO_ISIC3_E, ndays_isic31_F=ECO_ISIC3_F, ndays_isic31_G=ECO_ISIC3_G, 
         ndays_isic31_H=ECO_ISIC3_H, ndays_isic31_I=ECO_ISIC3_I, ndays_isic31_J=ECO_ISIC3_J, 
         ndays_isic31_N=ECO_ISIC3_N, ndays_isic31_X=ECO_ISIC3_X, ndays_sector_total=ECO_SECTOR_TOTAL, 
         ndays_isic31_K=ECO_ISIC3_K, ndays_isic2_total=ECO_ISIC2_TOTAL, ndays_isic2_6=ECO_ISIC2_6, 
         ndays_isic2_5=ECO_ISIC2_5, ndays_isic2_2=ECO_ISIC2_2, ndays_isic2_3=ECO_ISIC2_3, 
         ndays_isic2_4=ECO_ISIC2_4, ndays_isic2_7=ECO_ISIC2_7, ndays_isic2_8=ECO_ISIC2_8, 
         ndays_isic2_9=ECO_ISIC2_9, ndays_isic31_A=ECO_ISIC3_A, ndays_isic31_B=ECO_ISIC3_B, 
         ndays_isic31_C=ECO_ISIC3_C, ndays_isic31_L=ECO_ISIC3_L, ndays_isic31_M=ECO_ISIC3_M, 
         ndays_isic31_O=ECO_ISIC3_O, ndays_isic31_Q=ECO_ISIC3_Q, ndays_isic2_1=ECO_ISIC2_1, 
         ndays_isic4_total=ECO_ISIC4_TOTAL, ndays_isic2_0=ECO_ISIC2_0, ndays_isic4_B=ECO_ISIC4_B, 
         ndays_isic4_C=ECO_ISIC4_C, ndays_isic4_D=ECO_ISIC4_D, ndays_isic4_E=ECO_ISIC4_E, 
         ndays_isic4_F=ECO_ISIC4_F, ndays_isic4_G=ECO_ISIC4_G, ndays_isic4_H=ECO_ISIC4_H, 
         ndays_isic4_I=ECO_ISIC4_I, ndays_isic4_J=ECO_ISIC4_J, ndays_isic4_M=ECO_ISIC4_M, 
         ndays_isic4_N=ECO_ISIC4_N, ndays_isic4_O=ECO_ISIC4_O, ndays_isic4_P=ECO_ISIC4_P, 
         ndays_isic4_Q=ECO_ISIC4_Q, ndays_isic4_R=ECO_ISIC4_R, ndays_isic4_S=ECO_ISIC4_S,
         ndays_isic4_K=ECO_ISIC4_K, ndays_isic4_A=ECO_ISIC4_A, ndays_isic4_L=ECO_ISIC4_L, 
         ndays_isic4_T=ECO_ISIC4_T, ndays_isic4_U=ECO_ISIC4_U, ndays_isic4_X=ECO_ISIC4_X, 
         ndays_isic31_P=ECO_ISIC3_P)

# Workers involved in strikes and lockouts by economic activity (thousands) -----------------
nworkers_strikes	<- Rilostat::get_ilostat("STR_WORK_ECO_NB_A") %>% 
  select(iso3c = ref_area, year=time, nworkers_strikes= obs_value, classif1, obs_status) %>%
  group_by(iso3c, year) %>% 
  mutate(obs_status = NA) %>% 
  ungroup() %>%
  pivot_wider(names_from = c("classif1"), values_from = ("nworkers_strikes")) %>% 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, nworkers_isic31_total=ECO_ISIC3_TOTAL, nworkers_isic31_E=ECO_ISIC3_E, 
         nworkers_isic31_F=ECO_ISIC3_F, nworkers_isic31_G=ECO_ISIC3_G, nworkers_isic31_H=ECO_ISIC3_H, 
         nworkers_isic31_I=ECO_ISIC3_I, nworkers_isic31_J=ECO_ISIC3_J, nworkers_isic31_N=ECO_ISIC3_N, 
         nworkers_isic31_X=ECO_ISIC3_X, nworkers_sector_total=ECO_SECTOR_TOTAL, 
         nworkers_sector_nag=ECO_SECTOR_NAG, nworkers_sector_ind=ECO_SECTOR_IND, nworkers_sector_X=ECO_SECTOR_X, 
         nworkers_isic31_K=ECO_ISIC3_K, nworkers_sector_ser=ECO_SECTOR_SER, nworkers_isic2_total=ECO_ISIC2_TOTAL, 
         nworkers_isic2_6=ECO_ISIC2_6, nworkers_isic2_5=ECO_ISIC2_5, nworkers_isic2_2=ECO_ISIC2_2, 
         nworkers_isic2_3=ECO_ISIC2_3, nworkers_isic2_4=ECO_ISIC2_4, nworkers_isic2_7=ECO_ISIC2_7, 
         nworkers_isic2_8=ECO_ISIC2_8, nworkers_isic2_9=ECO_ISIC2_9, nworkers_isic31_A=ECO_ISIC3_A, 
         nworkers_isic31_B=ECO_ISIC3_B, nworkers_isic31_C=ECO_ISIC3_C, nworkers_isic31_D=ECO_ISIC3_D, 
         nworkers_isic31_L=ECO_ISIC3_L, nworkers_isic31_M=ECO_ISIC3_M, nworkers_isic31_O=ECO_ISIC3_O, 
         nworkers_isic31_Q=ECO_ISIC3_Q, nworkers_isic2_1=ECO_ISIC2_1, nworkers_isic2_0=ECO_ISIC2_0, 
         nworkers_isic4_B=ECO_ISIC4_B, nworkers_isic4_C=ECO_ISIC4_C, nworkers_isic4_D=ECO_ISIC4_D, 
         nworkers_isic4_E=ECO_ISIC4_E, nworkers_isic4_F=ECO_ISIC4_F, nworkers_isic4_G=ECO_ISIC4_G, 
         nworkers_isic4_H=ECO_ISIC4_H, nworkers_isic4_I=ECO_ISIC4_I, nworkers_isic4_J=ECO_ISIC4_J, 
         nworkers_isic4_M=ECO_ISIC4_M, nworkers_isic4_N=ECO_ISIC4_N, nworkers_isic4_O=ECO_ISIC4_O, 
         nworkers_isic4_P=ECO_ISIC4_P, nworkers_isic4_Q=ECO_ISIC4_Q, nworkers_isic4_R=ECO_ISIC4_R, 
         nworkers_isic4_S=ECO_ISIC4_S, nworkers_isic4_K=ECO_ISIC4_K, nworkers_isic4_total=ECO_ISIC4_TOTAL, 
         nworkers_isic4_A=ECO_ISIC4_A, nworkers_isic4_L=ECO_ISIC4_L, nworkers_isic4_T=ECO_ISIC4_T, 
         nworkers_isic4_U=ECO_ISIC4_U, nworkers_isic4_X=ECO_ISIC4_X, nworkers_isic31_P=ECO_ISIC3_P)

# Unemployment rate (%) -- Annual -----------------
unemployment_rate	<- Rilostat::get_ilostat("SDG_0852_SEX_AGE_RT_A") %>% 
  select(iso3c = ref_area, year=time, unemployment_rate= obs_value, sex, classif1, obs_status) %>%
  group_by(iso3c, year) %>% 
  mutate(obs_status = NA) %>% 
  ungroup() %>%
  pivot_wider(names_from = c("classif1", "sex"), values_from = "unemployment_rate") %>% 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, unemp_total_15="AGE_YTHADULT_YGE15_SEX_T", unemp_total_1564="AGE_YTHADULT_Y15-64_SEX_T", 
         unemp_total_1524="AGE_YTHADULT_Y15-24_SEX_T", unemp_total_25="AGE_YTHADULT_YGE25_SEX_T", 
         unemp_masc_15="AGE_YTHADULT_YGE15_SEX_M", unemp_masc_1564="AGE_YTHADULT_Y15-64_SEX_M", 
         unemp_masc_1524="AGE_YTHADULT_Y15-24_SEX_M", unemp_masc_25="AGE_YTHADULT_YGE25_SEX_M", 
         unemp_fem_15="AGE_YTHADULT_YGE15_SEX_F", unemp_fem_1564="AGE_YTHADULT_Y15-64_SEX_F", 
         unemp_fem_1524="AGE_YTHADULT_Y15-24_SEX_F", unemp_fem_25="AGE_YTHADULT_YGE25_SEX_F", 
         unemp_other_15="AGE_YTHADULT_YGE15_SEX_O", unemp_other_1524="AGE_YTHADULT_Y15-24_SEX_O", 
         unemp_other_25="AGE_YTHADULT_YGE25_SEX_O")

# 3. Recode and rename---------------------------------------------------------------
## Similar a ocde02

# 4. Merge ----------------------------------------------------------------
data_ilo <- lapply(ls(),get)
data_ilo <- Reduce(function(x,y) merge(x = x, y = y, by = c("iso3c", "year"), all = T), 
                   list(ud, cbc, hour_earn, month_earn, labor_inc_share, emp_inst, emp_status, nstrikes_act, 
                        ndays_strikes, nworkers_strikes, unemployment_rate)) %>% 
  mutate(year = as.numeric(year))

# 5. Label ----------------------------------------------------------------
# Llamar etiquetas (en slice se indican los tramos)
labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                                    range = c("B5:C637"), col_names = F) %>%
  slice(c(1,2,349:632)) %>% # selecciono 1, 2, donde parte -5, donde termina -5
  select(variables = 1, etiquetas = 2)

## Tranformar a vectornames
var.labels <- as.character(labels$etiquetas)
names(var.labels) <- labels$variables
## Etiquetar
label(data_ilo) = as.list(var.labels[match(names(data_ilo), names(data_ilo))])

# 6. Save -----------------------------------------------------------------
## save ilo-stat.rds
saveRDS(data_ilo, file = "output/data/proc/ilo-stat.rds")

