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
  select(iso3c, year, total_isco08_total =SEX_T_OCU_ISCO08_TOTAL, total_isco08_1=SEX_T_OCU_ISCO08_1, 
         total_isco08_2=SEX_T_OCU_ISCO08_2, total_isco08_3=SEX_T_OCU_ISCO08_3, 
         total_isco08_4=SEX_T_OCU_ISCO08_4, total_isco08_5=SEX_T_OCU_ISCO08_5, total_isco08_6=SEX_T_OCU_ISCO08_6, 
         total_isco08_7=SEX_T_OCU_ISCO08_7, total_isco08_8=SEX_T_OCU_ISCO08_8, total_isco08_9=SEX_T_OCU_ISCO08_9, 
         masc_isco08_total=SEX_M_OCU_ISCO08_TOTAL, masc_isco08_1=SEX_M_OCU_ISCO08_1, masc_isco08_2=SEX_M_OCU_ISCO08_2, 
         masc_isco08_3=SEX_M_OCU_ISCO08_3, masc_isco08_4=SEX_M_OCU_ISCO08_4, masc_isco08_5=SEX_M_OCU_ISCO08_5, 
         masc_isco08_6=SEX_M_OCU_ISCO08_6, masc_isco08_7=SEX_M_OCU_ISCO08_7, masc_isco08_8=SEX_M_OCU_ISCO08_8, 
         masc_isco08_9=SEX_M_OCU_ISCO08_9, fem_isco08_total=SEX_F_OCU_ISCO08_TOTAL, fem_isco08_1=SEX_F_OCU_ISCO08_1,
         fem_isco08_2=SEX_F_OCU_ISCO08_2, fem_isco08_3=SEX_F_OCU_ISCO08_3, fem_isco08_4=SEX_F_OCU_ISCO08_4, 
         fem_isco08_5=SEX_F_OCU_ISCO08_5, fem_isco08_6=SEX_F_OCU_ISCO08_6, fem_isco08_7=SEX_F_OCU_ISCO08_7,
         fem_isco08_8=SEX_F_OCU_ISCO08_8, fem_isco08_9=SEX_F_OCU_ISCO08_9, total_isco08_0=SEX_T_OCU_ISCO08_0,
         total_isco08_X=SEX_T_OCU_ISCO08_X, masc_isco08_0=SEX_M_OCU_ISCO08_0, masc_isco08_X=SEX_M_OCU_ISCO08_X, 
         fem_isco08_0=SEX_F_OCU_ISCO08_0, fem_isco08_X=SEX_F_OCU_ISCO08_X, total_isco88_total=SEX_T_OCU_ISCO88_TOTAL,
         total_isco88_1=SEX_T_OCU_ISCO88_1, total_isco88_2=SEX_T_OCU_ISCO88_2, total_isco88_3=SEX_T_OCU_ISCO88_3, 
         total_isco88_4=SEX_T_OCU_ISCO88_4, total_isco88_5=SEX_T_OCU_ISCO88_5, total_isco88_6=SEX_T_OCU_ISCO88_6, 
         total_isco88_7=SEX_T_OCU_ISCO88_7, total_isco88_8=SEX_T_OCU_ISCO88_8, total_isco88_9=SEX_T_OCU_ISCO88_9, 
         masc_isco88_total=SEX_M_OCU_ISCO88_TOTAL, masc_isco88_1=SEX_M_OCU_ISCO88_1, masc_isco88_2=SEX_M_OCU_ISCO88_2, 
         masc_isco88_3=SEX_M_OCU_ISCO88_3, masc_isco88_4=SEX_M_OCU_ISCO88_4, masc_isco88_5=SEX_M_OCU_ISCO88_5, 
         masc_isco88_6=SEX_M_OCU_ISCO88_6, masc_isco88_7=SEX_M_OCU_ISCO88_7, masc_isco88_8=SEX_M_OCU_ISCO88_8, 
         masc_isco88_9=SEX_M_OCU_ISCO88_9, fem_isco88_total=SEX_F_OCU_ISCO88_TOTAL, fem_isco88_1=SEX_F_OCU_ISCO88_1,
         fem_isco88_2=SEX_F_OCU_ISCO88_2, fem_isco88_3=SEX_F_OCU_ISCO88_3, fem_isco88_4=SEX_F_OCU_ISCO88_4, 
         fem_isco88_5=SEX_F_OCU_ISCO88_5, fem_isco88_6=SEX_F_OCU_ISCO88_6, fem_isco88_7=SEX_F_OCU_ISCO88_7, 
         fem_isco88_8=SEX_F_OCU_ISCO88_8, fem_isco88_9=SEX_F_OCU_ISCO88_9, total_isco88_X=SEX_T_OCU_ISCO88_X, 
         masc_isco88_X=SEX_M_OCU_ISCO88_X, fem_isco88_X=SEX_F_OCU_ISCO88_X) 

