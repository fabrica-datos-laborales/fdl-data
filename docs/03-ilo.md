

# ILOSTAT

inline cuantos diferentes tipos de patrones ahy en ilostat (table(ilo)) y veo cuantas respuestas hay y lo pongo en la descripción: pongo la cobertura con inline


```r
#ilostat
labels1 <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0", range = c("B5:C629"), col_names = F) %>%
  slice(c(347:624)) %>% # selecciono 1, 2, donde parte -5, donde termina -5
  select(Variables = 1, Labels = 2)
```

```
## > Using an auto-discovered, cached token
```

```
##   To suppress this message, modify your code or options to clearly consent to
##   the use of a cached token
```

```
##   See gargle's "Non-interactive auth" vignette for more details:
```

```
##   <https://gargle.r-lib.org/articles/non-interactive-auth.html>
```

```
## > The googlesheets4 package is using a cached token for
## 'valentinaandrade@uchile.cl'
```

```
## Reading from "libro-codigos-fdl"
```

```
## Range "B5:C629"
```

```
## New names:
## * `` -> ...1
## * `` -> ...2
```

```r
labels2 <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1aw_byhiC4b_0XPcTDtsCpCeJHabK38i4pCmkHshYMB8/edit#gid=0", range = c("E5:G629"), col_names = F) %>%
  slice(c(347:624)) %>% # selecciono 1, 2, donde parte -5, donde termina -5
  select(Definition = 1, Values = 2, Class = 3)
```

```
## Reading from "libro-codigos-fdl"
```

```
## Range "E5:G629"
```

```
## New names:
## * `` -> ...1
## * `` -> ...2
## * `` -> ...3
```

```r
table_ilo <- c(labels1, labels2) 
ilo <- data.frame(matrix(unlist(table_ilo), nrow=280)) %>%
  select(Labels=1, Name=2, Definition=3 , Values=4, Class=5) 
```

```
## Warning in matrix(unlist(table_ilo), nrow = 280): la longitud de los datos
## [1390] no es un submúltiplo o múltiplo del número de filas [280] en la matriz
```

```r
knitr::kable(ilo, booktabs = T) %>% 
  kable_styling(latex_options = "striped", fixed_thead = T) %>%
  pack_rows("Mean Nominal Hourly Earning (ISCO08 classification)", 5, 40, bold = T) %>%
  pack_rows("Mean Nominal Hourly Earning (ISCO88 classification)", 41, 73, bold = T) %>%
  pack_rows("Employment by sex and institutional sector", 76, 84, bold = T) %>%
  pack_rows("Employment by sex and status in employment", 85, 99, bold = T) %>%
  pack_rows("Number of strikes and lockouts by economic activity", 100, 153, bold = T) %>%
  pack_rows("Days not worked due to strikes and lockouts by economic activity", 154, 213, bold = T) %>%
  pack_rows("Workers involved in strikes and lockouts by economic activity", 214, 265, bold = T) %>%
  pack_rows("Unemployment rate (%)", 266, 280, bold = T) 
```

