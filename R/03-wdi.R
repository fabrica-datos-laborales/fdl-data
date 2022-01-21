# Code: World Bank --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(WDI, tidyverse, Hmisc,countrycode)

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
wdi <- wdi_dat %>% rename("gdp_growth"= NY.GDP.MKTP.KD.ZG, 
                                   "gni_per_capita"= NY.GNP.PCAP.CD, 
                                   "gni_per_capita_ppp"= NY.GNP.PCAP.PP.CD,
                                   "population"= SP.POP.TOTL,
                                   "emp_agr" = SL.AGR.EMPL.ZS,
                                   "emp_ind" = SL.IND.EMPL.ZS,
                                   "emp_serv" = SL.SRV.EMPL.ZS,
                                   "emp_pop" = SL.EMP.TOTL.SP.ZS,
                                   "gini_in" = SI.POV.GINI,
                                   "income_sh" = SI.DST.10TH.10,
                                   "lfp" = SL.TLF.CACT.NE.ZS,
                                   "lfp_64" = SL.TLF.ACTI.ZS,
                                   "lf_educ" = SL.TLF.ADVN.ZS,
                                   "emp_self" = SL.EMP.SELF.ZS,
                                   "unemp" = SL.UEM.TOTL.NE.ZS,
                                   "unemp_e" = SL.UEM.TOTL.ZS,
                                   "emp_salaried" = SL.EMP.WORK.ZS,
                                   "emp_vulnerable" = SL.EMP.VULN.ZS,
                                   "emp_pt" = SL.TLF.PART.ZS,
                                   "emp_fem_pt" = SL.TLF.PART.FE.ZS,
                                   "emp_male_pt" = SL.TLF.PART.MA.ZS,
                                   "emp_mat" = SH.MMR.WAGE.ZS,
                                   "emp_sexratio" = SL.TLF.CACT.FM.NE.ZS,
                                   "emp_sexratio_e" = SL.TLF.CACT.FM.ZS,
                                   "emp_fem_serv" = SL.SRV.EMPL.FE.ZS,
                                   "emp_male_serv" = SL.SRV.EMPL.MA.ZS,
                                   "db_1720" = IC.BUS.EASE.DFRN.XQ.DB1719,
                                   "db" = IC.BUS.DFRN.XQ,
                                   "db_index" = IC.BUS.EASE.XQ)


# 7. Select ------------------------------------------------------
wdi <- wdi %>% filter(!is.na(region), region != "Aggregates")%>%
  select(-c(region, capital,longitude,latitude,income,lending))

# 8. ISO3C ----------------------------------------------------------------
wdi <- wdi %>%
  mutate(iso3c = countrycode(iso2c, "iso2c", "iso3c")) %>% 
  select(iso3c, everything(), -iso2c)

# 9. Label ----------------------------------------------------------------
label(wdi$year) <- "Year"
label(wdi$iso3c) <- "Country code ISO3"

# 10. Save -----------------------------------------------------------------
saveRDS(wdi, file = "output/data/proc/wdi.rds")
