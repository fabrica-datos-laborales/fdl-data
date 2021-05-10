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
datos$variable <- car::recode(datos$variable_vieja, 
                              c("1 = 'Yes';2 = 'No'"), as.factor = T,
                              levels = c("Yes", "No"))
# 5. Rename ---------------------------------------------------------------

# 6. Label ----------------------------------------------------------------

# 7. Select ------------------------------------------------------

# 8. Save -----------------------------------------------------------------


# ruta: output/data/proc