# Mean nominal monthly earning of employees (U.S. dollars) ----------------- 
# month_earn <- Rilostat::get_ilostat("EAR_XEES_SEX_ECO_NB_M") %>% 
#   select(iso3c = ref_area, year=time, month_earn= obs_value, sex, classif1, obs_status) %>% 
#   pivot_wider(names_from = c("obs_status"), values_from = "month_earn") %>%
#   group_by(iso3c, year) %>%
#   select(G=5, everything()) %>% 
#   mutate(month_earn = if_else(is.na(G)& is.na(B), U, 
#                               if_else(is.na(G)&is.na(U), B, G))) %>% 
#   select(iso3c, year, month_earn)

#Se filtraron aquellas variables agregadas, los datos son poco fiables y de ruptura de serie


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
  select(iso3c, year, total_sec_total=SEX_T_INS_SECTOR_TOTAL, total_pub=SEX_T_INS_SECTOR_PUB, 
         total_pri=SEX_T_INS_SECTOR_PRI, masc_sec_total=SEX_M_INS_SECTOR_TOTAL, 
         masc_pub=SEX_M_INS_SECTOR_PUB, masc_pri=SEX_M_INS_SECTOR_PRI, 
         fem_sec_total=SEX_F_INS_SECTOR_TOTAL, fem_pub=SEX_F_INS_SECTOR_PUB, 
         fem_pri=SEX_F_INS_SECTOR_PRI) 

# Employment by sex and status in employment -----------------
emp_status <- Rilostat::get_ilostat("EMP_2EMP_SEX_STE_NB_A") %>% 
  select(iso3c = ref_area, year=time, emp_status= obs_value, sex, classif1) %>% 
  pivot_wider(names_from = c("sex", "classif1"), values_from = "emp_status") %>% 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, total_icse93=SEX_T_STE_ICSE93_TOTAL, total_icse93_1=SEX_T_STE_ICSE93_1, 
         total_icse93_2=SEX_T_STE_ICSE93_2, total_icse93_3=SEX_T_STE_ICSE93_3, total_icse93_5=SEX_T_STE_ICSE93_5,
         masc_icse93_total=SEX_M_STE_ICSE93_TOTAL, masc_icse93_1=SEX_M_STE_ICSE93_1, masc_icse93_2=SEX_M_STE_ICSE93_2, 
         masc_icse93_3=SEX_M_STE_ICSE93_3, masc_icse93_5=SEX_M_STE_ICSE93_5, fem__icse93_total=SEX_F_STE_ICSE93_TOTAL, 
         fem_icse93_1=SEX_F_STE_ICSE93_1, fem_icse93_2=SEX_F_STE_ICSE93_2, fem_icse93_3=SEX_F_STE_ICSE93_3, 
         fem_icse93_5=SEX_F_STE_ICSE93_5)

