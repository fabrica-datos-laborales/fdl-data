# Code 14 : Latinobarometro  --------------------------------------------------


# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse,rvest, Hmisc, countrycode, survey, srvyr, Hmisc, haven)

# 2. Load data ------------------------------------------------------------

## File names

file_names=as.list(dir(path ="input/data/lat/", pattern="*.sav"))

file_names = lapply(file_names, function(x) paste0('input/data/lat/', x))

## List of data frames
r <- lapply(file_names, haven::read_sav)

# 2. Proc -----------------------------------------------------------------
names(r) <- gsub("input/data/lat/latino|1995|1996|1997|1998|2000|2001|2002|
                 2003|2004|2005|2006|2007|2008|2009|2010|2011|2013|2015|2016|
                 2017|2018|.sav","", file_names)

r <- Map(function(x, y) {names(x) <- paste0(names(x), '_',  y); x}, r, names(r))

list_lat <- r

rm(list = ls(pattern = "r|file_names"))

# 3. Unlist ---------------------------------------------------------------
list2env(list_lat, envir = .GlobalEnv)


# 0. Apertura provisional de datos -------------------------------------------

latino1995 <- read_sav("input/data/lat/latino1995.sav")
latino1996 <- read_sav("input/data/lat/latino1996.sav")
latino1997 <- read_sav("input/data/lat/latino1997.sav")
latino1998 <- read_sav("input/data/lat/latino1998.sav")
latino2000 <- read_sav("input/data/lat/latino2000.sav")
latino2001 <- read_sav("input/data/lat/latino2001.sav")
latino2002 <- read_sav("input/data/lat/latino2002.sav")
latino2003 <- read_sav("input/data/lat/latino2003.sav")
latino2004 <- read_sav("input/data/lat/latino2004.sav")
latino2005 <- read_sav("input/data/lat/latino2005.sav")
latino2006 <- read_sav("input/data/lat/latino2005.sav")
latino2007 <- read_sav("input/data/lat/latino2006.sav")
latino2008 <- read_sav("input/data/lat/latino2008.sav")
latino2009 <- read_sav("input/data/lat/latino2009.sav")
latino2010 <- read_sav("input/data/lat/latino2010.sav")
latino2011 <- read_sav("input/data/lat/latino2011.sav")
latino2013 <- read_sav("input/data/lat/latino2013.sav")
latino2015 <- read_sav("input/data/lat/latino2015.sav")
latino2016 <- read_sav("input/data/lat/latino2016.sav")
latino2017 <- read_sav("input/data/lat/latino2017.sav")
latino2018 <- read_sav("input/data/lat/latino2018.sav")