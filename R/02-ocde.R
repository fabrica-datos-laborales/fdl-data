# Code OCDE ---------------------------------------------------------------
# 1. Load packages --------------------------------------------------------
pacman::p_load(OECD, tidyverse, googlesheets4)

# 2. Load data ------------------------------------------------------------

# Real Minimun Wages (rmw) ------------------------------------------------------
rmw <- OECD::get_dataset("RMW",
                         filter = "AUS+BEL+CAN+CHL+CZE+EST+FRA+DEU+GRC+HUN+IRL+ISR+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+POL+PRT+SVK+SVN+ESP+TUR+GBR+USA+CRI+BRA+RUS+COL.PPP.A", 
                         pre_formatted = TRUE)
rmw <- rmw %>%
  select(iso3c=COUNTRY,year=Time, rmw=ObsValue) %>% 
  mutate(rmw = as.numeric(rmw))

# Anual avergaes (aww) ----------------------------------------------------------
# aww <- OECD::get_dataset("AC_AN_WAGE",
#                          filter = "AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+GBR+USA.CPNCU+CNPNCU+USDPPP", 
#                          pre_formatted = TRUE)

# Median real wages (mrw) -------------------------------------------------------
mrw <- OECD::get_dataset("MIN2AVE",
                         filter = "AUS+BEL+CAN+CHL+COL+CZE+EST+FRA+DEU+GRC+HUN+IRL+ISR+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+POL+PRT+SVK+SVN+ESP+TUR+GBR+USA+CRI+ROU.MEDIAN", 
                         pre_formatted = TRUE)

mrw <- mrw %>% 
  select(iso3c=COUNTRY, year=Time, mrw=ObsValue) %>%
  mutate(mrw=as.numeric(mrw))

# Employment (emp) emp_serv, emp_agr --------------------------------------------------
emp <- OECD::get_dataset("ALFS_EMP",
                          filter = "AUS+AUT+BEL+CAN+CHL+COL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+BRA+CRI+RUS.YA994TL1_ST+YA994AL1_ST+YA994IL1_ST+YA994SL1_ST+YA99A4L1_ST+YA99B4L1_ST+YA99C4L1_ST+YA99D4L1_ST+YA99E4L1_ST+YA99F4L1_ST+YA99G4L1_ST+YA99H4L1_ST+YA99I4L1_ST+YA99J4L1_ST+YA99K4L1_ST+YA99L4L1_ST+YA99M4L1_ST+YA99N4L1_ST+YA99O4L1_ST+YA99P4L1_ST+YA99Q4L1_ST+YA99X4L1_ST+YA99S4L1_ST+YA99T4L1_ST+YA99U4L1_ST.MA+FE+TT.A", 
                          pre_formatted = TRUE)