# Number of strikes and lockouts by economic activity -----------------
nstrikes_act <- Rilostat::get_ilostat("STR_TSTR_ECO_NB_A") %>%
  select(iso3c = ref_area, year=time, nstrikes_act= obs_value, obs_status,  activity=classif1) %>%
  group_by(iso3c, year) %>% 
  mutate(obs_status = NA)%>% 
  ungroup()  %>% 
  pivot_wider(names_from = c("activity"), values_from = "nstrikes_act") %>%
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, isic31_total=ECO_ISIC3_TOTAL, isic31_D=ECO_ISIC3_D, isic31_E=ECO_ISIC3_E, isic31_F=ECO_ISIC3_F, 
         isic31_G=ECO_ISIC3_G, isic31_H=ECO_ISIC3_H, isic31_I=ECO_ISIC3_I, isic31_J=ECO_ISIC3_J, isic31_N=ECO_ISIC3_N, 
         isic31_X=ECO_ISIC3_X, sector_total=ECO_SECTOR_TOTAL, isic31_K=ECO_ISIC3_K, isic2_total=ECO_ISIC2_TOTAL, 
         isic2_6=ECO_ISIC2_6, isic2_5=ECO_ISIC2_5, isic2_2=ECO_ISIC2_2, isic2_3=ECO_ISIC2_3, isic2_4=ECO_ISIC2_4, 
         isic2_7=ECO_ISIC2_7, isic2_8=ECO_ISIC2_8, isic2_9=ECO_ISIC2_9, isic31_A=ECO_ISIC3_A, isic31_B=ECO_ISIC3_B, 
         isic31_C=ECO_ISIC3_C, isic31_L=ECO_ISIC3_L, isic31_M=ECO_ISIC3_M, isic31_O=ECO_ISIC3_O, isic31_Q=ECO_ISIC3_Q, 
         isic2_1=ECO_ISIC2_1, isic4_total=ECO_ISIC4_TOTAL, isic2_0=ECO_ISIC2_0, isic4_B=ECO_ISIC4_B, 
         isic4_C=ECO_ISIC4_C, isic4_D=ECO_ISIC4_D, isic4_E=ECO_ISIC4_E, isic4_F=ECO_ISIC4_F, isic4_G=ECO_ISIC4_G, 
         isic4_H=ECO_ISIC4_H, isic4_I=ECO_ISIC4_I, isic4_J=ECO_ISIC4_J, isic4_M=ECO_ISIC4_M, isic4_N=ECO_ISIC4_N, 
         isic4_O=ECO_ISIC4_O, isic4_P=ECO_ISIC4_P, isic4_Q=ECO_ISIC4_Q, isic4_R=ECO_ISIC4_R, isic4_S=ECO_ISIC4_S,
         isic4_K=ECO_ISIC4_K, isic4_A=ECO_ISIC4_A, isic4_L=ECO_ISIC4_L, isic4_T=ECO_ISIC4_T, isic4_U=ECO_ISIC4_U, 
         isic4_X=ECO_ISIC4_X, isic31_P=ECO_ISIC3_P)

