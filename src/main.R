#' Main control script
#'
#' @description Use this script for controlling the processing.
#'
#' @author [Marvin], [marvin.ludwig@geo.uni-marburg.de]
#'

library(envimaR)
if (Sys.info()[["nodename"]] == "marvinpc") {
  root_folder = "/home/marvin/casestudies/uas_lidar_comparison/"
}
if (Sys.info()[["nodename"]] == "marvinshredder"){
  root_folder = "/home/um2/casestudies/uas_lidar_comparison/"
}
setwd(root_folder)
source("src/functions/000_setup.R")


# workflow ----
if(FALSE) source("src/001_import_pointcloud_indices.R")
if(TRUE) source("src/002_create_level0_metadata.R")

# calculate all correlations
if(FALSE) source("src/010_lidar_densecloud_correlations.R")

# create figures ----
source("src/011_lidar_densecloud_scatterplots.R")

# bakx1
plots_bakx1 = meta %>%
  filter(metric_group == "bakx1") %>% 
  pci_plot_resolution()
saveRDS(plots_bakx1, "data/results/scatterplots/lidar_densecloud_bakx1_resolutions_plots.RDS")

# voxel mean height metrics plots
plots_zvoxel = meta %>%
  filter(metric_group == "zVoxel") %>% 
  pci_plot_resolution()
saveRDS(plots_zvoxel, "data/results/scatterplots/lidar_densecloud_zvoxel_resolutions_plots.RDS")

# bakx1 heterogenity
plots_bakx1_sd = meta %>%
  filter(metric_group == "bakx1_sd") %>% 
  pci_plot_resolution()
saveRDS(plots_bakx1_sd, "data/results/scatterplots/lidar_densecloud_bakx1sd_resolutions_plots.RDS")

# zvoxel heterogenity
plots_zvoxel_sd = meta %>%
  filter(metric_group == "zVoxel_sd") %>% 
  pci_plot_resolution()
saveRDS(plots_zvoxel_sd, "data/results/scatterplots/lidar_densecloud_zvoxelsd_resolutions_plots.RDS")

