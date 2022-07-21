---
title: "Fábrica de Datos Laborales"
subtitle: "<center>Codebook</center>"
author: "PI: Pablo Pérez Ahumada <br> RA: Valentina Andrade <br> Collaborators: Emilia Cuadros y Nicolás Godoy"
date: "21 julio 2022"
site: bookdown::bookdown_site
documentclass: book
#bibliography: [book.bib] #packages.bib
biblio-style: apalike
link-citations: yes
#description: ""
#favicon: images/lisa.ico
#cover-image: images/lisa-complete.png
github-repo: fabrica-datos-laborales/fdl-data
url: https://github.com/fabrica-datos-laborales/fdl-data
always_allow_html: yes
---




```r
#devtools::install_github(repo="haozhu233/kableExtra", ref="a6af5c0") #para collapse rows
```

# Presentación{-}

El siguiente libro de códigos contiene todas las variables presentes en la base de datos FDL (*"Fábrica de Datos Laborales*, o en inglés *"Labor Dara Factory"*), variables que proviene de proyectos como ICTWSS, ICTWSS, WDI, WVS, DPI, VDemocracy, ISSP, Eurobarometer, Latinobarometro; y organizaciones no gubernamentales como OCDE e ILO.  FDL ha sido organizada de modo tal que permita hacer análisis comparativo en el tiempo para *países-año*.

El proyecto fue liderado por Valentina Andrade, junto con la importante ayudantía de investigación de Nicolás Godoy y Emilia Cuadros, todo bajo la supervisión del investigador principal del FONDECYT N°11190229 *"Determinantes institucionales y políticos del conflicto entre empresarios y trabajadores: los casos de Argentina y Chile en perspectiva comparada"*, Dr. Pablo Pérez Ahumada[^1].

[^1]: Profesor asistente del Departamento de Sociología, Universidad de Chile(FACSO-UCH) e Investigador Asociado en *Centro de Estudios del Conflicto y Cohesión Social* (COES). 

El objetivo del proyecto FONDECYT es explicar las variaciones en el conflicto entre trabajadores y empresarios en Argentina y Chile. Para hacer esto, se conduce un análisis comparativo a nivel institucional (regulaciones laborales) y políticas (relaciones entre partidos y movimiento sindical)

Por esta razón, el proyecto se ha propuesto la construcción de una base de datos **temporal y mundial** de relaciones laborales. Esto incluye datos soobre acuerdos y pactos entre empleadores, sindicatos y gobierno; características sociales y políticas de los sindicatos y otras asociaciones de trabajores,  relaciones económicas y de empleo en diferentes sectores de la economía, y variables del sistema sociopolítico tales como índices de democracia y confianza en diferentes instituciones y actores sociales. Los datos están disponibles en promedio para 60 países, en general, desde 1879 hasta 2020. La principales fuentes de información fueron  *ICTWSS, OECD, WDI, WVS, DPI, ILOSTAT, ILOEPLEX, VDemocracy, ISSP, Eurobarometer and Latinobarometer.*

Con esta base de datos de construcción abierta y reproducible nosotros esperamos promover el enfoque de la ciencia abierta, con un diseño transparente, datos abiertos, análisis reproducible y publicaciones libres.  Esto significa hacer una decisión metodológica de hacer este estudio transparente, promoviendo a la comunidad los recursos usados en este trabajo e investigación, tanto como los datos construidos  de modo de hacer reproducibles y dar acceso libre a los resultados y productos de investigación (Laboratorio de Ciencia Social Abierta COES, 2021).

Además, estos datos permiten hacer análisis comparativo entre diferentes países y años. Las series temporales están en general en años para cada variable.  Para ver especificamente si los países y años están disponibles se debe consultar a la misma base de datos. Para la clasificación uniforme de los países ocupamos la clasificación ISO3C. 


|iso3c |Country                                              |
|:-----|:----------------------------------------------------|
|ABW   |Aruba                                                |
|AFG   |Afghanistan                                          |
|AGO   |Angola                                               |
|AIA   |Anguilla                                             |
|ALA   |Åland Islands                                        |
|ALB   |Albania                                              |
|AND   |Andorra                                              |
|ARE   |United Arab Emirates                                 |
|ARG   |Argentina                                            |
|ARM   |Armenia                                              |
|ASM   |American Samoa                                       |
|ATA   |Antarctica                                           |
|ATF   |French Southern Territories                          |
|ATG   |Antigua and Barbuda                                  |
|AUS   |Australia                                            |
|AUT   |Austria                                              |
|AZE   |Azerbaijan                                           |
|BDI   |Burundi                                              |
|BEL   |Belgium                                              |
|BEN   |Benin                                                |
|BES   |Bonaire, Sint Eustatius and Saba                     |
|BFA   |Burkina Faso                                         |
|BGD   |Bangladesh                                           |
|BGR   |Bulgaria                                             |
|BHR   |Bahrain                                              |
|BHS   |Bahamas                                              |
|BIH   |Bosnia and Herzegovina                               |
|BLM   |Saint Barthélemy                                     |
|BLR   |Belarus                                              |
|BLZ   |Belize                                               |
|BMU   |Bermuda                                              |
|BOL   |Bolivia (Plurinational State of)                     |
|BRA   |Brazil                                               |
|BRB   |Barbados                                             |
|BRN   |Brunei Darussalam                                    |
|BTN   |Bhutan                                               |
|BVT   |Bouvet Island                                        |
|BWA   |Botswana                                             |
|CAF   |Central African Republic                             |
|CAN   |Canada                                               |
|CCK   |Cocos (Keeling) Islands                              |
|CHE   |Switzerland                                          |
|CHL   |Chile                                                |
|CHN   |China                                                |
|CIV   |Côte d'Ivoire                                        |
|CMR   |Cameroon                                             |
|COD   |Congo, Democratic Republic of the                    |
|COG   |Congo                                                |
|COK   |Cook Islands                                         |
|COL   |Colombia                                             |
|COM   |Comoros                                              |
|CPV   |Cabo Verde                                           |
|CRI   |Costa Rica                                           |
|CUB   |Cuba                                                 |
|CUW   |Curaçao                                              |
|CXR   |Christmas Island                                     |
|CYM   |Cayman Islands                                       |
|CYP   |Cyprus                                               |
|CZE   |Czechia                                              |
|DEU   |Germany                                              |
|DJI   |Djibouti                                             |
|DMA   |Dominica                                             |
|DNK   |Denmark                                              |
|DOM   |Dominican Republic                                   |
|DZA   |Algeria                                              |
|ECU   |Ecuador                                              |
|EGY   |Egypt                                                |
|ERI   |Eritrea                                              |
|ESH   |Western Sahara                                       |
|ESP   |Spain                                                |
|EST   |Estonia                                              |
|ETH   |Ethiopia                                             |
|FIN   |Finland                                              |
|FJI   |Fiji                                                 |
|FLK   |Falkland Islands (Malvinas)                          |
|FRA   |France                                               |
|FRO   |Faroe Islands                                        |
|FSM   |Micronesia (Federated States of)                     |
|GAB   |Gabon                                                |
|GBR   |United Kingdom of Great Britain and Northern Ireland |
|GEO   |Georgia                                              |
|GGY   |Guernsey                                             |
|GHA   |Ghana                                                |
|GIB   |Gibraltar                                            |
|GIN   |Guinea                                               |
|GLP   |Guadeloupe                                           |
|GMB   |Gambia                                               |
|GNB   |Guinea-Bissau                                        |
|GNQ   |Equatorial Guinea                                    |
|GRC   |Greece                                               |
|GRD   |Grenada                                              |
|GRL   |Greenland                                            |
|GTM   |Guatemala                                            |
|GUF   |French Guiana                                        |
|GUM   |Guam                                                 |
|GUY   |Guyana                                               |
|HKG   |Hong Kong                                            |
|HMD   |Heard Island and McDonald Islands                    |
|HND   |Honduras                                             |
|HRV   |Croatia                                              |
|HTI   |Haiti                                                |
|HUN   |Hungary                                              |
|IDN   |Indonesia                                            |
|IMN   |Isle of Man                                          |
|IND   |India                                                |
|IOT   |British Indian Ocean Territory                       |
|IRL   |Ireland                                              |
|IRN   |Iran (Islamic Republic of)                           |
|IRQ   |Iraq                                                 |
|ISL   |Iceland                                              |
|ISR   |Israel                                               |
|ITA   |Italy                                                |
|JAM   |Jamaica                                              |
|JEY   |Jersey                                               |
|JOR   |Jordan                                               |
|JPN   |Japan                                                |
|KAZ   |Kazakhstan                                           |
|KEN   |Kenya                                                |
|KGZ   |Kyrgyzstan                                           |
|KHM   |Cambodia                                             |
|KIR   |Kiribati                                             |
|KNA   |Saint Kitts and Nevis                                |
|KOR   |Korea, Republic of                                   |
|KWT   |Kuwait                                               |
|LAO   |Lao People's Democratic Republic                     |
|LBN   |Lebanon                                              |
|LBR   |Liberia                                              |
|LBY   |Libya                                                |
|LCA   |Saint Lucia                                          |
|LIE   |Liechtenstein                                        |
|LKA   |Sri Lanka                                            |
|LSO   |Lesotho                                              |
|LTU   |Lithuania                                            |
|LUX   |Luxembourg                                           |
|LVA   |Latvia                                               |
|MAC   |Macao                                                |
|MAF   |Saint Martin (French part)                           |
|MAR   |Morocco                                              |
|MCO   |Monaco                                               |
|MDA   |Moldova, Republic of                                 |
|MDG   |Madagascar                                           |
|MDV   |Maldives                                             |
|MEX   |Mexico                                               |
|MHL   |Marshall Islands                                     |
|MKD   |North Macedonia                                      |
|MLI   |Mali                                                 |
|MLT   |Malta                                                |
|MMR   |Myanmar                                              |
|MNE   |Montenegro                                           |
|MNG   |Mongolia                                             |
|MNP   |Northern Mariana Islands                             |
|MOZ   |Mozambique                                           |
|MRT   |Mauritania                                           |
|MSR   |Montserrat                                           |
|MTQ   |Martinique                                           |
|MUS   |Mauritius                                            |
|MWI   |Malawi                                               |
|MYS   |Malaysia                                             |
|MYT   |Mayotte                                              |
|NAM   |Namibia                                              |
|NCL   |New Caledonia                                        |
|NER   |Niger                                                |
|NFK   |Norfolk Island                                       |
|NGA   |Nigeria                                              |
|NIC   |Nicaragua                                            |
|NIU   |Niue                                                 |
|NLD   |Netherlands                                          |
|NOR   |Norway                                               |
|NPL   |Nepal                                                |
|NRU   |Nauru                                                |
|NZL   |New Zealand                                          |
|OMN   |Oman                                                 |
|PAK   |Pakistan                                             |
|PAN   |Panama                                               |
|PCN   |Pitcairn                                             |
|PER   |Peru                                                 |
|PHL   |Philippines                                          |
|PLW   |Palau                                                |
|PNG   |Papua New Guinea                                     |
|POL   |Poland                                               |
|PRI   |Puerto Rico                                          |
|PRK   |Korea (Democratic People's Republic of)              |
|PRT   |Portugal                                             |
|PRY   |Paraguay                                             |
|PSE   |Palestine, State of                                  |
|PYF   |French Polynesia                                     |
|QAT   |Qatar                                                |
|REU   |Réunion                                              |
|ROU   |Romania                                              |
|RUS   |Russian Federation                                   |
|RWA   |Rwanda                                               |
|SAU   |Saudi Arabia                                         |
|SDN   |Sudan                                                |
|SEN   |Senegal                                              |
|SGP   |Singapore                                            |
|SGS   |South Georgia and the South Sandwich Islands         |
|SHN   |Saint Helena, Ascension and Tristan da Cunha         |
|SJM   |Svalbard and Jan Mayen                               |
|SLB   |Solomon Islands                                      |
|SLE   |Sierra Leone                                         |
|SLV   |El Salvador                                          |
|SMR   |San Marino                                           |
|SOM   |Somalia                                              |
|SPM   |Saint Pierre and Miquelon                            |
|SRB   |Serbia                                               |
|SSD   |South Sudan                                          |
|STP   |Sao Tome and Principe                                |
|SUR   |Suriname                                             |
|SVK   |Slovakia                                             |
|SVN   |Slovenia                                             |
|SWE   |Sweden                                               |
|SWZ   |Eswatini                                             |
|SXM   |Sint Maarten (Dutch part)                            |
|SYC   |Seychelles                                           |
|SYR   |Syrian Arab Republic                                 |
|TCA   |Turks and Caicos Islands                             |
|TCD   |Chad                                                 |
|TGO   |Togo                                                 |
|THA   |Thailand                                             |
|TJK   |Tajikistan                                           |
|TKL   |Tokelau                                              |
|TKM   |Turkmenistan                                         |
|TLS   |Timor-Leste                                          |
|TON   |Tonga                                                |
|TTO   |Trinidad and Tobago                                  |
|TUN   |Tunisia                                              |
|TUR   |Türkiye                                              |
|TUV   |Tuvalu                                               |
|TWN   |Taiwan                                               |
|TZA   |Province of China                                    |
|UGA   |Tanzania, United Republic of                         |
|UKR   |Uganda                                               |
|UMI   |Ukraine                                              |
|URY   |United States Minor Outlying Islands                 |
|USA   |Uruguay                                              |
|UZB   |United States of America                             |
|VAT   |Uzbekistan                                           |
|VCT   |Holy See                                             |
|VEN   |Saint Vincent and the Grenadines                     |
|VGB   |Venezuela (Bolivarian Republic of)                   |
|VIR   |Virgin Islands (British)                             |
|VNM   |Virgin Islands (U.S.)                                |
|VUT   |Viet Nam                                             |
|WLF   |Vanuatu                                              |
|WSM   |Wallis and Futuna                                    |
|YEM   |Samoa                                                |
|ZAF   |Yemen                                                |
|ZMB   |South Africa                                         |
|ZWE   |Zambia                                               |


