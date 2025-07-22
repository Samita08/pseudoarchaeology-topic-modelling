library(topicmodels)
library(tidytext)
library(dplyr)

lda_model <- readRDS("data/lda_model_k10.rds")

# Top terms
top_terms <- tidy(lda_model, matrix = "beta") %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup()

saveRDS(top_terms, "data/top_terms_k10.rds")
write.csv(top_terms, "top_terms_k10.csv", row.names = FALSE)

# Top docs per topic
gamma <- tidy(lda_model, matrix = "gamma")
saveRDS(gamma, "data/gamma_k10.rds")

doc_topics <- gamma %>%
  group_by(document) %>%
  slice_max(gamma, n = 1) %>%
  ungroup()

saveRDS(doc_topics, "data/top_docs_k10.rds")
