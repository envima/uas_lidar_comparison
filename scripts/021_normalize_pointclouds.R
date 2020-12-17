# compare pointcloud height range

source("scripts/000_setup.R")



fls = list.files("data/denseclouds/", full.names = TRUE)
pc = lapply(fls, readLAS)


pc$`2018_01_01_lidar` = readLAS("data/lidar/lidar2018_halfmoon_sample.las")
pc$`2018_01_01_lidar_firstreturn` = filter_poi(pc$`2018_01_01_lidar`, ReturnNumber == 1)

names(pc) = c("densecloud_2019_04_25", "densecloud_2019_12_04", "densecloud_2020_09_15", "densecloud_2020_10_16", "densecloud_2020_11_12",
              "lidar_2018_01_01", "lidarfirst_2018_01_01")


# uniform point density
norm_pc = lapply(seq_along(pc), function(i){
  p = pc[[i]]
  # throw out confidence < 2 in denseclouds. so a point is based on at least 2 depth maps
  if("confidence" %in% names(p@data)){
    p = filter_poi(p, confidence > 2)
  }
  # normalize all pointclouds by homogenous 50 points per squaremeter
  p = decimate_points(p, algorithm = homogenize(50, res = 1))
  writeLAS(p, paste0("data/run/pointclouds_normalized/", names(pc)[i], ".las"))
  return(p)
})

names(norm_pc) = names(pc)

saveRDS(norm_pc, "data/run/normalized_pointclouds.RDS")
