library(liminal)
library(ggplot2)
library(Rtsne)
library(dplyr)
library(palmerpenguins)

penguins_data <- na.omit(palmerpenguins::penguins)

set.seed(123)
tsne_outcome <- Rtsne(penguins_data[, c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")])

tsne_mapped <- data.frame(
  x_dim = tsne_outcome$Y[,1],
  y_dim = tsne_outcome$Y[,2],
  category = penguins_data$species
)

tour_inputs <- penguins_data[, c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g", "species")]

limn_tour_link(
  embed_data = tsne_mapped,
  tour_data = tour_inputs,
  cols = c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g"),
  color = "category"
)
