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


# workflow

if(FALSE) source("src/001_import_pointcloud_indices.R")
if(TRUE) source("src/002_create_level0_metadata.R")
