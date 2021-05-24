# Code: ILOSTAT --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(Rilostat, tidyverse)

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
#isco08_2
hour_earn <- Rilostat::get_ilostat("EAR_4HRL_SEX_OCU_CUR_NB_A") %>%
  filter(classif2 == "CUR_TYPE_PPP") %>% 
  select(iso3c = ref_area, year=time, hour_earn= obs_value, sex, classif1) %>% 
  pivot_wider(names_from = c("sex", "classif1"), values_from = "hour_earn") %>% 
  mutate(year = as.numeric(year)) %>%
  select(iso3c, year, sex_t_ocu_total =SEX_T_OCU_ISCO08_TOTAL, sex_t_ocu1=SEX_T_OCU_ISCO08_1, 
         sex_t_ocu2=SEX_T_OCU_ISCO08_2, sex_t_ocu3=SEX_T_OCU_ISCO08_3, sex_t_ocu4=SEX_T_OCU_ISCO08_4,
         sex_t_ocu5=SEX_T_OCU_ISCO08_5, sex_t_ocu6=SEX_T_OCU_ISCO08_6, sex_t_ocu7=SEX_T_OCU_ISCO08_7, 
         sex_t_ocu8=SEX_T_OCU_ISCO08_8, sex_t_ocu9=SEX_T_OCU_ISCO08_9, sex_m_ocu_total=SEX_M_OCU_ISCO08_TOTAL,
         sex_m_ocu1=SEX_M_OCU_ISCO08_1, sex_m_ocu2=SEX_M_OCU_ISCO08_2, sex_m_ocu3=SEX_M_OCU_ISCO08_3,
         sex_m_ocu4=SEX_M_OCU_ISCO08_4, sex_m_ocu5=SEX_M_OCU_ISCO08_5, sex_m_ocu6=SEX_M_OCU_ISCO08_6,
         sex_m_ocu7=SEX_M_OCU_ISCO08_7, sex_m_ocu8=SEX_M_OCU_ISCO08_8, sex_m_ocu9=SEX_M_OCU_ISCO08_9,
         sex_f_ocu_total=SEX_F_OCU_ISCO08_TOTAL, sex_f_ocu1=SEX_F_OCU_ISCO08_1, sex_f_ocu2=SEX_F_OCU_ISCO08_2, 
         sex_f_ocu3=SEX_F_OCU_ISCO08_3, sex_f_ocu4=SEX_F_OCU_ISCO08_4, sex_f_ocu5=SEX_F_OCU_ISCO08_5, 
         sex_f_ocu6=SEX_F_OCU_ISCO08_6,sex_f_ocu7=SEX_F_OCU_ISCO08_7, sex_f_ocu8=SEX_F_OCU_ISCO08_8, 
         sex_f_ocu9=SEX_F_OCU_ISCO08_9, sex_t_ocu0=SEX_T_OCU_ISCO08_0,sex_t_ocuX=SEX_T_OCU_ISCO08_X,
         sex_m_ocu0=SEX_M_OCU_ISCO08_0, sex_m_ocuX=SEX_M_OCU_ISCO08_X, sex_f_ocu0=SEX_F_OCU_ISCO08_0,
         sex_f_ocuX=SEX_F_OCU_ISCO08_X, SEX_T_OCU_ISCO88_TOTAL,SEX_T_OCU_ISCO88_1, SEX_T_OCU_ISCO88_2,
         SEX_T_OCU_ISCO88_3, SEX_T_OCU_ISCO88_4, SEX_T_OCU_ISCO88_5, SEX_T_OCU_ISCO88_6, SEX_T_OCU_ISCO88_7,
         SEX_T_OCU_ISCO88_8, SEX_T_OCU_ISCO88_9, SEX_M_OCU_ISCO88_TOTAL, SEX_M_OCU_ISCO88_1, 
         SEX_M_OCU_ISCO88_2, SEX_M_OCU_ISCO88_3, SEX_M_OCU_ISCO88_4, SEX_M_OCU_ISCO88_5, SEX_M_OCU_ISCO88_6,
         SEX_M_OCU_ISCO88_7, SEX_M_OCU_ISCO88_8, SEX_M_OCU_ISCO88_9, SEX_F_OCU_ISCO88_TOTAL, SEX_F_OCU_ISCO88_1,
         SEX_F_OCU_ISCO88_2, SEX_F_OCU_ISCO88_3, SEX_F_OCU_ISCO88_4, SEX_F_OCU_ISCO88_5, SEX_F_OCU_ISCO88_6,
         SEX_F_OCU_ISCO88_7, SEX_F_OCU_ISCO88_8, SEX_F_OCU_ISCO88_9, SEX_T_OCU_ISCO88_X, SEX_M_OCU_ISCO88_X,
         SEX_F_OCU_ISCO88_X) #Que hago con los 88
    

