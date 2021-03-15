# compare flight dates with 1 m resolution

datasets = meta

lidar_vs_denseclouds = pmap_dfr(list(f = datasets$filepath, d = datasets$date,
                                     r = datasets$resolution, g = datasets$metric_group), function(f,d,r,g){
  
  # load response
  y = stack(f)
  
  # load corresponding lidar predictor set
  x_file = datasets %>% filter(resolution == r & datasource == "lidar" & metric_group == g) %>% dplyr::select(filepath) %>% as.character()
  x = raster::stack(x_file)
  
  r = pci_compare(x,y) %>%
    dplyr::mutate(date = d, filepath = f, resolution = r, metric_group = g)
})


# save raw level1 results
dir.create("data/level1/lidar_densecloud_correlations")
saveRDS(lidar_vs_denseclouds, "data/level1/lidar_densecloud_correlations/lidar_denseclouds_lm.RDS")


# pretty formatting
results = lidar_vs_denseclouds %>% dplyr::select(metric, results, date, resolution, filepath, metric_group) %>% 
  tidyr::unnest(cols = "results") %>% dplyr::left_join(datasets, by = c("date", "resolution", "filepath", "metric_group"))


dir.create("data/results/lidar_densecloud_correlations")
saveRDS(results, "data/results/lidar_densecloud_correlations/lidar_denseclouds_lm.RDS")

