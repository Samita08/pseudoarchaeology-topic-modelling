library(ggplot2)
library(dplyr)
library(stringr)

# Load Bluesky
bluesky <- readRDS("data/bluesky_cleaned.rds")

# Word count
bluesky %>%
  mutate(word_count = str_count(body, "\\w+")) %>%
  ggplot(aes(x = word_count)) +
  geom_histogram(binwidth = 5, fill = "steelblue") +
  theme_minimal() +
  labs(title = "Word Count Distribution (Bluesky)", x = "Words per Post", y = "Frequency")

# Add more plots as needed
