# correlation coeffs
source("scripts/000_setup.R")

fls = list.files("data/z_metrics_tables/", full.names = TRUE, pattern = ".RDS")
df = do.call(rbind, lapply(fls, readRDS))


dfsub = df %>% filter(metric == "cv") %>% na.omit()

resp = c("densecloud_2019_04_25", "densecloud_2019_12_04", "densecloud_2020_09_15", "densecloud_2020_10_15", "densecloud_2020_11_12")


lapply(resp, function(r){
  
  
  
  
  
})

lmod = lm(densecloud_2020_09_15 ~ lidar_2018_01_01, data = dfsub)
ls = summary(lmod)
ls$adj.r.squared
ls
ls$coefficients
