# 10 m indices

# comparsion of each sparsecloud with lidar

source("scripts/000_setup.R")
source("scripts/001_pointcloud_height_metrics.R")


pc = readRDS("data/run/normalized_pointclouds.RDS")
g = raster("data/areas/halfmoon_grid10.tif")


indices = lapply(pc, function(p){
  z_metrics = grid_metrics(p, func = ~bakx1(Z, ReturnNumber), res = g)
  projection(z_metrics) = crs("+init=epsg:25832")
  return(z_metrics)
})

# save raster

for(i in seq(length(indices))){
  writeRaster(indices[[i]], paste0("data/z_metrics_10m/", names(indices)[i], ".grd"), overwrite = TRUE)
}


# turn into convenient data.frames

for(i in seq(nlayers(indices[[1]]))){
  
  metric_name = names(indices[[1]])[i]
  m = stack(lapply( indices, "[[", i))
  m = as.data.frame(m, xy = TRUE)
  m$metric = metric_name
  saveRDS(m, paste0("data/z_metrics_tables_10m/", metric_name, ".RDS"))
  
}

