# Code: World Bank --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(WDI, tidyverse)

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


# 4. Recode ---------------------------------------------------------------
wdi_dat$country
datos$variable <- car::recode(datos$variable_vieja, 
                              c("1 = 'Yes';2 = 'No'"), as.factor = T,
                              levels = c("Yes", "No"))
# 5. Rename ---------------------------------------------------------------

wdi_dat <- wdi_dat %>% rename("gdp_growth_wbi"= NY.GDP.MKTP.KD.ZG, 
                                   "gni_per_capita_wbi"= NY.GNP.PCAP.CD, 
                                   "gni_per_capita_ppp_wbi"= NY.GNP.PCAP.PP.CD,
                                   "population_wbi"= SP.POP.TOTL,
                                   "emp_agr_wbi" = SL.AGR.EMPL.ZS,
                                   "emp_ind_wbi" = SL.IND.EMPL.ZS,
                                   "emp_serv_wbi" = SL.SRV.EMPL.ZS,
                                   "emp_pop_wbi" = SL.EMP.TOTL.SP.ZS,
                                   "gini_in_wbi" = SI.POV.GINI,
                                   "income_sh_wbi" = SI.DST.10TH.10,
                                   "lfp_wbi" = SL.TLF.CACT.NE.ZS,
                                   "lfp_64_wbi" = SL.TLF.ACTI.ZS,
                                   "lf_educ_wbi" = SL.TLF.ADVN.ZS,
                                   "emp_self_wbi" = SL.EMP.SELF.ZS,
                                   "unemp_wbi" = SL.UEM.TOTL.NE.ZS,
                                   "unemp_e_wbi" = SL.UEM.TOTL.ZS,
                                   "emp_salaried_wbi" = SL.EMP.WORK.ZS,
                                   "emp_vulnerable_wbi" = SL.EMP.VULN.ZS,
                                   "emp_pt_wbi" = SL.TLF.PART.ZS,
                                   "emp_fem_pt_wbi" = SL.TLF.PART.FE.ZS,
                                   "emp_male_pt_wbi" = SL.TLF.PART.MA.ZS,
                                   "emp_mat_wbi" = SH.MMR.WAGE.ZS,
                                   "emp_sexratio_wbi" = SL.TLF.CACT.FM.NE.ZS,
                                   "emp_sexratio_e_wbi" = SL.TLF.CACT.FM.ZS,
                                   "emp_fem_serv_wbi" = SL.SRV.EMPL.FE.ZS,
                                   "emp_male_serv_wbi" = SL.SRV.EMPL.MA.ZS,
                                   "db_1720_wbi" = IC.BUS.EASE.DFRN.XQ.DB1719,
                                   "db_wbi" = IC.BUS.DFRN.XQ,
                                   "db_index_wbi" = IC.BUS.EASE.XQ)

#gdp_percapita_wb estaba en el libro de c?digos, pero no en la base


# 6. Label ----------------------------------------------------------------

# 7. Select ------------------------------------------------------

# 8. Save -----------------------------------------------------------------


# ruta: output/data/proc


