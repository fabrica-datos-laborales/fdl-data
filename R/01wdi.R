# Code: World Bank --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(WDI, tidyverse)

# 2. Search ---------------------------------------------------------------
WDIsearch("gdp growth")
#NY.GDP.MKTP.KD.ZG # GDP growth (annual %)

WDIsearch("gdp per capita")
# 6.0.GDPpc_constant GDP per capita, PPP (constant 2011 international $)

WDIsearch("doing")

wdi_dat <- WDI(indicator = c("NY.GDP.MKTP.KD.ZG", "6.0.GDPpc_constant"), start = 1960, end = 2021, extra = TRUE) 
names(wdi_dat)
wdi_dat %>% group_by(year)%>% 
  summarise(n = n()) %>% tail()
  