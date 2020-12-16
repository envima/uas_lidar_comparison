# 

source("scripts/000_setup.R")

fls = list.files("data/raw/denseclouds/", full.names = TRUE)

sample_area = extent(raster("data/areas/halfmoon_grid10.tif"))




for(file in fls){
  pc = readLAS(file)
  pc = lasclip(pc, sample_area)
  writeLAS(pc, paste0("data/denseclouds/", basename(file)))
}
