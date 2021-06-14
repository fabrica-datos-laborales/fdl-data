# Code: World Bank --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(WDI, tidyverse, Hmisc)

# 2. Search ---------------------------------------------------------------
WDIsearch("part time") # Permite buscar
#NY.GDP.MKTP.KD.ZG # GDP growth (annual %)

# 3. Scrapping ------------------------------------------------------------
wdi_dat <- WDI(indicator = c("NY.GDP.MKTP.KD.ZG",
                             "NY.GNP.PCAP.CD",
                             "NY.GNP.PCAP.PP.CD",
                             "SP.POP.TOTL",
                             "SL.AGR.EMPL.ZS",
                             "SL.IND.EMPL.ZS",
                             "SL.SRV.EMPL.ZS",
                             "SL.EMP.TOTL.SP.ZS",
                             "SI.POV.GINI",
                             "SI.DST.10TH.10",
                             "SL.TLF.CACT.NE.ZS",
                             "SL.TLF.ACTI.ZS",
                             "SL.TLF.ADVN.ZS",
                             "SL.EMP.SELF.ZS",
                             "SL.UEM.TOTL.NE.ZS",
                             "SL.UEM.TOTL.ZS",
                             "SL.EMP.WORK.ZS",
                             "SL.EMP.VULN.ZS",
                             "NY.GDP.MKTP.KD.ZG",
                             "SL.TLF.PART.ZS",
                             "SL.TLF.PART.FE.ZS",
                             "SL.TLF.PART.MA.ZS",
                             "SH.MMR.WAGE.ZS",
                             "SL.TLF.CACT.FM.NE.ZS",
                             "SL.TLF.CACT.FM.ZS",
                             "SL.SRV.EMPL.FE.ZS",
                             "SL.SRV.EMPL.MA.ZS",
                             "IC.BUS.EASE.DFRN.XQ.DB1719",
                             "IC.BUS.DFRN.XQ",
                             "IC.BUS.EASE.XQ"),
               start = 1960, end = 2021, extra = TRUE) 


# 4. Rename ---------------------------------------------------------------
wdi <- wdi_dat %>% rename("gdp_growth_wdi"= NY.GDP.MKTP.KD.ZG, 
                                   "gni_per_capita_wdi"= NY.GNP.PCAP.CD, 
                                   "gni_per_capita_ppp_wdi"= NY.GNP.PCAP.PP.CD,
                                   "population_wdi"= SP.POP.TOTL,
                                   "emp_agr_wdi" = SL.AGR.EMPL.ZS,
                                   "emp_ind_wdi" = SL.IND.EMPL.ZS,
                                   "emp_serv_wdi" = SL.SRV.EMPL.ZS,
                                   "emp_pop_wdi" = SL.EMP.TOTL.SP.ZS,
                                   "gini_in_wdi" = SI.POV.GINI,
                                   "income_sh_wdi" = SI.DST.10TH.10,
                                   "lfp_wdi" = SL.TLF.CACT.NE.ZS,
                                   "lfp_64_wdi" = SL.TLF.ACTI.ZS,
                                   "lf_educ_wdi" = SL.TLF.ADVN.ZS,
                                   "emp_self_wdi" = SL.EMP.SELF.ZS,
                                   "unemp_wdi" = SL.UEM.TOTL.NE.ZS,
                                   "unemp_e_wdi" = SL.UEM.TOTL.ZS,
                                   "emp_salaried_wdi" = SL.EMP.WORK.ZS,
                                   "emp_vulnerable_wdi" = SL.EMP.VULN.ZS,
                                   "emp_pt_wdi" = SL.TLF.PART.ZS,
                                   "emp_fem_pt_wdi" = SL.TLF.PART.FE.ZS,
                                   "emp_male_pt_wdi" = SL.TLF.PART.MA.ZS,
                                   "emp_mat_wdi" = SH.MMR.WAGE.ZS,
                                   "emp_sexratio_wdi" = SL.TLF.CACT.FM.NE.ZS,
                                   "emp_sexratio_e_wdi" = SL.TLF.CACT.FM.ZS,
                                   "emp_fem_serv_wdi" = SL.SRV.EMPL.FE.ZS,
                                   "emp_male_serv_wdi" = SL.SRV.EMPL.MA.ZS,
                                   "db_1720_wdi" = IC.BUS.EASE.DFRN.XQ.DB1719,
                                   "db_wdi" = IC.BUS.DFRN.XQ,
                                   "db_index_wdi" = IC.BUS.EASE.XQ)


# 7. Select ------------------------------------------------------
wdi <- wdi %>% filter(!is.na(region), region != "Aggregates")%>%
  select(-c(region, capital,longitude,latitude,income,lending))

# 8. ISO3C ----------------------------------------------------------------
wdi <- wdi %>%
  mutate(iso3c = countrycode(iso2c, "iso2c", "iso3c")) %>% 
  select(iso3c, everything(), -iso2c)

# 9. Label ----------------------------------------------------------------
label(wdi$iso3c) <- "Country code ISO3"
label(wdi$year) <- "Year"

# 10. Save -----------------------------------------------------------------
saveRDS(wdi, file = "output/data/proc/wdi.rds")
