# Code 0: Process ICTWSS ---------------------------------------------------------

# 1. Load packages  -------------------------------------------------------
pacman::p_load(tidyverse, haven, rvest, kableExtra, sjlabelled, pdftools)

# 2. Load data base -------------------------------------------------------
ictwss <- haven::read_dta(url("https://aias.s3.eu-central-1.amazonaws.com/website/uploads/ICTWSS_v6_1_Stata_release.dta"))
ictwss_pdf <- pdftools::pdf_text( pdf = "https://aias.s3.eu-central-1.amazonaws.com/website/uploads/ICTWSS_6_1_Codebook.pdf") %>% 
  str_split("\n")


for (i in 31) {
  ictwss_pdf[[i]] <- ictwss_pdf[[i]][-1:-10]
  a <- lenght(ictwss_pdf[[i]])
  b <- a-8
  ictwss_pdf[[i]] <- ictwss_pdf[[i]][-b:-a]
}

## ISSP

issp <- haven::read_dta("input/data/issp/ZA6770_v2-1-0.dta")

## ISO Code

iso <- read_html('https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2') %>% 
  html_node('.wikitable.sortable') %>% 
  html_table() %>%
  group_by(Code) %>% 
  filter(Year == max(Year)) %>% 
  select(iso2c=Code, country_name = "Country name (using title case)")


# 2. Explore --------------------------------------------------------------
issp <- issp %>% mutate(year = 2015, iso2c = c_alphan)

rrll <- ictwss %>% merge(issp, by = c("iso2c", "year"), all.y = T) %>%
  distinct(iso2c, year, .keep_all = T) %>%
  merge(iso, by = c("iso2c"))

rrll %>%
  select(iso2c, country_name, year, ictwss=country.x, issp=country.y) %>% 
  mutate(ictwss = if_else(!is.na(ictwss), "Presence", "Absent"),
         issp = if_else(!is.na(issp), "Presence", "Absent")) %>% 
  kable(digits = 2, row.names = F,  booktabs = T,  format = "html",
        col.names = c("Code", "Country name", "Year", "ICTWSS","ISSP"),
        caption = "<b>Table 1</b>: Compare ICTWSS-ISSP") %>% 
  kableExtra::kable_styling(bootstrap_options = c("striped", "hold_position"), full_width = F) %>% 
  save_kable(file = "table-compare-ictwss-issp.html")


## Export
labels <- sjlabelled::label_to_colnames(ictwss)
labels <- data.frame(V1=names(labels), V2=unname(t(labels)))
labels <- select(labels, V1)
tab <- data.frame(V0=names(ictwss), V2=unname(t(ictwss)))
tab <- select(tab, V0)
tab <- cbind(tab,labels)
tab <- tab %>%  mutate(V0 = paste(V0,"_ictwss"))
writexl::write_xlsx(tab, "tab.xlsx")

# UD Cov ----------------------------------------------------------------
tab1 <- ictwss %>% select(-country, -country_code) %>%
  select(where(is.character), year) %>% 
  pivot_longer(cols = !c(iso2c, year),
               values_ptypes = list(value = character())) %>% 
  filter(value != "", grepl("UD", name))%>% 
  {table(.$iso2c)}

tab1 <- as.data.frame(tab1)

#  Adjcov -------------------------------------------------------------
tab2 <- ictwss %>% select(-country, -country_code) %>%
  select(where(is.numeric), iso2c, year) %>% 
  pivot_longer(cols = !c(iso2c, year),
               values_ptypes = list(value = double())) %>% 
  filter(value != "", grepl("AdjCov", name))%>% 
  {table(.$iso2c)}

tab2 <- as.data.frame(tab2)

#  UD -------------------------------------------------------------
tab1 <- ictwss %>% select(-country, -country_code) %>%
  select(where(is.numeric), iso2c, year) %>% 
  pivot_longer(cols = !c(iso2c, year),
               values_ptypes = list(value = double())) %>% 
  filter(value != "", name  == "UD")%>% 
  {table(.$iso2c)}

tab1 <- as.data.frame(tab1)

tab <- merge(tab1, tab2, by = "Var1", all.x = T)

tab %>%
  merge(iso, by.x = "Var1", by.y = c("iso2c")) %>%
  select(country_name, everything ()) %>% 
  kable(digits = 2, row.names = F,  booktabs = T,  format = "html",
                col.names = c("Country name", "Code", "UD", "Adjcov"),
                caption = "<b>Table 2</b>: Coverage UD and AdjCov") %>% 
  kableExtra::kable_styling(bootstrap_options = c("striped", "hold_position"), full_width = F) %>% 
  save_kable(file = "table-compare ud-adj.html")