emp$sector <- car::recode(emp$SUBJECT,
recodes = "'YA994TL1_ST' = 'total_emp';
'YA994AL1_ST' = 'emp_agr';
'YA994IL1_ST' = 'emp_ind';
'YA994SL1_ST' = 'emp_serv';
'YA99A4L1_ST' = 'empA';
'YA99B4L1_ST' = 'empB';
'YA99C4L1_ST' = 'empC';
'YA99D4L1_ST' = 'empD';
'YA99E4L1_ST' = 'empE';
'YA99F4L1_ST' = 'empF';
'YA99G4L1_ST' = 'empG';
'YA99H4L1_ST' = 'empH';
'YA99I4L1_ST' = 'empI';
'YA99J4L1_ST' = 'empJ';
'YA99K4L1_ST' = 'empK';
'YA99L4L1_ST' = 'empL';
'YA99M4L1_ST' = 'empM';
'YA99N4L1_ST' = 'empN';
'YA99O4L1_ST' = 'empO';
'YA99P4L1_ST' = 'empP';
'YA99Q4L1_ST' = 'empQ';
'YA99X4L1_ST' = 'empR';
'YA99S4L1_ST' = 'empS';
'YA99T4L1_ST' = 'empT';
'YA99U4L1_ST' = 'empU'") 

emp <- emp %>%
  select(iso3c=LOCATION, sex=SEX, year=Time, ObsValue, sector) %>%
  pivot_wider(names_from = c("sector", "sex"), values_from = "ObsValue")

emp <- emp %>%
  select(iso3c, year, emp_serv=emp_serv_TT, emp_agr=emp_agr_TT, emp_ind=emp_ind_TT, emp=total_emp_TT,
         empA=empA_TT, empB=empB_TT, empC=empC_TT, empD=empD_TT, empE=empE_TT, empF=empF_TT, empG=empG_TT, 
         empH=empH_TT, empI=empI_TT, empJ=empJ_TT, empK=empK_TT, empL=empL_TT, empM=empM_TT, empN=empN_TT, 
         empO=empO_TT, empP=empP_TT, empQ=empQ_TT, empR=empR_TT, empS=empS_TT, empT=empT_TT, empU=empU_TT) %>%
  mutate_at(vars(starts_with("emp")), funs(as.numeric(.)))
 

# Labour Force, Employment and Unemployment (lfs) -------------------------------
get_data_structure("LFS_SEXAGE_I_R")
lfs <- OECD::get_dataset("LFS_SEXAGE_I_R",
                          filter = "AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+OECD+COL+CRI+LTU+BRA+CHN+IND+IDN+RUS+ZAF.MEN+WOMEN+MW.900000.EPR+LFPR+UR.A", 
                          pre_formatted = TRUE)

lfs <- lfs %>%
  select(iso3c=COUNTRY, sex=SEX, year=Time, ObsValue, series=SERIES) %>%
  pivot_wider(names_from = c("series", "sex"), values_from = "ObsValue")

lfs <- lfs %>% 
  select(iso3c, year, emp_fem= EPR_WOMEN, emp_male= EPR_MEN, lfp=LFPR_MW, lfp_fem=LFPR_WOMEN, lfp_male=LFPR_MEN,
         unemp=UR_MW, unemp_fem=UR_WOMEN, unemp_male=UR_MEN) %>%
  mutate_at(vars(starts_with("emp")|starts_with("unemp")|starts_with("lfp")), funs(as.numeric(.)))

# Part time employment (pt) ----------------------------------------------------
"https://stats.oecd.org/restsdmx/sdmx.ashx/GetData/FTPTN_I/AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+LVA+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+OECD+COL+CRI+LTU+RUS+FTFR.MEN+WOMEN+MW.1524+2554+5564+6599+900000.DE+TE.FT+PT+SH_PT.A/all?startTime=2000&endTime=2019"
pt <- OECD::get_dataset("FTPTN_I",
                        filter = "AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+LVA+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+OECD+COL+CRI+LTU+RUS+FTFR.MEN+WOMEN+MW.900000.DE+TE.FT+PT+SH_PT.A",
                        pre_formatted = T)

pt <- pt %>%
  select(iso3c=COUNTRY, sex=SEX, year=Time, ObsValue, series=SERIES, EMPSTAT) %>%
  pivot_wider(names_from = c("series", "sex", "EMPSTAT"), values_from = "ObsValue")

pt <- pt %>%
  select(iso3c, year, pt_emp_te=PT_MW_TE, pt_emp_de=PT_MW_DE, pt_emp_fem_te=PT_WOMEN_TE, 
         pt_emp_fem_de=PT_WOMEN_DE, pt_emp_male_te=PT_MEN_TE, pt_emp_male_de=PT_MEN_DE, 
         pt_sh_fem_te=SH_PT_WOMEN_TE, pt_sh_fem_de=SH_PT_WOMEN_DE)%>%
  mutate_at(vars(starts_with("pt")), funs(as.numeric(.)))

# Average hours worker per worker (hrs) -----------------------------------------
#https://stats.oecd.org/restsdmx/sdmx.ashx/GetData/ANHRS/AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+OECD+CRI+RUS.DE+TE.A/all?startTime=2000&endTime=2019
hrs <- OECD::get_dataset("ANHRS",
                        filter = "AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+OECD+CRI+RUS.DE+TE.A",
                        pre_formatted = T)

hrs <- hrs %>%
  select(iso3c=COUNTRY, year=Time, hrs_wrk=ObsValue,  EMPSTAT) %>%
  pivot_wider(names_from = c("EMPSTAT"), values_from = "hrs_wrk")

hrs <- hrs %>%
  select(iso3c, year, hrs_work_te=TE, hrs_work_de=DE) %>%
  mutate_at(vars(starts_with("hrs")), funs(as.numeric(.)))

# GDP  (wise) ---------------------------------------------------------------------
#https://stats.oecd.org/restsdmx/sdmx.ashx/GetData/WSDB/AUS+AUT+BEL+CAN+CHL+COL+CRI+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+AFG+ALB+DZA+ASM+AND+AGO+AIA+ATG+ARG+ARM+ABW+AZE+BHS+BHR+BGD+BRB+BLR+BLZ+BEN+BMU+BTN+BOL+BIH+BWA+BRA+VGB+BRN+BGR+BFA+BDI+KHM+CMR+CPV+CYM+CAF+TCD+CHN+COM+COG+COD+COK+CIV+HRV+CUB+CYP+CUW+DJI+DMA+DOM+ECU+EGY+SLV+GNQ+ERI+ETH+FRO+FJI+GUF+MKD+PYF+GAB+GMB+GEO+GHA+GIB+GRL+GRD+GLP+GUM+GTM+GIN+GNB+GUY+HTI+HND+HKG+IND+IDN+IRN+IRQ+IMN+JAM+JOR+KAZ+KEN+PRK+KIR+KWT+XKO+KGZ+LAO+LBN+LSO+LBR+LBY+LIE+MAC+MDG+MWI+MYS+MDV+MLI+MLT+MHL+MTQ+MRT+MUS+MYT+FSM+MDA+MCO+MNG+MNE+MSR+MAR+MOZ+MMR+NAM+NRU+NPL+ANT+NCL+NIC+NER+NGA+NIU+MNP+PSE+OMN+PAK+PLW+PAN+PNG+PRY+PER+PHL+PRI+QAT+REU+ROU+RUS+RWA+SHN+KNA+LCA+SXM+VCT+WSM+SMR+STP+SAU+SEN+SCG+SRB+SYC+SLE+SGP+SLB+SOM+ZAF+LKA+SDN+SUR+SSD+SWZ+SYR+TWN+TJK+TZA+THA+TLS+TGO+TKL+TON+TTO+TUN+TKM+TCA+TUV+UGA+UKR+ARE+URY+UZB+VUT+VEN+VNM+VIR+YEM+ZMB+ZWE.CONTEXT+NY_GDP_MKTP_CD+NY_GNP_PCAP_PP_CD+EMPL_SECT+EMPL_AGRI+EMPL_MINCON+EMPL_INDU+EMPL_SERV+EMPL_SECTX+BG_GSR_NFSV_GD_ZS+HUM_DEV_IND+SP_POP_TOTL+SP_POP_TOTL_FE_ZS+YTH_POP_REL+SP_URB_TOTL_IN_ZS+SH_STA_MALN+MOTH_EATT+MOTH_EATT_LS+MOTH_EATT_MS+MOTH_EATT_HS+IT_NET_USER_P2+IT_CEL_SETS_P2+XGDP_FSGOV+PTRHC+PTRHC_1+PTRHC_2+PTRHC_3+EMPL_INF_SECT+IC_BUS_EASE_XQ+SKILL_ACQ+ADU_EATT+ADU_EATT_ISCED0+ADU_EATT_ISCEDN+ADU_EATT_ISCED1+ADU_EATT_ISCED2+ADU_EATT_ISCED3+ADU_EATT_ISCED4+ADU_EATT_ISCED5_6+ADU_EATT_ISCEDX+LR_AG15T24+LR_AG15T99+COGN_SKIL_ADU+COGN_SKIL_STEP+GER_1+NER_1+SR_1_GLAST+GER_23+NER_23+SR_2_GPV_GLAST+GTVP_3_V+GER_56+NER_YADU+GRADU_STEM+ENRL_STEM+APPRENT+ADU_EDU_LFS+ADU_EDU_AES+ADU_EDU_EMP_LFS+ADU_EDU_EMP_AES+SKILL_REQ+EMPL_EATT+EMPL_EATT_ISCED0+EMPL_EATT_ISCED1+EMPL_EATT_ISCED2+EMPL_EATT_ISCED3+EMPL_EATT_ISCED4+EMPL_EATT_ISCED5+EMPL_EATT_ISCED6+EMPL_EATT_ISCEDX+EMPL_SHARE+EMPL_SHARE_ISCO01+EMPL_SHARE_ISCO02+EMPL_SHARE_ISCO03+EMPL_SHARE_ISCO04+EMPL_SHARE_ISCO05+EMPL_SHARE_ISCO06+EMPL_SHARE_ISCO07+EMPL_SHARE_ISCO08+EMPL_SHARE_ISCO09+EMPL_SHARE_ISCO00+EMPL_SHARE_ISCO0X+SELF_EMPL+WORK_SKIL+WORK_SKIL_READ+WORK_SKIL_WRIT+WORK_SKIL_NUM+WORK_SKIL_IT+WORK_SKIL_COMM+WORK_SKIL_TEAM+WORK_SKIL_NEW+WORK_SKIL_PHYS+WORK_SKIL_DEXT+WORK_SKIL_READ_STEP_NU+WORK_SKIL_READ_STEP_LU+WORK_SKIL_READ_STEP_MU+WORK_SKIL_READ_STEP_HU+WORK_SKIL_WRIT_STEP_NU+WORK_SKIL_WRIT_STEP_LU+WORK_SKIL_WRIT_STEP_MU+WORK_SKIL_WRIT_STEP_HU+WORK_SKIL_NUM_STEP_NU+WORK_SKIL_NUM_STEP_LU+WORK_SKIL_NUM_STEP_MU+WORK_SKIL_NUM_STEP_HU+WORK_SKIL_IT_STEP_NU+WORK_SKIL_IT_STEP_LU+WORK_SKIL_IT_STEP_MU+WORK_SKIL_IT_STEP_HU+JOB_REQ+JOB_REQ_NOE+JOB_REQ_LS+JOB_REQ_MS+JOB_REQ_HS+MATCHING+QUAL+OVERQUAL+UNDERQUAL+WELLM+SKIL_GAP+CHNG_EARN+CHNG_EARN_LS+CHNG_EARN_MS+CHNG_EARN_HS+CHNG_EARN_ISCO01+CHNG_EARN_ISCO02+CHNG_EARN_ISCO03+CHNG_EARN_ISCO04+CHNG_EARN_ISCO05+CHNG_EARN_ISCO06+CHNG_EARN_ISCO07+CHNG_EARN_ISCO08+CHNG_EARN_ISCO09+CHNG_UNEMP+CHNG_UNEMP_LS+CHNG_UNEMP_MS+CHNG_UNEMP_HS+OUTCOMES+NY_GDP_MKTP_KD_ZG+GDP_EMPL+GDP_EMPL_GROW+GDP_HOUR+GDP_HOUR_GROW+EMPL+EMPL_LS+EMPL_MS+EMPL_HS+ADU_EMPL+ADU_EMPL_LS+ADU_EMPL_MS+ADU_EMPL_HS+15_19_EMPL+15_19_EMPL_LS+15_19_EMPL_MS+15_19_EMPL_HS+20_24_EMPL+20_24_EMPL_LS+20_24_EMPL_MS+20_24_EMPL_HS+25_29_EMPL+25_29_EMPL_LS+25_29_EMPL_MS+25_29_EMPL_HS+EMPL_INF+EMPL_INF_EDU+EMPL_INF_NS+EMPL_INF_LS+EMPL_INF_MS+EMPL_INF_HS+EMPL_TEMP+EMPL_TEMP_LS+EMPL_TEMP_MS+EMPL_TEMP_HS+UNEMP+UNEMP_LS+UNEMP_MS+UNEMP_HS+ADU_UNEMP+ADU_UNEMP_LS+ADU_UNEMP_MS+ADU_UNEMP_HS+YTH_UNEMP+YTH_UNEMP_LS+YTH_UNEMP_MS+YTH_UNEMP_HS+NEET+NEET_PSY+NEET_PSN+EARN+EARN_LS+EARN_MS+EARN_HS+EARN_ISCO01+EARN_ISCO02+EARN_ISCO03+EARN_ISCO04+EARN_ISCO05+EARN_ISCO06+EARN_ISCO07+EARN_ISCO08+EARN_ISCO09+SI_POV_GINI+SI_POV_2DAY.W+M+T/all?startTime=2003&endTime=2014
## Explorar WISE
db <- OECD::get_data_structure("WSDB")
db$VAR
db <- db$VAR

## Queries
wise1 <- OECD::get_dataset("WSDB",
                         filter = "AUS+AUT+BEL+CAN+CHL+COL+CRI+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+AFG+ALB+DZA+ASM+AND+AGO+AIA+ATG+ARG+ARM+ABW+AZE+BHS+BHR+BGD+BRB+BLR+BLZ+BEN+BMU+BTN+BOL+BIH+BWA+BRA+VGB+BRN+BGR+BFA+BDI+KHM+CMR+CPV+CYM+CAF+TCD+CHN+COM+COG+COD+COK+CIV+HRV+CUB+CYP+CUW+DJI+DMA+DOM+ECU+EGY+SLV+GNQ+ERI+ETH+FRO+FJI+GUF+MKD+PYF+GAB+GMB+GEO+GHA+GIB+GRL+GRD+GLP+GUM+GTM+GIN+GNB+GUY+HTI+HND+HKG+IND+IDN+IRN+IRQ+IMN+JAM+JOR+KAZ+KEN+PRK+KIR+KWT+XKO+KGZ+LAO+LBN+LSO+LBR+LBY+LIE+MAC+MDG+MWI+MYS+MDV+MLI+MLT+MHL+MTQ+MRT+MUS+MYT+FSM+MDA+MCO+MNG+MNE+MSR+MAR+MOZ+MMR+NAM+NRU+NPL+ANT+NCL+NIC+NER+NGA+NIU+MNP+PSE+OMN+PAK+PLW+PAN+PNG+PRY+PER+PHL+PRI+QAT+REU+ROU+RUS+RWA+SHN+KNA+LCA+SXM+VCT+WSM+SMR+STP+SAU+SEN+SCG+SRB+SYC+SLE+SGP+SLB+SOM+ZAF+LKA+SDN+SUR+SSD+SWZ+SYR+TWN+TJK+TZA+THA+TLS+TGO+TKL+TON+TTO+TUN+TKM+TCA+TUV+UGA+UKR+ARE+URY+UZB+VUT+VEN+VNM+VIR+YEM+ZMB+ZWE.NY_GDP_MKTP_CD+NY_GNP_PCAP_PP_CD+EMPL_SHARE_ISCO01+EMPL_SHARE_ISCO02+EMPL_SHARE_ISCO03+EMPL_SHARE_ISCO04+EMPL_SHARE_ISCO05",
                         pre_formatted = T)

wise2 <- OECD::get_dataset("WSDB",
                          filter = "AUS+AUT+BEL+CAN+CHL+COL+CRI+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+AFG+ALB+DZA+ASM+AND+AGO+AIA+ATG+ARG+ARM+ABW+AZE+BHS+BHR+BGD+BRB+BLR+BLZ+BEN+BMU+BTN+BOL+BIH+BWA+BRA+VGB+BRN+BGR+BFA+BDI+KHM+CMR+CPV+CYM+CAF+TCD+CHN+COM+COG+COD+COK+CIV+HRV+CUB+CYP+CUW+DJI+DMA+DOM+ECU+EGY+SLV+GNQ+ERI+ETH+FRO+FJI+GUF+MKD+PYF+GAB+GMB+GEO+GHA+GIB+GRL+GRD+GLP+GUM+GTM+GIN+GNB+GUY+HTI+HND+HKG+IND+IDN+IRN+IRQ+IMN+JAM+JOR+KAZ+KEN+PRK+KIR+KWT+XKO+KGZ+LAO+LBN+LSO+LBR+LBY+LIE+MAC+MDG+MWI+MYS+MDV+MLI+MLT+MHL+MTQ+MRT+MUS+MYT+FSM+MDA+MCO+MNG+MNE+MSR+MAR+MOZ+MMR+NAM+NRU+NPL+ANT+NCL+NIC+NER+NGA+NIU+MNP+PSE+OMN+PAK+PLW+PAN+PNG+PRY+PER+PHL+PRI+QAT+REU+ROU+RUS+RWA+SHN+KNA+LCA+SXM+VCT+WSM+SMR+STP+SAU+SEN+SCG+SRB+SYC+SLE+SGP+SLB+SOM+ZAF+LKA+SDN+SUR+SSD+SWZ+SYR+TWN+TJK+TZA+THA+TLS+TGO+TKL+TON+TTO+TUN+TKM+TCA+TUV+UGA+UKR+ARE+URY+UZB+VUT+VEN+VNM+VIR+YEM+ZMB+ZWE.EMPL_SHARE+EMPL_AGRI+EMPL_MINCON+EMPL_INDU+EMPL_SERV+BG_GSR_NFSV_GD_ZS+HUM_DEV_IND+SP_POP_TOTL+SP_POP_TOTL_FE_ZS+NY_GDP_MKTP_KD_ZG+GDP_EMPL+GDP_EMPL_GROW+GDP_HOUR+GDP_HOUR_GROW+EMPL+EMPL_LS+EMPL_MS+EMPL_HS.W+M+T",
                          pre_formatted = T)
wise3 <- OECD::get_dataset("WSDB",
                          filter = "AUS+AUT+BEL+CAN+CHL+COL+CRI+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+AFG+ALB+DZA+ASM+AND+AGO+AIA+ATG+ARG+ARM+ABW+AZE+BHS+BHR+BGD+BRB+BLR+BLZ+BEN+BMU+BTN+BOL+BIH+BWA+BRA+VGB+BRN+BGR+BFA+BDI+KHM+CMR+CPV+CYM+CAF+TCD+CHN+COM+COG+COD+COK+CIV+HRV+CUB+CYP+CUW+DJI+DMA+DOM+ECU+EGY+SLV+GNQ+ERI+ETH+FRO+FJI+GUF+MKD+PYF+GAB+GMB+GEO+GHA+GIB+GRL+GRD+GLP+GUM+GTM+GIN+GNB+GUY+HTI+HND+HKG+IND+IDN+IRN+IRQ+IMN+JAM+JOR+KAZ+KEN+PRK+KIR+KWT+XKO+KGZ+LAO+LBN+LSO+LBR+LBY+LIE+MAC+MDG+MWI+MYS+MDV+MLI+MLT+MHL+MTQ+MRT+MUS+MYT+FSM+MDA+MCO+MNG+MNE+MSR+MAR+MOZ+MMR+NAM+NRU+NPL+ANT+NCL+NIC+NER+NGA+NIU+MNP+PSE+OMN+PAK+PLW+PAN+PNG+PRY+PER+PHL+PRI+QAT+REU+ROU+RUS+RWA+SHN+KNA+LCA+SXM+VCT+WSM+SMR+STP+SAU+SEN+SCG+SRB+SYC+SLE+SGP+SLB+SOM+ZAF+LKA+SDN+SUR+SSD+SWZ+SYR+TWN+TJK+TZA+THA+TLS+TGO+TKL+TON+TTO+TUN+TKM+TCA+TUV+UGA+UKR+ARE+URY+UZB+VUT+VEN+VNM+VIR+YEM+ZMB+ZWE.+EMPL_SHARE_ISCO06+EMPL_SHARE_ISCO07+EMPL_SHARE_ISCO08+EMPL_SHARE_ISCO09+EMPL_SHARE_ISCO00+EMPL_SHARE_ISCO0X+SELF_EMPL+SI_POV_GINI.W+M+T",
                          pre_formatted = T)
## Unir ambas
wise <- rbind(wise1,wise2,wise3)

## Estructura
wise <- wise %>%
  select(iso3c=LOCATION, sex=SEX, year=Time, ObsValue, series=VAR) %>%
  pivot_wider(names_from = c("series", "sex"), values_from = "ObsValue")

# Achicar
wise <- wise %>%
  select(iso3c, year, emp_sh_agr=EMPL_AGRI_T, emp_sh_mc=EMPL_MINCON_T, 
         emp_sh_ind=EMPL_INDU_T, emp_sh_serv=EMPL_SERV_T, gdp=NY_GDP_MKTP_CD_T,
         gni=NY_GNP_PCAP_PP_CD_T, tradeopen=BG_GSR_NFSV_GD_ZS_T, hdi=HUM_DEV_IND_T,
         pop=SP_POP_TOTL_T, pop_fem=SP_POP_TOTL_FE_ZS_T, gdp_growth=NY_GDP_MKTP_KD_ZG_T,
         lp=GDP_EMPL_T, hrs_lp=GDP_HOUR_T, gini=SI_POV_GINI_T) %>%
  mutate_at(vars(starts_with("emp")|starts_with("pop")|starts_with("gdp")|contains("lp")|
                 gni|tradeopen|hdi|gini), funs(as.numeric(.)))
  

# Productivity (gdp) ------------------------------------------------------------
#https://stats.oecd.org/restsdmx/sdmx.ashx/GetData/PDB_LV/AUS+AUT+BEL+CAN+CHL+COL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LTU+LVA+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+EA19+EU27_2020+G-7+OECD+NMEC+BRA+CHN+IND+IDN+RUS+ZAF+BRIICS.T_GDPPOP.CPC/all?startTime=1970&endTime=2020
gdp <- OECD::get_dataset("PDB_LV",
                           filter = "AUS+AUT+BEL+CAN+CHL+COL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LTU+LVA+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+EA19+EU27_2020+G-7+OECD+NMEC+BRA+CHN+IND+IDN+RUS+ZAF+BRIICS.T_GDPPOP.CPC",
                           pre_formatted = T)
gdp <- gdp %>%
  select(iso3c=LOCATION, year=Time, ObsValue, series=SUBJECT) %>%
  pivot_wider(names_from = c("series"), values_from = "ObsValue")

gdp <- gdp %>%
  select(iso3c, year, lp=T_GDPPOP) %>%
  mutate(lp = as.numeric(lp))

# Growth ULC y GDP (growth) --------------------------------------------------------------
# https://stats.oecd.org/restsdmx/sdmx.ashx/GetData/PDB_GR/AUS+AUT+BEL+CAN+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+KOR+LVA+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+GBR+USA+EA19+EU27_2020.T_GDPHRS_V+T_LCHRS+T_ULCH.GRW/all?startTime=1995&endTime=2020
growth <- OECD::get_dataset("PDB_GR",
                         filter = "AUS+AUT+BEL+CAN+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+KOR+LVA+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+GBR+USA+EA19+EU27_2020.T_GDPHRS_V+T_LCHRS+T_ULCH.GRW",
                         pre_formatted = T)

growth <- growth %>%
  select(iso3c=LOCATION, year=Time, ObsValue, series=SUBJECT) %>%
  pivot_wider(names_from = c("series"), values_from = "ObsValue")

growth <- growth %>% 
  select(iso3c, year, ulc = T_ULCH, gdp_growth_pc =T_GDPHRS_V) %>%
  mutate_at(vars(3:4), funs(as.numeric(.)))
 
# Gender wage gap (gwg)---------------------------------------------------------
#https://stats.oecd.org/restsdmx/sdmx.ashx/GetData/GENDER_EMP/AUS+AUT+BEL+CAN+CHL+COL+CRI+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+OAVG+NMEC+BRA+CHN+IND+IDN+RUS+ZAF.EMP9+EMP9_5+EMP9_1+EMP9_9.ALL_PERSONS.TOTAL.2000+2005+2010+2011+2012+2013+2014+2015+2016+2017+2018+2019+LATEST_YEAR+Q1-2007+Q2-2007+Q3-2007+Q4-2007+Q1-2008+Q2-2008+Q3-2008+Q4-2008+Q1-2009+Q2-2009+Q3-2009+Q4-2009+Q1-2010+Q2-2010+Q3-2010+Q4-2010+Q1-2011+Q2-2011+Q3-2011+Q4-2011+Q1-2012+Q2-2012+Q3-2012+Q4-2012+Q1-2013+Q2-2013+Q3-2013+Q4-2013+999999+Q1-2014+Q2-2014+Q3-2014+Q4-2014+Q1-2015+Q2-2015+Q3-2015+Q4-2015+Q1-2016+Q2-2016+Q3-2016+Q4-2016+Q1-2017+Q2-2017+Q3-2017+Q4-2017+Q1-2018+Q2-2018+Q3-2018+Q4-2018/all?
gwg <- OECD::get_dataset("GENDER_EMP",
                            filter = "AUS+AUT+BEL+CAN+CHL+COL+CRI+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+OAVG+NMEC+BRA+CHN+IND+IDN+RUS+ZAF.EMP9_5.ALL_PERSONS.TOTAL.2000+2005+2010+2011+2012+2013+2014+2015+2016+2017+2018+2019",pre_formatted = T)

gwg <- gwg %>%
  select(iso3c=COU, year=TIME,sex = SEX, ObsValue, series=IND) %>%
  pivot_wider(names_from = c("series"), values_from = "ObsValue")

gwg <- gwg %>% 
  select(iso3c, year, gwg= EMP9_5) %>%
  mutate(gwg=as.numeric(gwg))

# 3. Merge al data --------------------------------------------------------
oecd <- Reduce(function(x,y) merge(x = x, y = y, by = c("iso3c", "year"),
                                   all = T),
               list(rmw, mrw, emp, lfs, pt, hrs,wise,gdp, growth,gwg))


# 6. Label ----------------------------------------------------------------
# Llamar etiquetas (en slice se indican los tramos)
labels <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0",
                     range = c("B5:C279"), col_names = F) %>%
  slice(c(1,2,213:275)) %>% # selecciono 1, 2, donde parte -5, donde termina -5
  select(variables = 1, etiquetas = 2)
## Tranformar a vectornames
var.labels <- as.character(labels$etiquetas)
names(var.labels) <- labels$variables
## Etiquetar
label(oecd) = as.list(var.labels[match(names(oecd), names(oecd))])

# 7. Save -----------------------------------------------------------------
rm(list = ls(pattern = "wl|b|p|h"))#remover lo que no sirve
saveRDS(oecd, file="output/data/proc/oecd.rds")






