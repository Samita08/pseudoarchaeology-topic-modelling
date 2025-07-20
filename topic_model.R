
# === Load Libraries ===
library(topicmodels)
library(tidytext)
library(dplyr)
library(tibble)
library(tidyr)
library(ggplot2)
library(Matrix)
library(LDAvis)
library(servr)

# === Load your DTM ===
dtm <- readRDS("data/dtm_sparse.rds")

# === Fit LDA with k = 10 ===
lda_model_k10 <- LDA(dtm, k = 10, method = "VEM", control = list(seed = 1234))
saveRDS(lda_model_k10, "data/lda_model_k10.rds")

# === Extract top terms per topic ===
lda_terms <- tidy(lda_model_k10, matrix = "beta")
top_terms <- lda_terms %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup() %>%
  arrange(topic, -beta)
saveRDS(top_terms, "data/top_terms_k10.rds")

# === Visualisation (LDAvis) ===
prepare_ldavis <- function(lda_model, dtm) {
  phi <- posterior(lda_model)$terms
  theta <- posterior(lda_model)$topics
  vocab <- colnames(phi)
  doc_length <- rowSums(as.matrix(dtm))
  term_frequency <- colSums(as.matrix(dtm))
  createJSON(
    phi = phi,
    theta = theta,
    doc.length = doc_length,
    vocab = vocab,
    term.frequency = term_frequency
  )
}
json_vis <- prepare_ldavis(lda_model_k10, dtm)
serVis(json_vis, out.dir = "ldavis_output", open.browser = TRUE)
