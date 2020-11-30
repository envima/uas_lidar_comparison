# sparseclouds

fls = list.files("data/raw/sparseclouds/", full.names = TRUE)

halfmoon = st_read("data/areas/mof_halfmoon.gpkg")


for(file in fls){
  pc = readLAS(file)
  pc = lasclip(pc, halfmoon)
  writeLAS(pc, paste0("data/sparseclouds/", basename(file)))
}
