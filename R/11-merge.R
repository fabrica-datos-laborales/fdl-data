# Code 12: Merge data  --------------------------------------------------------------
# 1. Load packages --------------------------------------------------------
pacman::p_load(tidyverse, readr, sjPlot)

# 2. Load data ------------------------------------------------------------
file_names=as.list(dir(path ="output/data/proc/", pattern="*.rds"))
file_names = lapply(file_names, function(x) paste0('output/data/proc/', x))
r <- lapply(file_names, readRDS, environment()); remove(file_names)

# 3. Merge list -----------------------------------------------------------
fdl <- r %>%  reduce(full_join, by = c("iso3c", "year"))

# Save --------------------------------------------------------------------
save(fdl, file = "output/data/fdl.RData")

