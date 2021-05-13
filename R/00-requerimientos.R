# Code requierements ------------------------------------------------------

if (!require("remotes")) install.packages("remotes")

if (!require("OECD")) remotes::install_github("expersso/OECD")

if (!require("Rilostat")) remotes::install_github("ilostat/Rilostat", force = TRUE)

# CRAN
paquetes <- c("tidyverse", "WDI","haven", "rvest", "kableExtra", "sjlabelled",
              "pdftools", "ggsci", "readxl", "readsdmx", "googlesheets4")

for(p in paquetes) {
  
  if (!require(p)) install.packages(p)
  
}
