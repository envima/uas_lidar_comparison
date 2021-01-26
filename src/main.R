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
source(paste0(root_folder, "/src/functions/000_setup.R"))