# Days not worked due to strikes and lockouts by economic activity -----------------
ndays_strikes	<- Rilostat::get_ilostat("STR_DAYS_ECO_NB_A") %>% 
  select(iso3c = ref_area, year=time, ndays_strikes= obs_value, activity=classif1, obs_status) %>%
  group_by(iso3c, year) %>% 
  mutate(obs_status = NA) %>% 
  ungroup() %>%
  pivot_wider(names_from = c("activity"), values_from = ("ndays_strikes")) %>% 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, isic31_total=ECO_ISIC3_TOTAL, isic31_D=ECO_ISIC3_D, isic31_E=ECO_ISIC3_E, isic31_F=ECO_ISIC3_F, 
         isic31_G=ECO_ISIC3_G, isic31_H=ECO_ISIC3_H, isic31_I=ECO_ISIC3_I, isic31_J=ECO_ISIC3_J, isic31_N=ECO_ISIC3_N, 
         isic31_X=ECO_ISIC3_X, sector_total=ECO_SECTOR_TOTAL, isic31_K=ECO_ISIC3_K, isic2_total=ECO_ISIC2_TOTAL, 
         isic2_6=ECO_ISIC2_6, isic2_5=ECO_ISIC2_5, isic2_2=ECO_ISIC2_2, isic2_3=ECO_ISIC2_3, isic2_4=ECO_ISIC2_4, 
         isic2_7=ECO_ISIC2_7, isic2_8=ECO_ISIC2_8, isic2_9=ECO_ISIC2_9, isic31_A=ECO_ISIC3_A, isic31_B=ECO_ISIC3_B, 
         isic31_C=ECO_ISIC3_C, isic31_L=ECO_ISIC3_L, isic31_M=ECO_ISIC3_M, isic31_O=ECO_ISIC3_O, isic31_Q=ECO_ISIC3_Q, 
         isic2_1=ECO_ISIC2_1, isic4_total=ECO_ISIC4_TOTAL, isic2_0=ECO_ISIC2_0, isic4_B=ECO_ISIC4_B, 
         isic4_C=ECO_ISIC4_C, isic4_D=ECO_ISIC4_D, isic4_E=ECO_ISIC4_E, isic4_F=ECO_ISIC4_F, isic4_G=ECO_ISIC4_G, 
         isic4_H=ECO_ISIC4_H, isic4_I=ECO_ISIC4_I, isic4_J=ECO_ISIC4_J, isic4_M=ECO_ISIC4_M, isic4_N=ECO_ISIC4_N, 
         isic4_O=ECO_ISIC4_O, isic4_P=ECO_ISIC4_P, isic4_Q=ECO_ISIC4_Q, isic4_R=ECO_ISIC4_R, isic4_S=ECO_ISIC4_S,
         isic4_K=ECO_ISIC4_K, isic4_A=ECO_ISIC4_A, isic4_L=ECO_ISIC4_L, isic4_T=ECO_ISIC4_T, isic4_U=ECO_ISIC4_U, 
         isic4_X=ECO_ISIC4_X, isic31_P=ECO_ISIC3_P)

# Workers involved in strikes and lockouts by economic activity (thousands) -----------------
nworkers_strikes	<- Rilostat::get_ilostat("STR_WORK_ECO_NB_A") %>% 
  select(iso3c = ref_area, year=time, nworkers_strikes= obs_value, classif1, obs_status) %>%
  group_by(iso3c, year) %>% 
  mutate(obs_status = NA) %>% 
  ungroup() %>%
  pivot_wider(names_from = c("classif1"), values_from = ("nworkers_strikes")) %>% 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, isic31_total=ECO_ISIC3_TOTAL, isic31_E=ECO_ISIC3_E, isic31_F=ECO_ISIC3_F, isic31_G=ECO_ISIC3_G, 
         isic31_H=ECO_ISIC3_H, isic31_I=ECO_ISIC3_I, isic31_J=ECO_ISIC3_J, isic31_N=ECO_ISIC3_N, isic31_X=ECO_ISIC3_X, 
         sector_total=ECO_SECTOR_TOTAL, sector_nag=ECO_SECTOR_NAG, sector_ind=ECO_SECTOR_IND, sector_X=ECO_SECTOR_X, 
         isic31_K=ECO_ISIC3_K, sector_ser=ECO_SECTOR_SER, isic2_total=ECO_ISIC2_TOTAL, isic2_6=ECO_ISIC2_6, 
         isic2_5=ECO_ISIC2_5, isic2_2=ECO_ISIC2_2, isic2_3=ECO_ISIC2_3, isic2_4=ECO_ISIC2_4, isic2_7=ECO_ISIC2_7, 
         isic2_8=ECO_ISIC2_8, isic2_9=ECO_ISIC2_9, isic31_A=ECO_ISIC3_A, isic31_B=ECO_ISIC3_B, isic31_C=ECO_ISIC3_C, 
         isic31_D=ECO_ISIC3_D, isic31_L=ECO_ISIC3_L, isic31_M=ECO_ISIC3_M, isic31_O=ECO_ISIC3_O, isic31_Q=ECO_ISIC3_Q, 
         isic2_1=ECO_ISIC2_1, isic2_0=ECO_ISIC2_0, isic4_B=ECO_ISIC4_B, isic4_C=ECO_ISIC4_C, isic4_D=ECO_ISIC4_D, 
         isic4_E=ECO_ISIC4_E, isic4_F=ECO_ISIC4_F, isic4_G=ECO_ISIC4_G, isic4_H=ECO_ISIC4_H, isic4_I=ECO_ISIC4_I, 
         isic4_J=ECO_ISIC4_J, isic4_M=ECO_ISIC4_M, isic4_N=ECO_ISIC4_N, isic4_O=ECO_ISIC4_O, isic4_P=ECO_ISIC4_P, 
         isic4_Q=ECO_ISIC4_Q, isic4_R=ECO_ISIC4_R, isic4_S=ECO_ISIC4_S, isic4_K=ECO_ISIC4_K, isic4_total=ECO_ISIC4_TOTAL, 
         isic4_A=ECO_ISIC4_A, isic4_L=ECO_ISIC4_L, isic4_T=ECO_ISIC4_T, isic4_U=ECO_ISIC4_U, isic4_X=ECO_ISIC4_X, 
         isic31_P=ECO_ISIC3_P)

