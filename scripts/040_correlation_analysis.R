# correlation coeffs
source("scripts/000_setup.R")

fls = list.files("data/z_metrics_tables/", full.names = TRUE, pattern = ".RDS")
df = do.call(rbind, lapply(fls, readRDS))


df = df %>% filter(metric != "cv")
resp = c("densecloud_2019_04_25", "densecloud_2019_12_04", "densecloud_2020_09_15",  "densecloud_2020_11_12")



res_resp = lapply(resp, function(r){
  res_m = lapply(unique(df$metric), function(m){
    dfsub = df %>% filter(metric == m) %>% na.omit()
    regression = as.formula(paste0(r, " ~ lidar_2018_01_01"))
    lmod = lm(regression, data = dfsub)
    
    results = data.frame(response = r,
                         metric = m,
                         Rsq = round(summary(lmod)$r.squared, 3),
                         p = round(summary(lmod)$coefficients[2,4], 6),
                         intercept = summary(lmod)$coefficients[1,1],
                         slope = summary(lmod)$coefficients[2,1])
    return(results)
  })
  res_m = do.call(rbind, res_m)
  return(res_m)
  
})


res_resp = do.call(rbind, res_resp)
saveRDS(res_resp, "data/run/correlations_01m.RDS")

#######################


fls = list.files("data/z_metrics_tables_10m/", full.names = TRUE, pattern = ".RDS")
df = do.call(rbind, lapply(fls, readRDS))


df = df %>% filter(metric != "cv")
resp = c("densecloud_2019_04_25", "densecloud_2019_12_04", "densecloud_2020_09_15",  "densecloud_2020_11_12")



res_resp = lapply(resp, function(r){
  res_m = lapply(unique(df$metric), function(m){
    dfsub = df %>% filter(metric == m) %>% na.omit()
    regression = as.formula(paste0(r, " ~ lidar_2018_01_01"))
    lmod = lm(regression, data = dfsub)
    
    results = data.frame(response = r,
                         metric = m,
                         Rsq = round(summary(lmod)$r.squared, 3),
                         p = round(summary(lmod)$coefficients[2,4], 6),
                         intercept = summary(lmod)$coefficients[1,1],
                         slope = summary(lmod)$coefficients[2,1])
    return(results)
  })
  res_m = do.call(rbind, res_m)
  return(res_m)
  
})


res_resp = do.call(rbind, res_resp)
saveRDS(res_resp, "data/run/correlations_10m.RDS")
