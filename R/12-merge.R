# Code 12: Merge data  --------------------------------------------------------------
# 1. Load packages --------------------------------------------------------
pacman::p_load(tidyverse, readr, sjPlot, summarytools)

# 2. Load data ------------------------------------------------------------
## File names
file_names=as.list(dir(path ="output/data/proc/", pattern="*.rds"))

file_names = lapply(file_names, function(x) paste0('output/data/proc/', x))

## List of data frames
r <- lapply(file_names, readRDS, environment())

# 2. Proc -----------------------------------------------------------------
names(r) <- gsub("output/data/proc/|.rds","", file_names)

r <- Map(function(x, y) {names(x) <- paste0(names(x), '_',  y); x}, r, names(r))

list_fdl <- r

rm(list = ls(pattern = "r|file_names"))
# 3. Merge list -----------------------------------------------------------
fdl <- list_fdl %>%  reduce(full_join, by = c("iso3c", "year"))

purrr::keep(list_fdl,.p = ~stringr::str_detect(.x, ""))

# Save --------------------------------------------------------------------
save(fdl, r, file = "output/data/fdl.RData")

