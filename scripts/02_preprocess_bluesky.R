# Load libraries
library(jsonlite)
library(dplyr)
library(tidytext)
library(stringr)

# Load raw Bluesky JSON
bluesky_raw <- fromJSON("raw_data/bluesky_raw.json", flatten = TRUE)

# Basic cleaning
bluesky_clean <- bluesky_raw %>%
  select(body = text) %>%
  mutate(body = str_squish(body)) %>%
  filter(!is.na(body), body != "")

# Save cleaned data
saveRDS(bluesky_clean, "data/bluesky_cleaned.rds")
