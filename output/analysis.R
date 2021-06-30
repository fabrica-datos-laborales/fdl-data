# Some analysis -----------------------------------------------------------
# Working class
plotly::ggplotly(issp %>% filter(year != 2015) %>% 
                   ggplot(aes(y = class_working, x = year, color = iso3c)) +
                   geom_line() + geom_point()+
                   geom_line(data = filter(issp, is.na(class_working) == F), linetype = "dashed") +
                   theme_linedraw() + guides(color = F))

# Perception class
plotly::ggplotly(issp %>% filter(!is.na(year)) %>% 
                   ggplot(aes(y = `conflict_very_strong/strong`, x = year, color = iso3c)) +
                   geom_line() + geom_point()+
                   geom_line(data = filter(issp, is.na(`conflict_very_strong/strong`) == F), linetype = "dashed") +
                   theme_linedraw() + guides(color = F))

# ESS
plotly::ggplotly(issp %>% filter(!is.na(year)) %>% 
                   ggplot(aes(y = `ess_median`, x = year, color = iso3c)) +
                   geom_line() + geom_point()+
                   geom_line(data = filter(issp, is.na(`ess_median`) == F), linetype = "dashed") +
                   theme_linedraw() + guides(color = F))


