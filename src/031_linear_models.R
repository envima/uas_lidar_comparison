
# one model for each predictor type


library("tidymodels")

df = na.omit(df)
df = df %>% filter(dataset == "lidar2018")

lm_mod = linear_reg() %>% 
  set_engine("lm") %>% 
  fit(stem_number ~ canopy_cover + z_max + z_mean95 + z_mean_csm + z_sd_csm + cv, data = df)
lm_mod

tidy(lm_mod)