#sexo_total/masculino/femenino_ocupaci?nN?mero_(total)
#X Not elsewhere classified
#0 Armed forces occupations
#1 Managers
#2 Professionals
#3 Technicians and associate professionals
#4 Clerical support workers
#5 Service and sales workers
#6 Skilled agricultural, forestry and fishery workers
#7 Craft and related trades workers
#8 Plant and machine operators, and assemblers
#9 Elementary occupations

# Mean nominal monthly earning of employees (U.S. dollars) ----------------- 
month_earn <- Rilostat::get_ilostat("EAR_XEES_SEX_ECO_NB_M") %>% 
  select(iso3c = ref_area, year=time, month_earn= obs_value, sex, classif1) %>% 
  pivot_wider(names_from = c("sex", "classif1"), values_from = "month_earn") %>% 
  mutate(year = as.numeric(year)) %>%
  select(iso3c, year, SEX_T_ECO_SECTOR_TOTAL, SEX_T_ECO_SECTOR_AGR, SEX_T_ECO_SECTOR_NAG, SEX_T_ECO_SECTOR_IND,
         SEX_T_ECO_SECTOR_SER, SEX_M_ECO_SECTOR_TOTAL, SEX_M_ECO_SECTOR_AGR, SEX_M_ECO_SECTOR_IND, 
         SEX_M_ECO_SECTOR_SER, SEX_F_ECO_SECTOR_TOTAL, SEX_F_ECO_SECTOR_AGR, SEX_F_ECO_SECTOR_IND,
         SEX_F_ECO_SECTOR_SER, SEX_T_ECO_SECTOR_X, SEX_F_ECO_SECTOR_X, SEX_M_ECO_SECTOR_X,
         SEX_M_ECO_SECTOR_NAG, SEX_F_ECO_SECTOR_NAG) #Se filtraron aquellas variables agregadas

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
## Poner en definicion que datos provienen de datos administrativos o imputados o modelos

# Employment by sex and institutional sector (thousands) -----------------
emp_inst <- Rilostat::get_ilostat("EMP_TEMP_SEX_INS_NB_A") %>%
  filter(obs_status != "U") %>% 
  select(iso3c = ref_area, year=time, emp_inst= obs_value,sex, classif1) %>% 
  pivot_wider(names_from = c("sex", "classif1"), values_from = "emp_inst") %>% 
  select(iso3c, year, total_sec_total=SEX_T_INS_SECTOR_TOTAL, total_pub=SEX_T_INS_SECTOR_PUB, 
         total_pri=SEX_T_INS_SECTOR_PRI, masc_sec_total=SEX_M_INS_SECTOR_TOTAL, 
         masc_pub=SEX_M_INS_SECTOR_PUB, masc_pri=SEX_M_INS_SECTOR_PRI, 
         fem_sec_total=SEX_F_INS_SECTOR_TOTAL, fem_pub=SEX_F_INS_SECTOR_PUB, 
         fem_pri=SEX_F_INS_SECTOR_PRI) #Ac? me salen todas las variables como listas y no logr? cambiarlas

