# 00 prepare raw lidar data

source("scripts/000_setup.R")
lidar2018 = lidR::readLAS("../../data/remotesensing/lidar/mof/mof_lidar_2018.las")

halfmoon= st_read("data/areas/mof_halfmoon_sample.gpkg")

lidar2018 = lasclip(lidar2018, halfmoon)

lidar2018@proj4string = CRS("+init=epsg:25832")


writeLAS(lidar2018, "data/lidar/lidar2018_halfmoon_sample.las")
