# compare flight dates with 1 m resolution





datasets = meta


lidar = stack(datasets$filepath[1])
datasets = datasets %>% filter(datasource != "lidar")

lidar_vs_denseclouds = pmap_dfr(list(f = datasets$filepath, d = datasets$date, r = datasets$resolution), function(f,d,r){
  
  # load response
  y = stack(f)
  
  # load corresponding lidar predictor set
  x_file = datasets %>% filter(resolution == r & datasource == "lidar") %>% select(filepath) %>% as.character()
  x = stack(x_file)
  
  r = pci_compare(x,y) %>%
    mutate(date = d, filepath = f, resolution = r)
})


# save raw level1 results
dir.create("data/level1/lidar_densecloud_correlations")
saveRDS(lidar_vs_denseclouds, "data/level1/lidar_densecloud_correlations/lidar_denseclouds_lm.RDS")


# pretty formatting
results = lidar_vs_denseclouds %>% select(metric, results, date, resolution, filepath) %>% 
  unnest(cols = "results") %>% left_join(datasets, by = c("date", "resolution", "filepath"))


dir.create("data/results/lidar_densecloud_correlations")
saveRDS(results, "data/results/lidar_densecloud_correlations/lidar_denseclouds_lm.RDS")