# Employment by sex and status in employment -----------------
emp_status <- Rilostat::get_ilostat("EMP_2EMP_SEX_STE_NB_A") %>% 
  select(iso3c = ref_area, year=time, emp_status= obs_value, sex, classif1) %>% 
  pivot_wider(names_from = c("sex", "classif1"), values_from = "emp_status") %>% 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, total_status_total=SEX_T_STE_ICSE93_TOTAL, total_status1=SEX_T_STE_ICSE93_1, 
         total_status2=SEX_T_STE_ICSE93_2, total_status3=SEX_T_STE_ICSE93_3, total_status5=SEX_T_STE_ICSE93_5,
         masc_status_total=SEX_M_STE_ICSE93_TOTAL, masc_status1=SEX_M_STE_ICSE93_1, masc_status2=SEX_M_STE_ICSE93_2, 
         masc_status3=SEX_M_STE_ICSE93_3, masc_status5=SEX_M_STE_ICSE93_5, fem_status_total=SEX_F_STE_ICSE93_TOTAL, 
         fem_status1=SEX_F_STE_ICSE93_1, fem_status2=SEX_F_STE_ICSE93_2, fem_status3=SEX_F_STE_ICSE93_3, 
         fem_status5=SEX_F_STE_ICSE93_5) #Se filtraron los aggregates

#1 Employees
#2 Employers
#3 Own-account workers
#5 Contributing family workers

# Number of strikes and lockouts by economic activity -----------------
nstrikes_act <- Rilostat::get_ilostat("STR_TSTR_ECO_NB_A") %>%
  select(iso3c = ref_area, year=time, nstrikes_act= obs_value, obs_status,  activity=classif1) %>%
  group_by(iso3c, year) %>% 
  mutate(obs_status = NA)%>% 
  ungroup()  %>% 
  pivot_wider(names_from = c("activity"), values_from = "nstrikes_act") 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, ECO_ISIC3_TOTAL, ECO_ISIC3_D, ECO_ISIC3_E, ECO_ISIC3_F, ECO_ISIC3_G,
         ECO_ISIC3_H, ECO_ISIC3_I, ECO_ISIC3_J, ECO_ISIC3_N, ECO_ISIC3_X, ECO_SECTOR_TOTAL, ECO_ISIC3_K,        
         ECO_ISIC2_TOTAL, ECO_ISIC2_6, ECO_ISIC2_5, ECO_ISIC2_2, ECO_ISIC2_3, ECO_ISIC2_4, ECO_ISIC2_7,
         ECO_ISIC2_8, ECO_ISIC2_9, ECO_ISIC3_A, ECO_ISIC3_B, ECO_ISIC3_C, ECO_ISIC3_L, ECO_ISIC3_M,
         ECO_ISIC3_O, ECO_ISIC3_Q, ECO_ISIC2_1, ECO_ISIC4_TOTAL, ECO_ISIC2_0, ECO_ISIC4_B, ECO_ISIC4_C,
         ECO_ISIC4_D, ECO_ISIC4_E, ECO_ISIC4_F, ECO_ISIC4_G, ECO_ISIC4_H, ECO_ISIC4_I, ECO_ISIC4_J,
         ECO_ISIC4_M, ECO_ISIC4_N, ECO_ISIC4_O, ECO_ISIC4_P, ECO_ISIC4_Q, ECO_ISIC4_R, ECO_ISIC4_S,
         ECO_ISIC4_K, ECO_ISIC4_A, ECO_ISIC4_L, ECO_ISIC4_T, ECO_ISIC4_U, ECO_ISIC4_X, ECO_ISIC3_P)

#ISIC3
#A Agriculture, hunting and forestry
#B Fishing
#C Mining and quarrying
#D Manufacturing
#E Electricity, gas and water supply
#F Construction
#G Wholesale and retail trade; repair of motor vehicles, motorcycles and personal and household goods
#H Hotels and restaurants
#I Transport, storage and communications
#J Financial intermediation
#K Real estate, renting and business activities
#L Public administration and defence; compulsory social security
#M Education
#N Health and social work
#O. Other community, social and personal service activities
#P. Activities of private households as employers and undifferentiated production activities of private households

