# comparsion of each sparsecloud with lidar

source("scripts/000_setup.R")
source("scripts/001_pointcloud_height_metrics.R")


pc = readRDS("data/run/normalized_pointclouds.RDS")
g = raster("data/areas/halfmoon_grid01.tif")


height_based_indices = lapply(pc, function(p){
  z_metrics = grid_metrics(p, func = ~metrics(Z), res = g)
  projection(z_metrics) = crs("+init=epsg:25832")
  return(z_metrics)
})

# save raster

for(i in seq(length(height_based_indices))){
  writeRaster(height_based_indices[[i]], paste0("data/z_metrics/", names(height_based_indices)[i], ".grd"), overwrite = TRUE)
}


# turn into convenient data.frames

# new names:
n = c("densecloud_2019_04_25", "densecloud_2019_12_04", "densecloud_2020_09_15", "densecloud_2020_10_16", "densecloud_2020_11_12",
      "lidar_2018_01_01", "lidarfirst_2018_01_01")


for(i in seq(nlayers(height_based_indices[[1]]))){
  
  metric_name = names(height_based_indices[[1]])[i]
  m = stack(lapply(height_based_indices, "[[", i))
  names(m) = n
  m = as.data.frame(m, xy = TRUE)
  m$metric = metric_name
  saveRDS(m, paste0("data/z_metrics_tables/", metric_name, ".RDS"))
  
}


