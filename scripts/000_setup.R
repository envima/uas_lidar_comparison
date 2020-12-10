## setup

library(lidR)
library(sf)
library(raster)
library(tidyverse)
library(reshape2)
library(viridis)


loadClouds = function(){
  
  return(list(lidar2018 =  readLAS("data/lidar/lidar2018_halfmoon_sample.las"),
              dc_0915 = readLAS("data/denseclouds/2020_09_15_densecloud.laz"),
              dc_1016 = readLAS("data/denseclouds/2020_10_16_densecloud.laz"),
              dc_1112 = readLAS("data/denseclouds/2020_11_12_densecloud.laz")))
  
}

