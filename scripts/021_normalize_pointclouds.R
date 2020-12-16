# compare pointcloud height range

source("scripts/000_setup.R")



fls = list.files("data/denseclouds/", full.names = TRUE)
pc = lapply(fls, readLAS)
names(pc) =  word(basename(fls), 1, sep = "\\.")

pc$`2018_01_01_lidar` = readLAS("data/lidar/lidar2018_halfmoon_sample.las")
pc$`2018_01_01_lidar_firstreturn` = filter_poi(pc$`2018_01_01_lidar`, ReturnNumber == 1)


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
norm_pc
saveRDS(norm_pc, "data/run/normalized_pointclouds.RDS")
