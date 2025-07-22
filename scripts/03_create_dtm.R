# Load libraries
library(dplyr)
library(tidytext)
library(tm)
library(Matrix)

# Load cleaned data
reddit <- readRDS("data/reddit_cleaned.rds")
bluesky <- readRDS("data/bluesky_cleaned.rds")

# Combine into single dataset
all_comments <- bind_rows(
  mutate(reddit, source = "reddit"),
  mutate(bluesky, source = "bluesky")
) %>%
  mutate(doc_id = row_number())

# Tokenise and clean
tokens <- all_comments %>%
  unnest_tokens(word, body) %>%
  anti_join(get_stopwords()) %>%
  filter(str_detect(word, "^[a-z']+$"))  # keep only words

# Create DTM
dtm_df <- tokens %>%
  count(doc_id, word) %>%
  cast_dtm(document = doc_id, term = word, value = n)

# Save DTM and full data
saveRDS(dtm_df, "data/dtm_sparse.rds")
saveRDS(all_comments, "data/all_comments.rds")
