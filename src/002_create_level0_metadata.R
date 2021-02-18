fls = list.files("data/level0/pointcloud_indices/", recursive = TRUE, full.names = TRUE, pattern = ".grd$")
fls = fls[!grepl("heterogenity", fls)]


meta = data.frame(filepath = fls) %>% 
  mutate(filename = basename(filepath)) %>% 
  mutate(date = stringr::word(filename, 1,3,sep = "_")) %>% 
  mutate(datasource = stringr::word(filename, 4, 4, sep = "_")) %>% 
  mutate(resolution = stringr::word(filename, 5, 5, sep = "_") %>% readr::parse_number()) 
  
rm(fls)