# Unemployment rate (%) -- Annual -----------------
unemployment_rate	<- Rilostat::get_ilostat("SDG_0852_SEX_AGE_RT_A") %>% 
  select(iso3c = ref_area, year=time, unemployment_rate= obs_value, sex, classif1, obs_status) %>%
  group_by(iso3c, year) %>% 
  mutate(obs_status = NA) %>% 
  ungroup() %>%
  pivot_wider(names_from = c("classif1", "sex"), values_from = "unemployment_rate") %>% 
  mutate(year = as.numeric(year)) %>% 
  select(iso3c, year, total_15="AGE_YTHADULT_YGE15_SEX_T", total_1564="AGE_YTHADULT_Y15-64_SEX_T", 
         total_1524="AGE_YTHADULT_Y15-24_SEX_T", total_25="AGE_YTHADULT_YGE25_SEX_T", 
         masc_15="AGE_YTHADULT_YGE15_SEX_M", masc_1564="AGE_YTHADULT_Y15-64_SEX_M", masc_1524="AGE_YTHADULT_Y15-24_SEX_M", 
         masc_25="AGE_YTHADULT_YGE25_SEX_M", fem_15="AGE_YTHADULT_YGE15_SEX_F", fem_1564="AGE_YTHADULT_Y15-64_SEX_F", 
         fem_1524="AGE_YTHADULT_Y15-24_SEX_F", fem_25="AGE_YTHADULT_YGE25_SEX_F", 
         other_15="AGE_YTHADULT_YGE15_SEX_O", other_1524="AGE_YTHADULT_Y15-24_SEX_O", 
         other_25="AGE_YTHADULT_YGE25_SEX_O")


# 3. Recode and rename---------------------------------------------------------------
## Similar a ocde02

# 4. Merge ----------------------------------------------------------------
data_ilo <- lapply(ls(),get)
data_ilo <- Reduce(function(x,y) merge(x = x, y = y, by = c("iso3c", "year"), all = T), 
                   list(ud, cbc, hour_earn, labor_inc_share, emp_inst, emp_status, nstrikes_act, 
                        ndays_strikes, nworkers_strikes, unemployment_rate))

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
## save data_ilo.rds
saveRDS(wdi_dat, file = "C:/Users/genaro cuadros/Desktop/Github/fdl-data/R/data_ilo.rds")