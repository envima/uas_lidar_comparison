# heterogenity 10 m


fls = list.files("data/z_metrics/", pattern = ".grd$", full.names = TRUE)
metrics01 = lapply(fls, stack)
names(metrics01) = word(basename(fls), 1, sep = "\\.")


horizontal_heterogenity = lapply(metrics01, function(m){
  het = aggregate(m, 10, fun=sd)
  names(het) = paste0(names(het), "_sd")
  return(het)
})


for(i in seq(length(horizontal_heterogenity))){
  writeRaster(horizontal_heterogenity[[i]], paste0("data/z_metrics_10m/", names(horizontal_heterogenity)[i], "_sd.grd"), overwrite = FALSE)
}



for(i in seq(nlayers(horizontal_heterogenity[[1]]))){
  
  metric_name = names(horizontal_heterogenity[[1]])[i]
  m = stack(lapply( horizontal_heterogenity, "[[", i))
  m = as.data.frame(m, xy = TRUE)
  m$metric = metric_name
  saveRDS(m, paste0("data/z_metrics_tables_10m/", metric_name, ".RDS"))
  
}