<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Labels </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Definition </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Values </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Class </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> ud_ilostat </td>
   <td style="text-align:left;"> Mean nominal hourly earning of employees (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbc_ilostat </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Managers (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hourearn_isco08_total </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Professionals (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hourearn_isco08_1 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Technicians and associate professionals (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr grouplength="36"><td colspan="5" style="border-bottom: 1px solid;"><strong>Mean Nominal Hourly Earning (ISCO08 classification)</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco08_2 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Clerical support workers (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco08_3 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  Service and sales workers (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco08_4 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  Skilled agricultural, forestry and fishery workers (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco08_5 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  Craft and related trades workers (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco08_6 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  Plant and machine operators, and assemblers (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco08_7 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  Elementary occupations (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco08_8 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  Armed forces occupations (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco08_9 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Not elsewhere classified (Total ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco08_0 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men employees (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco08_X </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Managers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_total </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Professionals (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_1 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Technicians and associate professionals (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_2 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Clerical support workers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_3 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  men Service and sales workers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_4 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  men Skilled agricultural, forestry and fishery workers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_5 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  men Craft and related trades workers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_6 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  men Plant and machine operators, and assemblers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_7 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  men Elementary occupations (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_8 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  men Armed forces occupations (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_9 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Not elsewhere classified (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_0 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women employees (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco08_X </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Managers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_total </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Professionals (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_1 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Technicians and associate professionals (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_2 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Clerical support workers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_3 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  women Service and sales workers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_4 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  women Skilled agricultural, forestry and fishery workers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_5 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  women Craft and related trades workers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_6 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  women Plant and machine operators, and assemblers (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_7 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  women Elementary occupations (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_8 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  women Armed forces occupations (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_9 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Not elsewhere classified (ISCO08 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_0 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of employees (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco08_X </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Legislators, senior officials and managers (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_total </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  Professionals (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_1 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Technicians and associate professionals (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr grouplength="33"><td colspan="5" style="border-bottom: 1px solid;"><strong>Mean Nominal Hourly Earning (ISCO88 classification)</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_2 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  Clerks (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_3 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Service workers and shop and market sales workers (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_4 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Skilled agricultural and fishery workers (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_5 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Craft and related trades workers (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_6 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Plant and machine operators and assemblers (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_7 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Elementary occupations (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_8 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of Not elsewhere classified (Total ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_9 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men employees (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_isco88_X </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Legislators, senior officials and managers (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_total </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  men Professionals (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_1 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Technicians and associate professionals (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_2 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  men Clerks (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_3 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Service workers and shop and market sales workers (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_4 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Skilled agricultural and fishery workers (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_5 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Craft and related trades workers (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_6 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Plant and machine operators and assemblers (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_7 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Elementary occupations (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_8 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of men Not elsewhere classified (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_9 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women employees (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_masc_isco88_X </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Legislators, senior officials and managers (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_total </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  women Professionals (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_1 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Technicians and associate professionals (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_2 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of  women Clerks (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_3 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Service workers and shop and market sales workers (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_4 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Skilled agricultural and fishery workers (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_5 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Craft and related trades workers (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_6 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Plant and machine operators and assemblers (ISCO88 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_7 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Elementary occupations (ISCO88 classification) </td>
   <td style="text-align:left;"> The earnings of employees relate to the gross remuneration in cash and in kind paid to employees, paid monthly, for time worked or work done together with remuneration for time not worked, such as annual vacation, other type of paid leave or holidays. Data are converted to U.S. dollars as the common currency. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_8 </td>
   <td style="text-align:left;"> Mean nominal hourly earning of women Not elsewhere classified (ISCO88 classification) </td>
   <td style="text-align:left;"> Imputed observations are not based on national data, are subject to high uncertainty and should not be used for country comparisons or rankings.The labour income share in GDP is the ratio, in percentage, between total labour income and gross domestic product (a measure of total output), both provided in nominal terms. Labour income includes the compensation of employees and part of the income of the self-employed. Self-employed workers earn from both their work and capital ownership. Total compensation of employees refers to the remuneration, in cash or in kind, payable by an enterprise to an employee in return for work done by the latter during the accounting period. The labour income of self-employed is imputed on the basis of a statistical analysis of employees of similar characteristics. The labour income share after accounting for the labour income of the self-employed is often referred to as the adjusted labour income share in GDP. The series is part of the ILO modelled estimates and is harmonized to account for differences in national data and scope of coverage, collection and tabulation methodologies as well as for other country-specific factors. We use data that comes from administrative data, imputed and modelled observations. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_9 </td>
   <td style="text-align:left;"> Mean nominal monthly earning of employees (U.S. dollars) </td>
   <td style="text-align:left;"> The employed comprise all persons of working age who, during a specified brief period, were in the following categories: a) paid employment (whether at work or with a job but not at work); or b) self-employment (whether at work or with an enterprise but not at work). Data are provided by institutional sector, which refers to disaggregations by public and private sector employment. Public sector employment covers employment in the government sector plus employment in publicly-owned resident enterprises and companies, operating at central, state (or regional) and local levels of government. It covers all persons employed directly by those institutions, regardless of the particular type of employment contract. Private sector employment comprises employment in all resident units operated by private enterprises, that is, it excludes enterprises controlled or operated by the government sector. We exclude data that is unreliable, according to ILOSTAT observations. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> hourearn_fem_isco88_X </td>
   <td style="text-align:left;"> Labour income share as a percent of GDP </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> month_earn_ilostat </td>
   <td style="text-align:left;"> Total employment </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> labor_inc_share_ilostat </td>
   <td style="text-align:left;"> Total employment in public sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;"> emp_total </td>
   <td style="text-align:left;"> Total employment in private sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;"> emp_pub </td>
   <td style="text-align:left;"> Male employment in total </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr grouplength="9"><td colspan="5" style="border-bottom: 1px solid;"><strong>Employment by sex and institutional sector</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_pri </td>
   <td style="text-align:left;"> Male employment in public sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_masc_total </td>
   <td style="text-align:left;"> Male employment in private sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_masc_pub </td>
   <td style="text-align:left;"> Female employment in total </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_masc_pri </td>
   <td style="text-align:left;"> Female employment in public sector </td>
   <td style="text-align:left;"> Imputed observations are not based on national data, are subject to high uncertainty and should not be used for country comparisons or rankings. The employed comprise all persons of working age who, during a specified brief period, were in one of the following categories: a) paid employment (whether at work or with a job but not at work); or b) self-employment (whether at work or with an enterprise but not at work). Data are disaggregated by status in employment according to the latest version of the International Standard Classification of Status in Employment (ICSE-93). Status in employment refers to the type of explicit or implicit contract of employment the person has with other persons or organizations. The basic criteria used to define the groups of the classification are the type of economic risk and the type of authority over establishments and other workers which the job incumbents have or will have. The series is part of the ILO modelled estimates and is harmonized to account for differences in national data and scope of coverage, collection and tabulation methodologies as well as for other country-specific factors. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_fem_total </td>
   <td style="text-align:left;"> Female employment in private sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_fem_pub </td>
   <td style="text-align:left;"> Total employment (ICSE93 status classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_fem_pri </td>
   <td style="text-align:left;"> Total employment in Employees status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_total_icse93 </td>
   <td style="text-align:left;"> Total employment in Employers status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_total_icse93_1 </td>
   <td style="text-align:left;"> Total employment in Own-account workers status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr grouplength="15"><td colspan="5" style="border-bottom: 1px solid;"><strong>Employment by sex and status in employment</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_total_icse93_2 </td>
   <td style="text-align:left;"> Total employment in Contributing family workers status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_total_icse93_3 </td>
   <td style="text-align:left;"> Male total employment status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_total_icse93_5 </td>
   <td style="text-align:left;"> Male employment in Employees status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_masc_icse93_total </td>
   <td style="text-align:left;"> Male employment in Employers status  (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_masc_icse93_1 </td>
   <td style="text-align:left;"> Male employment in Own-account workers status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_masc_icse93_2 </td>
   <td style="text-align:left;"> Male employment in Contributing family workers status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_masc_icse93_3 </td>
   <td style="text-align:left;"> Female total employment status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_masc_icse93_5 </td>
   <td style="text-align:left;"> Female employment in Employees status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_fem_icse93_total </td>
   <td style="text-align:left;"> Female employment in Employers status  (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_fem_icse93_1 </td>
   <td style="text-align:left;"> Female employment in Own-account workers status (ICSE93 classification) </td>
   <td style="text-align:left;"> A strike is a temporary work stoppage carried out by one or more groups of workers with a view to enforcing or resisting demands or expressing grievances, or supporting other workers in their demands or grievances. A lockout is a total or partial temporary closure of one or more places of employment, or the hindering of the normal work activities of employees, by one or more employers with a view to enforcing or resisting demands or expressing grievances, or supporting other employers in their demands or grievances. Data are disaggregated by economic activity according to the latest version of the International Standard Industrial Classification of All Economic Activities (ISIC) available for that year. We transformed the data with observations into NAs. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_fem_icse93_2 </td>
   <td style="text-align:left;"> Female employment in Contributing family workers status (ICSE93 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_fem_icse93_3 </td>
   <td style="text-align:left;"> Number of strikes and lockouts total (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> emp_fem_icse93_5 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Manufacturing (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_total </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Electricity, gas and water supply (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_D </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Construction (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr grouplength="54"><td colspan="5" style="border-bottom: 1px solid;"><strong>Number of strikes and lockouts by economic activity</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_E </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Wholesale and retail trade; repair of motor vehicles, motorcycles and personal and household goods (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_F </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Hotels and restaurants (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_G </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Transport, storage and communications (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_H </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Financial intermediation (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_I </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Health and social work (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_J </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Not elsewhere classified (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_N </td>
   <td style="text-align:left;"> Number of strikes and lockouts in total broad sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_X </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Real estate, renting and business activities (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_sector_total </td>
   <td style="text-align:left;"> Number of strikes and lockouts total (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_K </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Wholesale and retail and restaurants and hotels (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_total </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Construction (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_6 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Mining and quarrying (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_5 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Manufacturing (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_2 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Electricity, gas and water (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_3 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Transport, storage and comunication (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_4 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Financing, insurance, real estate and business services(ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_7 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Community, social and personal services(ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_8 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Agriculture, hunting and forestry (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_9 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Fishing (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_A </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Mining and quarrying (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_B </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Public administration and defence; compulsory social security (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_C </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Education (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_L </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Other community, social and personal service activities (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_M </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Extraterritorial organizations and bodies (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_O </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Agriculture, hunting, forestry and fishing (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_Q </td>
   <td style="text-align:left;"> Number of strikes and lockouts total (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_1 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Activities not adequately defined (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_total </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Mining and quarrying (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic2_0 </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Manufacturing (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_B </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Electricity; gas, steam and air conditioning supply (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_C </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Water supply; sewerage, waste management and remediation activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_D </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Construction (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_E </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Wholesale and retail trade; repair of motor vehicles and motorcycles (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_F </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Transportation and storage (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_G </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Accommodation and food service activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_H </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Information and communication (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_I </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Professional, scientific and technical activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_J </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Administrative and support service activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_M </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Public administration and defence; compulsory social security (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_N </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Education (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_O </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Human health and social work activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_P </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Arts, entertainment and recreation (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_Q </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Other service activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_R </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Financial and insurance activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_S </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Agriculture; forestry and fishing (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_K </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Real estate activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_A </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Activities of households as employers; undifferentiated goods- and services-producing activities of households for own use (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_L </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Activities of extraterritorial organizations and bodies (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_T </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Not elsewhere classified (ISIC4 classification) </td>
   <td style="text-align:left;"> Days not worked as a result of strikes and lockouts represent the total number of working days not worked as a result of strikes and lockouts in progress during the year. It is measured in terms of the sum of the actual working days during which work would normally have been carried out by each worker involved had there been no stoppage. Data are disaggregated by economic activity according to the latest version of the International Standard Industrial Classification of All Economic Activities (ISIC) available for that year. We transformed the data with observations into NAs. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_U </td>
   <td style="text-align:left;"> Number of strikes and lockouts in Activities of private households as employers and undifferentiated production activities of private households (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic4_X </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts total (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nstrikes_isic31_P </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Manufacturing (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_total </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Electricity, gas and water supply (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_D </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Construction (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr grouplength="60"><td colspan="5" style="border-bottom: 1px solid;"><strong>Days not worked due to strikes and lockouts by economic activity</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_E </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Wholesale and retail trade; repair of motor vehicles, motorcycles and personal and household goods (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_F </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Hotels and restaurants (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_G </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Transport, storage and communications (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_H </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Financial intermediation (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_I </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Health and social work (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_J </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Not elsewhere classified (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_N </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in total broad sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_X </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Real estate, renting and business activities (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_sector_total </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts total (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_K </td>
   <td style="text-align:left;"> Days not worked due to  strikes and lockouts in Wholesale and retail and restaurants and hotels (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_total </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Construction (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_6 </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Mining and quarrying (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_5 </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Manufacturing (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_2 </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Electricity, gas and water (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_3 </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Transport, storage and comunication (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_4 </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Financing, insurance, real estate and business services(ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_7 </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Community, social and personal services(ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_8 </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Agriculture, hunting and forestry (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_9 </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Fishing (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_A </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Mining and quarrying (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_B </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Public administration and defence; compulsory social security (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_C </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Education (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_L </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Other community, social and personal service activities (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_M </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Extraterritorial organizations and bodies (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_O </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Agriculture, hunting, forestry and fishing (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_Q </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts total (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_1 </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Activities not adequately defined(ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_total </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Mining and quarrying (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic2_0 </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Manufacturing (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_B </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Electricity; gas, steam and air conditioning supply (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_C </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Water supply; sewerage, waste management and remediation activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_D </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Construction (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_E </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Wholesale and retail trade; repair of motor vehicles and motorcycles (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_F </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Transportation and storage (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_G </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Accommodation and food service activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_H </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Information and communication (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_I </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Professional, scientific and technical activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_J </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Administrative and support service activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_M </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Public administration and defence; compulsory social security (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_N </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Education (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_O </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Human health and social work activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_P </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Arts, entertainment and recreation (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_Q </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Other service activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_R </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Financial and insurance activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_S </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Agriculture; forestry and fishing (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_K </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Real estate activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_A </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Activities of households as employers; undifferentiated goods- and services-producing activities of households for own use (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_L </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Activities of extraterritorial organizations and bodies (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_T </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Not elsewhere classified (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_U </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Activities of private households as employers and undifferentiated production activities of private households (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_X </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Agriculture; forestry and fishing (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_P </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Real estate activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_A </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Activities of households as employers; undifferentiated goods- and services-producing activities of households for own use (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_L </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Activities of extraterritorial organizations and bodies (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_T </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Not elsewhere classified (ISIC4 classification) </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts represents the number of workers implicated directly or indirectly at any time during a strike or lockout, whether the involvement was for the full duration of the strike or lockout or only part of it. Workers who are unable to work as a result of the secondary effects of strikes or lockouts should not be included. Data are disaggregated by economic activity according to the latest version of the International Standard Industrial Classification of All Economic Activities (ISIC) available for that year. We transformed the data with observations into NAs. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_U </td>
   <td style="text-align:left;"> Days not worked due to strikes and lockouts in Activities of private households as employers and undifferentiated production activities of private households (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic4_X </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts total (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> ndays_isic31_P </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Electricity, gas and water supply (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_total </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Construction (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_E </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Wholesale and retail trade; repair of motor vehicles, motorcycles and personal and household goods (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr grouplength="52"><td colspan="5" style="border-bottom: 1px solid;"><strong>Workers involved in strikes and lockouts by economic activity</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_F </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Manufacturing (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_G </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Transport, storage and communications (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_H </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Financial intermediation (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_I </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Health and social work (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_J </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Not elsewhere classified (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_N </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in total broad sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_X </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in non agriculture broad sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_sector_total </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in industry broad sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_sector_nag </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts not elsewhere classified broad sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_sector_ind </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Real estate, renting and business activities (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_sector_X </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in services broad sector </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_K </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts total (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_sector_ser </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Wholesale and retail and restaurants and hotels (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_total </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Construction (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_6 </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Mining and quarrying (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_5 </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Manufacturing (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_2 </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Electricity, gas and water (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_3 </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Transport, storage and comunication (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_4 </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Financing, insurance, real estate and business services(ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_7 </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Community, social and personal services(ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_8 </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Agriculture, hunting and forestry (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_9 </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Fishing (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_A </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Mining and quarrying (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_B </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Manufacturing (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_C </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Public administration and defence; compulsory social security (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_D </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Education (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_L </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Other community, social and personal service activities (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_M </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Extraterritorial organizations and bodies (ISIC3.1 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_O </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Agriculture, hunting, forestry and fishing (ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic31_Q </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Activities not adequately defined(ISIC2 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_1 </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Mining and quarrying (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic2_0 </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Manufacturing (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_B </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Electricity; gas, steam and air conditioning supply (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_C </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Water supply; sewerage, waste management and remediation activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_D </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Construction (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_E </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Wholesale and retail trade; repair of motor vehicles and motorcycles (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_F </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Transportation and storage (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_G </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Accommodation and food service activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_H </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Information and communication (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_I </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Professional, scientific and technical activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_J </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Administrative and support service activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_M </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Public administration and defence; compulsory social security (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_N </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Education (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_O </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Human health and social work activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_P </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Arts, entertainment and recreation (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_Q </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Other service activities (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_R </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts in Financial and insurance activities (ISIC4 classification) </td>
   <td style="text-align:left;"> The unemployment rate conveys the number of persons who are unemployed as a percent of the labour force (i.e., the employed plus the unemployed). The unemployed comprise all persons of working age who were: a) without work during the reference period, i.e. were not in paid employment or self-employment; b) currently available for work, i.e. were available for paid employment or self-employment during the reference period; and c) seeking work, i.e. had taken specific steps in a specified recent period to seek paid employment or self-employment. We transformed the data with observations into NAs. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_S </td>
   <td style="text-align:left;"> Workers involved in strikes and lockouts total (ISIC4 classification) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_K </td>
   <td style="text-align:left;"> Unemployment rate in +15 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> nworkers_isic4_total </td>
   <td style="text-align:left;"> Unemployment rate in 15-64 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_total_15 </td>
   <td style="text-align:left;"> Unemployment rate in 15-24 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_total_1564 </td>
   <td style="text-align:left;"> Unemployment rate in +25 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr grouplength="15"><td colspan="5" style="border-bottom: 1px solid;"><strong>Unemployment rate (%)</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_total_1524 </td>
   <td style="text-align:left;"> Male unemployment rate in +15 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_total_25 </td>
   <td style="text-align:left;"> Male unemployment rate in 15-64 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_masc_15 </td>
   <td style="text-align:left;"> Male unemployment rate in 15-24 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_masc_1564 </td>
   <td style="text-align:left;"> Male unemployment rate in +25 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_masc_1524 </td>
   <td style="text-align:left;"> Female unemployment rate in +15 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_masc_25 </td>
   <td style="text-align:left;"> Female unemployment rate in 15-64 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> ud_ilostat </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_fem_15 </td>
   <td style="text-align:left;"> Female unemployment rate in 15-24 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> cbc_ilostat </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_fem_1564 </td>
   <td style="text-align:left;"> Female unemployment rate in +25 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> hourearn_isco08_total </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_fem_1524 </td>
   <td style="text-align:left;"> Other sexes unemployment rate in +15 years </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> hourearn_isco08_1 </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_fem_25 </td>
   <td style="text-align:left;"> Other sexes unemployment rate in 15-24 years </td>
   <td style="text-align:left;"> (0-100) </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> hourearn_isco08_2 </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_other_15 </td>
   <td style="text-align:left;"> Other sexes unemployment rate in +25 years </td>
   <td style="text-align:left;"> (0-100) </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> hourearn_isco08_3 </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_other_1524 </td>
   <td style="text-align:left;"> Percentage of employees who are members of a trade union. A trade union is defined as a workers' organization constituted for the purpose of furthering and defending the interests of workers. For the purposes of promoting international comparability of the statistics presented in ILOSTAT, trade union membership refers only to union members who are employees. That is, it excludes union members who are not in paid employment (self-employed, unemployed, retired, etc.) unless otherwise stated in the notes. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> hourearn_isco08_4 </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> unemp_other_25 </td>
   <td style="text-align:left;"> Percentage of workers covered by collective bargaining, that is, all those workers whose pay and/or conditions of employment are determined by one or more collective agreement(s). Collective bargaining agreements refer to all agreements in writing regarding working conditions and terms of employment concluded between an employer, a group of emplores or one or more employers' organisations, on the one hand, and one or more representative workers' organisations, on the other. Collective bargaining coverage includes, to the extent possible, workers covered by collective agreements by virtue of their extension, as well as workers covered by collective agreements concluded in previous years but still in force. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> hourearn_isco08_5 </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> Trade union density rate (%) </td>
   <td style="text-align:left;"> The earnings of employees relate to the gross remuneration in cash and in kind paid to employees, paid hourly, for time worked or work done together with remuneration for time not worked, such as annual vacation, other type of paid leave or holidays. Data are converted to U.S. dollars as the common currency. </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> hourearn_isco08_6 </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> Collective bargaining coverage rate (%) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0-8) </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> hourearn_isco08_7 </td>
  </tr>
</tbody>
</table>



## ILO-EPLEX
<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Labels </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Definition </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Values </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Class </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> ftc_reg_eplex </td>
   <td style="text-align:left;"> FTC regulated </td>
   <td style="text-align:left;"> Whether the fixed-term contracts are regulated or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ftc_max_eplex </td>
   <td style="text-align:left;"> Maximum cumulative duration of succesive FTCs </td>
   <td style="text-align:left;"> Maximum cumulative duration of succesive Fixed-term contracts in months </td>
   <td style="text-align:left;"> 0= No limitation, 1= No limitation on first FTC, 2= Objective and material reasons </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ftc_max_nocum_eplex </td>
   <td style="text-align:left;"> Maximum not-cumulative duration of succesive FTCs </td>
   <td style="text-align:left;"> Maximum not-cumulative duration of succesive Fixed-term contracts in months </td>
   <td style="text-align:left;"> 0-72 </td>
   <td style="text-align:left;"> numeric </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ftc_valid_eplex </td>
   <td style="text-align:left;"> Valid reasons for FTC use </td>
   <td style="text-align:left;"> Valid reasons for fixed-term contracts use </td>
   <td style="text-align:left;"> 0= No limitation, 1= No limitation on first FTC, 2= Objective and material reasons </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lc_mine_eplex </td>
   <td style="text-align:left;"> Legal coverage: mine workers </td>
   <td style="text-align:left;"> Whether mine workers are protected by legal regulation or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lc_bcollar_eplex </td>
   <td style="text-align:left;"> Legal coverage: blue-collar workers </td>
   <td style="text-align:left;"> Whether blue-collar workers are protected by legal regulation or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lc_civilserv_eplex </td>
   <td style="text-align:left;"> Legal coverage: civil/public servants </td>
   <td style="text-align:left;"> Whether civil/public servants workers are protected by legal regulation or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lc_domestic_eplex </td>
   <td style="text-align:left;"> Legal coverage: domestic workers </td>
   <td style="text-align:left;"> Whether domestic workers are protected by legal regulation or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lc_dockers_eplex </td>
   <td style="text-align:left;"> Legal coverage: dock workers </td>
   <td style="text-align:left;"> Whether dock workers are protected by legal regulation or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lc_managerial_eplex </td>
   <td style="text-align:left;"> Legal coverage: managerial/executive positions </td>
   <td style="text-align:left;"> Whether managerial/executive positions workers are protected by legal regulation or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lc_agric_eplex </td>
   <td style="text-align:left;"> Legal coverage: agricultural workers </td>
   <td style="text-align:left;"> Whether agricultural workers are protected by legal regulation or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lc_teachers_eplex </td>
   <td style="text-align:left;"> Legal coverage: teachers </td>
   <td style="text-align:left;"> Whether agricultural workers are protected by legal regulation or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> spd_pregnant_eplex </td>
   <td style="text-align:left;"> Special protection dismissal: pregnant women and/or women on maternity leave </td>
   <td style="text-align:left;"> Whether pregnant women and/or women on maternity leave have a special protection against dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> spd_familyresp_eplex </td>
   <td style="text-align:left;"> Special protection dismissal: workers with family responsibilities </td>
   <td style="text-align:left;"> Whether workers with family responsibilities have a special protection against dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> spd_older_eplex </td>
   <td style="text-align:left;"> Special protection dismissal: older workers/workers on the verge of retirement </td>
   <td style="text-align:left;"> Whether older workers/workers on the verge of retirement have a special protection against dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> spd_wrep_eplex </td>
   <td style="text-align:left;"> Special protection dismissal: workers' representative </td>
   <td style="text-align:left;"> Whether workers' representatives have a special protection against dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> spd_disab_eplex </td>
   <td style="text-align:left;"> Special protection dismissal: workers with disabilities </td>
   <td style="text-align:left;"> Whether workers with disabilities have a special protection against dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> spd_occ_dis_eplex </td>
   <td style="text-align:left;"> Special protection dismissal: workers on temporary leave following an occupational disease or a work injury </td>
   <td style="text-align:left;"> Whether workers on temporary leave following an occupational disease or a work injury have a special protection against dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> spd_longperiod_eplex </td>
   <td style="text-align:left;"> Special protection dismissal: workers with a long period of service </td>
   <td style="text-align:left;"> Whether workers with a long period of service have a special protection against dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vd_conduct_eplex </td>
   <td style="text-align:left;"> Valid grounds for dismissal: worker's conduct </td>
   <td style="text-align:left;"> Whether the worker's conduct is a valid ground for dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vd_capacity_eplex </td>
   <td style="text-align:left;"> Valid grounds for dismissal: worker's capacity </td>
   <td style="text-align:left;"> Whether the worker's capacities are a valid ground for dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vd_economic_eplex </td>
   <td style="text-align:left;"> Valid grounds for dismissal: economic reasons </td>
   <td style="text-align:left;"> Whether economic reasons are a valid ground for dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pd_tum_eplex </td>
   <td style="text-align:left;"> Prohibited grounds for dismissal: trade union membership and activities </td>
   <td style="text-align:left;"> Whether the trade union membership is a prohibited ground for dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pd_strike_eplex </td>
   <td style="text-align:left;"> Prohibited grounds for dismissal: participation in a lawful strike </td>
   <td style="text-align:left;"> Whether the participation in a lawful strike is a prohibited ground for dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pd_pol_op_eplex </td>
   <td style="text-align:left;"> Prohibited grounds for dismissal: political opinion </td>
   <td style="text-align:left;"> Whether the political opinion is a prohibited ground for dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pd_pregnant_eplex </td>
   <td style="text-align:left;"> Prohibited grounds for dismissal: pregnancy </td>
   <td style="text-align:left;"> Whether pregnancy is a prohibited ground for dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pd_disab_eplex </td>
   <td style="text-align:left;"> Prohibited grounds for dismissal: disabilities </td>
   <td style="text-align:left;"> Whether disabilities are a prohibited ground for dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pd_complain_eplex </td>
   <td style="text-align:left;"> Prohibited grounds for dismissal: filling a complaint against the employer </td>
   <td style="text-align:left;"> Whetherfilling a complaint against the employer is a prohibited ground for dismissal or not </td>
   <td style="text-align:left;"> 1= Yes, 2= No </td>
   <td style="text-align:left;"> factor </td>
  </tr>
</tbody>
</table>

