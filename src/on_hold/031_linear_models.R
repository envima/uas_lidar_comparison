
predictors = c("canopy_cover", "z_max", "z_mean95", "z_mean_csm", "z_sd_csm", "cv")
response = c("stem_number", "basal_area", "dbh_sd", "dbh40", "species_richness")
m = c("pk")



df_nest = df %>% group_by(dataset) %>% nest()




df_nest %>% mutate(results = map(data, function(d){
  print(d)
}))


d = df_nest$data[[1]]
map(df_nest$data, function(d){
 
  
  
  # train test split
  
  set.seed(1)
  
  data_split = rsample::initial_split(d, prop = 0.75)
  train_data = rsample::training(data_split)
  test_data = rsample::testing(data_split)
  
  map(response, function(r){
    
    
    f = paste(r, " ~ ", paste(predictors, collapse = " + "))
    mod = lm(as.formula(f), data = d)
    
    pred = predict(mod, test_data)
    rcol = test_data %>% select(r)
    
    pred - rcol
    
    
    rmse = sqrt(mean((pred - rcol)**2))
    
    return(tibble(response = r,
                  rmse = rmse))
    
    
  })
  
  
})



























df_models = df_nest %>% mutate(model = map(data, function(x){
  map(r, function(response){
    f = paste(response, " ~ ", paste(p, collapse = " + "))
    lm(as.formula(f), data = x)
  })
}))




df_tidymodels = df_nest %>% mutate(model = map(data, function(x){
  map(r, function(response){
    f = paste(response, " ~ ", paste(p, collapse = " + "))
    linear_reg() %>% 
      set_engine("lm") %>% 
      fit(as.formula(f), data = x) %>% 
      tidy()
  })
}))




mod_r = function(response){
  f = paste(response, " ~ ", paste(p, collapse = " + "))
  lm(as.formula(f), data = df)
} 








