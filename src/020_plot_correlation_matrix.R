# correlation matrix example
#

cors = readRDS("data/results/lidar_densecloud_correlations/lidar_denseclouds_lm.RDS") %>% 
  filter(datasource != "lidar") %>% 
  filter(metric_group == "zVoxel") %>% 
  filter(resolution == 2)


ggplot(cors, aes(x = date, y = metric, fill = Rsq))+
  geom_raster(alpha = 0.8)+
  scale_fill_gradientn(colors = viridis(50))+
  geom_text(mapping = aes(label = Rsq), col = "black")+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5))

