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










