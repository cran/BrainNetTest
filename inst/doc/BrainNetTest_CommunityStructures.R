## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>"
)

## -----------------------------------------------------------------------------
library(BrainNetTest)

## -----------------------------------------------------------------------------
set.seed(42)
G <- generate_community_graph(
  n_nodes       = 40,
  n_communities = 4,
  intra_prob    = 0.8,
  inter_prob    = 0.2)

dim(G)
mean(G[upper.tri(G)])

## -----------------------------------------------------------------------------
control <- generate_category_graphs(
  n_graphs             = 20,
  n_nodes              = 20,
  n_communities        = 2,
  base_intra_prob      = 0.8,
  base_inter_prob      = 0.2,
  intra_prob_variation = 0.05,
  inter_prob_variation = 0.05,
  seed                 = 1)

patient <- generate_category_graphs(
  n_graphs             = 20,
  n_nodes              = 20,
  n_communities        = 2,
  base_intra_prob      = 0.6,
  base_inter_prob      = 0.4,
  intra_prob_variation = 0.05,
  inter_prob_variation = 0.05,
  seed                 = 2)

populations <- list(Control = control, Patient = patient)
lengths(populations)

## -----------------------------------------------------------------------------
T_obs <- compute_test_statistic(populations, a = 1)
T_obs

## -----------------------------------------------------------------------------
result <- identify_critical_links(
  populations,
  alpha          = 0.05,
  method         = "fisher",
  n_permutations = 500,
  seed           = 42)

nrow(result$critical_edges)
head(result$critical_edges)

## -----------------------------------------------------------------------------
get_critical_nodes(result)

## ----eval = requireNamespace("igraph", quietly = TRUE), fig.width=7, fig.height=7----
plot_critical_edges(
  populations,
  result,
  communities = rep(seq_len(2), each = 10),
  reference   = "Control")

