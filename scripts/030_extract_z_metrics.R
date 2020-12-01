# comparsion of each sparsecloud with lidar

source("scripts/000_setup.R")
source("scripts/001_pointcloud_height_metrics.R")


sparse_fls = list.files("data/sparseclouds/", full.names = TRUE, pattern = ".las$")
lidar2018 = readLAS("data/lidar/lidar2018_halfmoon_20p.las")
lidar_z_metrics = grid_metrics(lidar2018, func = ~metrics(Z), res = 5)
names(lidar_z_metrics) = paste0("lidar_", names(lidar_z_metrics))


for(fl in sparse_fls){
  
  sparsecloud = readLAS(fl)
  filename = word(basename(fl), start = 1, sep = "\\.")
  
  
  sparsecloud_z_metrics = grid_metrics(sparsecloud, func = ~metrics(Z), res = lidar_z_metrics[[1]])
  diff_z_metrics = lidar_z_metrics - sparsecloud_z_metrics
  projection(diff_z_metrics) <- crs("+init=epsg:25832")
  names(diff_z_metrics) = gsub("lidar", "diff", names(diff_z_metrics))
  writeRaster(diff_z_metrics, paste0("data/z_metrics_differences/", filename, ".grd"))
  
  # create data frames for statistical analysis
  
  
  names(sparsecloud_z_metrics) = paste0("sparsecloud_", names(sparsecloud_z_metrics))
  
  all_z_metrics = stack(lidar_z_metrics, sparsecloud_z_metrics)
  all_z_metrics_df = na.omit(as.data.frame(all_z_metrics))
  
  
  
  all_z_metrics_df$date = word(filename, start = 1, end = 3, sep = "_")
  write_csv(all_z_metrics_df, paste0("data/z_metrics_tables/", filename, ".csv"))
  
  
  
}

