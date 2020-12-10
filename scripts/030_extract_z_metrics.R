# comparsion of each sparsecloud with lidar

source("scripts/000_setup.R")
source("scripts/001_pointcloud_height_metrics.R")


pc = readRDS("data/run/normalized_terrain_pointclouds.RDS")


height_based_indices = lapply(pc, function(p){
  z_metrics = grid_metrics(p, func = ~metrics(Z), res =1)
  z_metrics$n_2m = grid_metrics(p, func = ~length(Z), res = 1, filter = ~Z<2)
  z_metrics$penetrationrate = z_metrics$n_2m / z_metrics$n_points
  projection(z_metrics) = crs("+init=epsg:25832")
  return(z_metrics)
  
})

# save raster

for(i in seq(length(height_based_indices))){
  writeRaster(height_based_indices[[i]], paste0("data/z_metrics_differences/", names(height_based_indices)[i], ".grd"))
}



lidar = height_based_indices[[1]]
uas = height_based_indices[2:4]



i = 1
for(i in seq(3)){
  
  uascloud_z_metrics = uas[[i]]
  names(uascloud_z_metrics) = paste0("uas_", names(uascloud_z_metrics))
  
  all_z_metrics = stack(lidar, uascloud_z_metrics)
  all_z_metrics_df = as.data.frame(all_z_metrics)
  
  all_z_metrics_df$date = names(uas)[i]
  write_csv(all_z_metrics_df, paste0("data/z_metrics_tables/", names(uas)[i], ".csv"))
  
  
  
}

