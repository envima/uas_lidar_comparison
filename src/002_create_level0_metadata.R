fls = list.files("data/level0/pointcloud_indices", recursive = TRUE, full.names = TRUE, pattern = ".grd$")

meta = data.frame(filepath = fls) %>% 
  mutate(filename = basename(filepath)) %>% 
  mutate(metric_group = stringr::word(fls, 4,4, sep = "/")) %>% 
  mutate(date = stringr::word(filename, 1,3,sep = "_")) %>% 
  mutate(datasource = stringr::word(filename, 4, 4, sep = "_")) %>% 
  mutate(resolution = stringr::word(filename, 5, 5, sep = "_") %>% readr::parse_number()) 
  
rm(fls)




