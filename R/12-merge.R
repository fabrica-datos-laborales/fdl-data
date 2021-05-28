# Code 12: Merge data  --------------------------------------------------------------
# 1. Load packages --------------------------------------------------------
pacman::p_load(tidyverse, readr, sjPlot)

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
# 3. Clean list -----------------------------------------------------------
arregla_names <- function(x) {
  ifelse(
    stringr::str_detect(x, "^iso3c|^year"),
    stringr::str_remove_all(x, "_.*"),
    x
  )
}

list_fdl <- purrr::map(list_fdl, dplyr::rename_all, arregla_names)

# 4. Mutate list ----------------------------------------------------------
list_fdl <- map(list_fdl, mutate, year = as.numeric(year))

# 5. Merge list -----------------------------------------------------------
fdl <- list_fdl %>%  reduce(full_join, by = c("iso3c", "year"))

# 6. Label year -----------------------------------------------------------
Hmisc::label(fdl$year) <- "Year"

# Save --------------------------------------------------------------------
save(fdl, list_fdl, file = "output/data/fdl.RData")

