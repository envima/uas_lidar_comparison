# sparseclouds

source("scripts/000_setup.R")

fls = list.files("data/raw/denseclouds/", full.names = TRUE)

sample_area = st_read("data/areas/mof_halfmoon_sample.gpkg")


plot(sample_area)

for(file in fls){
  pc = readLAS(file)
  pc = lasclip(pc, sample_area)
  writeLAS(pc, paste0("data/denseclouds/", basename(file)))
}
