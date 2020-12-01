# 00 prepare raw lidar data

source("scripts/000_setup.R")
lidar2018 = lidR::readLAS("../../data/remotesensing/lidar/mof/mof_lidar_2018.las")

halfmoon= st_read("data/areas/mof_halfmoon.gpkg")

lidar2018 = lasclip(lidar2018, halfmoon)

lidar2018@proj4string = CRS("+init=epsg:25832")


# homogenize point density to 20 points per squaremeter
lidar2018_h = decimate_points(lidar2018, algorithm = homogenize(20, res = 1))
writeLAS(lidar2018_h, "data/lidar/lidar2018_halfmoon_20p.las")

original_lidar_info = system("pdal info data/lidar/lidar2018_halfmoon_20p.las", intern = TRUE)
writeLines(original_lidar_info, "docs/dataset_infos/lidar2018_halfmoon_20p_metadata.txt")
