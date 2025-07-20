# Pseudoarchaeology Topic Modelling

This repository contains code and outputs for topic modelling applied to Reddit and Bluesky comments discussing pseudoarchaeology (e.g. ancient aliens, Graham Hancock).

## Contents

- `topic_model.R`: Main R script for fitting LDA models, evaluating coherence, extracting top terms, and visualising topics.
- `data/`: Folder to store your DTM, LDA models, and processed output (e.g. `dtm_sparse.rds`, `lda_model_k10.rds`, `top_terms_k10.rds`)
- `ldavis_output/`: Folder containing the interactive topic visualisation (via LDAvis)
- `results/`: Optionally, export plots or top documents here.

## Key Steps

1. Preprocess and build DTM.
2. Fit multiple LDA models and evaluate using Deveaud2014 metric.
3. Select best topic number (e.g. k = 10).
4. Visualise top words and generate interactive LDAvis.
5. Label topics manually in Google Sheets.

## How to Run

Run `topic_model.R` in RStudio. Make sure you have:
- `dtm_sparse.rds` in `data/`
- Required packages installed: `topicmodels`, `LDAvis`, `tidytext`, `dplyr`, `ggplot2`, etc.

## Author

This project was developed for the SURE internship at the University of Sheffield.
