library(topicmodels)
library(tibble)
library(Matrix)

# Load DTM
dtm <- readRDS("data/dtm_sparse.rds")

# Evaluation metric
evaluate_metrics <- function(dtm, model) {
  t1 <- posterior(model)$terms
  kl <- function(p, q) sum(p * log(p / q))
  D <- matrix(0, ncol(t1), ncol(t1))
  for (i in 1:ncol(t1)) {
    for (j in 1:ncol(t1)) {
      D[i, j] <- 0.5 * (kl(t1[, i], t1[, j]) + kl(t1[, j], t1[, i]))
    }
  }
  return(c(Deveaud2014 = mean(D[lower.tri(D)])))
}

# Loop over k
topic_scores <- tibble(k = integer(), Deveaud2014 = numeric())
for (k in 2:15) {
  model <- LDA(dtm, k = k, method = "VEM", control = list(seed = 1234))
  score <- evaluate_metrics(dtm, model)
  topic_scores <- add_row(topic_scores, k = k, Deveaud2014 = score)
  saveRDS(topic_scores, "data/topic_scores_partial.rds")
}

# Final model (k = 10)
lda_model_k10 <- LDA(dtm, k = 10, method = "VEM", control = list(seed = 1234))
saveRDS(lda_model_k10, "data/lda_model_k10.rds")
