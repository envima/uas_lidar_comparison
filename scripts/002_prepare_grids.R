# prepare grid

source("scripts/000_setup.R")

grid10 = raster("~/data/mof_grid/grid10m.tif")

e = c(477750, 477900, 5632200, 5632350)

grid10_halfmoon = crop(grid10, e)
plot(grid10_halfmoon)


grid10_halfmoon

writeRaster(grid10_halfmoon, "data/areas/halfmoon_grid10.tif")

grid1 = disaggregate(grid10_halfmoon, fact = 10)
grid1@data@values = seq(ncell(grid1))

writeRaster(grid1, "data/areas/halfmoon_grid01.tif")