#ISIC4
#B. Mining and quarrying
#C. Manufacturing
#D. Electricity; gas, steam and air conditioning supply
#E. Water supply; sewerage, waste management and remediation activities
#F. Construction
#G. Wholesale and retail trade; repair of motor vehicles and motorcycles
#H. Transportation and storage
#I. Accommodation and food service activities
#J. Information and communication
#K. Financial and insurance activities
#L. Real estate activities
#M. Professional, scientific and technical activities
#N. Administrative and support service activities
#O. Public administration and defence; compulsory social security
#P. Education
#Q. Human health and social work activities
#R. Arts, entertainment and recreation	
#S. Other service activities
#T. Activities of households as employers; undifferentiated goods- and services-producing activities of households for own use
#U. Activities of extraterritorial organizations and bodies
#X. Not elsewhere classified

# Days not worked due to strikes and lockouts by economic activity -----------------
ndays_strikes	<- Rilostat::get_ilostat("STR_DAYS_ECO_NB_A") %>% 
  select(iso3c = ref_area, year=time, ndays_strikes= obs_value, activity=classif1) %>%
  pivot_wider(names_from = c("activity"), values_from = ("ndays_strikes")) %>% 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, ECO_ISIC3_TOTAL, ECO_ISIC3_D, ECO_ISIC3_E, ECO_ISIC3_F, ECO_ISIC3_G,
         ECO_ISIC3_H, ECO_ISIC3_I, ECO_ISIC3_J, ECO_ISIC3_N, ECO_ISIC3_X, ECO_SECTOR_TOTAL, ECO_ISIC3_K,        
         ECO_ISIC2_TOTAL, ECO_ISIC2_6, ECO_ISIC2_5, ECO_ISIC2_2, ECO_ISIC2_3, ECO_ISIC2_4, ECO_ISIC2_7,
         ECO_ISIC2_8, ECO_ISIC2_9, ECO_ISIC3_A, ECO_ISIC3_B, ECO_ISIC3_C, ECO_ISIC3_L, ECO_ISIC3_M,
         ECO_ISIC3_O, ECO_ISIC3_Q, ECO_ISIC2_1, ECO_ISIC4_TOTAL, ECO_ISIC2_0, ECO_ISIC4_B, ECO_ISIC4_C,
         ECO_ISIC4_D, ECO_ISIC4_E, ECO_ISIC4_F, ECO_ISIC4_G, ECO_ISIC4_H, ECO_ISIC4_I, ECO_ISIC4_J,
         ECO_ISIC4_M, ECO_ISIC4_N, ECO_ISIC4_O, ECO_ISIC4_P, ECO_ISIC4_Q, ECO_ISIC4_R, ECO_ISIC4_S,
         ECO_ISIC4_K, ECO_ISIC4_A, ECO_ISIC4_L, ECO_ISIC4_T, ECO_ISIC4_U, ECO_ISIC4_X, ECO_ISIC3_P)

nworkers_strikes	<- Rilostat::get_ilostat("STR_WORK_ECO_NB_A") %>% 
  select(iso3c = ref_area, year=time, nworkers_strikes= obs_value, classif1) #Workers involved in strikes and lockouts by economic activity (thousands)

unemployment_rate	<- Rilostat::get_ilostat("SDG_0852_SEX_AGE_RT_A") %>% 
  select(iso3c = ref_area, year=time, unemployment_rate= obs_value, sex, classif1) %>%
  pivot_wider(names_from = c("classif1", "sex"), values_from = "unemployment_rate") #Unemployment rate (%) -- Annual


# 3. Recode and rename---------------------------------------------------------------
## Similar a ocde02

# 4. Merge ----------------------------------------------------------------
data_ilo <- lapply(ls(),get)
data_ilo <- Reduce(function(x,y) merge (x, y, by = c("iso3c", "year")))

# 5. Label ----------------------------------------------------------------

# 6. Save -----------------------------------------------------------------
## save data_ilo.rds
