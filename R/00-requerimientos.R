# Code requierements ------------------------------------------------------

if (!require("remotes")) install.packages("remotes")

if (!require("OECD")) remotes::install_github("expersso/OECD")

if (!require("Rilostat")) remotes::install_github("ilostat/Rilostat", force = TRUE)

if (!require("vdemdata")) devtools::install_github("vdeminstitute/vdemdata")

# CRAN
paquetes <- c("tidyverse","Hmisc","readr", "WDI","haven", "rvest", "kableExtra", "sjlabelled", "devtools",
              "pdftools", "ggsci", "readxl", "readsdmx", "googlesheets4", "countrycode", "survey", "srvyr")

for(p in paquetes) {
  
  if (!require(p)) install.packages(p)
  
}
