## ----setup_intro, include = FALSE---------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>"
)

## -----------------------------------------------------------------------------
library(BrainNetTest)
set.seed(1)

## -----------------------------------------------------------------------------
G <- generate_random_graph(n_nodes = 10, edge_prob = 0.2)
isSymmetric(G)
all(diag(G) == 0)

## -----------------------------------------------------------------------------
population <- replicate(
  5, generate_random_graph(n_nodes = 10, edge_prob = 0.2),
  simplify = FALSE)

central <- compute_central_graph(population)
compute_distance(population[[1]], central)

## -----------------------------------------------------------------------------
control <- replicate(
  15, generate_random_graph(n_nodes = 10, edge_prob = 0.20),
  simplify = FALSE)
patient <- replicate(
  15, generate_random_graph(n_nodes = 10, edge_prob = 0.40),
  simplify = FALSE)

populations <- list(Control = control, Patient = patient)
compute_test_statistic(populations, a = 1)

## -----------------------------------------------------------------------------
result <- identify_critical_links(
  populations,
  alpha          = 0.05,
  method         = "fisher",
  n_permutations = 200,
  seed           = 42)

head(result$critical_edges)

## -----------------------------------------------------------------------------
get_critical_nodes(result)

