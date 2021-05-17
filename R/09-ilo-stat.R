# Code: ILOSTAT --------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(Rilostat, tidyverse)

# 2. Scrapping ------------------------------------------------------------
ud <- Rilostat::get_ilostat("ILR_TUMT_NOC_RT_A") %>% 
  select(iso3c = ref_area, year=time, ud= obs_value)

cbc <- Rilostat::get_ilostat("ILR_CBCT_NOC_RT_A")
# seguir hasta el final

# 3. Recode and rename---------------------------------------------------------------
## Similar a ocde02

# 4. Merge ----------------------------------------------------------------
data_ilo <- lapply(ls(),get)
data_ilo <- Reduce(function(x,y) merge (x, y, by = c("iso3c", "year")))

# 5. Label ----------------------------------------------------------------

# 6. Save -----------------------------------------------------------------
## save data_ilo.rds