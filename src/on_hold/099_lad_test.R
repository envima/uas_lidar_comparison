
# compare leaf area density


source("scripts/000_setup.R")

pc = readRDS("data/run/normalized_pointclouds.RDS")


lad_lidar = LAD(pc$`2018_01_01_lidar`@data$Z, z0 = 2)
lad_d1 = LAD(pc$`2019_12_04_densecloud`@data$Z, z0 = 2)
lad_d2 = LAD(pc$`2019_04_25_densecloud`@data$Z, z0 = 2)
lad_d3 = LAD(pc$`2020_11_12_densecloud`@data$Z, z0 = 2)


pc_comb = rbind(pc$`2019_12_04_densecloud`, pc$`2019_04_25_densecloud`)
lad_comb = LAD(pc_comb@data$Z)

plot(lad_lidar)
points(lad_d1, col = "red")
points(lad_d2, col = "green")
points(lad_d3, col = "blue")
points(lad_comb, col = "blue")
