# Load libraries
library(jsonlite)
library(dplyr)
library(tidytext)
library(stringr)

# Load raw Reddit JSON
reddit_raw <- fromJSON("raw_data/reddit_raw.json", flatten = TRUE)

# Basic cleaning
reddit_clean <- reddit_raw %>%
  select(body = body) %>%
  mutate(body = str_squish(body)) %>%
  filter(!is.na(body), body != "")

# Save cleaned data
saveRDS(reddit_clean, "data/reddit_cleaned.rds")
