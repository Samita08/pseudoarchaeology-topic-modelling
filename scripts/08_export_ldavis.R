library(LDAvis)
library(topicmodels)

# Load model and DTM
lda_model <- readRDS("data/lda_model_k10.rds")
dtm <- readRDS("data/dtm_sparse.rds")

# Create JSON
phi <- posterior(lda_model)$terms
theta <- posterior(lda_model)$topics
vocab <- colnames(phi)
doc_length <- rowSums(as.matrix(dtm))
term_freq <- colSums(as.matrix(dtm))

json_vis <- createJSON(
  phi = phi,
  theta = theta,
  doc.length = doc_length,
  vocab = vocab,
  term.frequency = term_freq
)

# Save interactive visualisation
dir.create("results/ldavis_output", showWarnings = FALSE, recursive = TRUE)
serVis(json_vis, out.dir = "results/ldavis_output", open.browser = FALSE)
file.rename("results/ldavis_output/index.html", "results/ldavis_output/ldavis_k10.html")
