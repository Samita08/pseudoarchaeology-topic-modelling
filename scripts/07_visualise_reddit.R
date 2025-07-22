library(ggplot2)
library(dplyr)
library(tidytext)

top_terms <- readRDS("data/top_terms_k10.rds")

top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(x = term, y = beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free", ncol = 2) +
  coord_flip() +
  scale_x_reordered() +
  labs(
    title = "Top 10 Terms per Topic (k = 10)",
    x = NULL,
    y = "Beta"
  ) +
  theme_minimal()
