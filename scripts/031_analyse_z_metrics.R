# analyze z metrics

# comparsion of late fall flight to early fall flight
source("scripts/000_setup.R")

# function for generating nice correlation plots
ggHexCor = function(df, metric){
  ggplot(df, aes_(x = as.name(paste0("lidar_", metric)),y = as.name(paste0("sparsecloud_", metric))))+
      geom_hex()+
      scale_fill_gradientn(name = "Count",colors = viridis(25))+
      geom_abline(slope = 1, intercept = 0, color = "red", lwd = 1)+
      coord_equal()+
      theme(panel.background = element_blank())
}




# early: 2020-09-15
df_early = read.csv("data/z_metrics_tables/2020_09_15_sparsecloud.csv")

# late: 2020-11-06
df_late = read.csv("data/z_metrics_tables/2020_11_06_sparsecloud.csv")


metric = "z_max"

ggHexCor(df_early, metric)
ggHexCor(df_late, metric)








