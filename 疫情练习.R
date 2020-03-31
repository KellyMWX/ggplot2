library(nCov2019)
library(dplyr)
library(ggplot2)
library(ggrepel)
x = load_nCov2019()
d = x['global']
d = d[d$country != 'China',]
n <- d %>% filter(time == time(x)) %>%
  top_n(10, cum_confirm) %>%
  arrange(desc(cum_confirm)) %>%
  pull(country)
ggplot(filter(d, country %in% n),
       aes(time, cum_confirm, color=country)) +
  geom_line() +
  geom_text_repel(aes(label=country),
                  function(d) d[d$time == time(x),]) +
  theme_minimal(base_size=14) +
  theme(legend.position = "none") +
  xlab(NULL) + ylab(NULL)
