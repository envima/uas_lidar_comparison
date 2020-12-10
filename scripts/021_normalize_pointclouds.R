# compare pointcloud height range

source("scripts/000_setup.R")

pc = loadClouds()


# normalize heights



norm_pc = lapply(pc, function(p){
  
  # throw out confidence < 3 in denseclouds
  if("confidence" %in% names(p@data)){
    p = filter_poi(p, confidence > 3)
  }
  # normalize all pointclouds by homogenous 50 points per squaremeter
  p = decimate_points(p, algorithm = homogenize(50, res = 1))
  return(p)
})

saveRDS(norm_pc, "data/run/normalized_pointclouds.RDS")

# normalize everything with the lidar DEM

dem = grid_terrain(norm_pc$lidar2018, res = 1, algorithm = knnidw())


terrain_norm = lapply(norm_pc, function(p){
  normalize_height(p, algorithm = dem, na.rm = TRUE)
})

saveRDS(terrain_norm, "data/run/normalized_terrain_pointclouds.RDS")
