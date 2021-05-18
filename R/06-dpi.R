# Code: DPI ----------------------------------------------------------
# 1. Install packages -----------------------------------------------------
pacman::p_load(tidyverse, readr)

# 2. Scrapp dpi --------------------------------------------------------------
# https://mydata.iadb.org/Reform-Modernization-of-the-State/Database-of-Political-Institutions-2017/938i-s2bw/data
dpi <- readr::read_csv("https://mydata.iadb.org/api/views/938i-s2bw/rows.csv?accessType=DOWNLOAD")
# glimpse(dpi) o str(dpi)

# 3. Recode and rename ---------------------------------------------------------------
## Fijense en como estan codificados NA (999, -999, etc)

## factorizar respuestas

# 4. Select ------------------------------------------------------------------

# 5. Save -----------------------------------------------------------------



