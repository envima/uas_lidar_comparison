# plotting

source("src/012_lidar_densecloud_plot.R")
df = readRDS("data/results/lidar_densecloud_results.RDS")


# fixed resolution, date x index
da = df %>% filter(metric_group_densecloud == "bakx1") %>% filter(resolution == "4m") %>% filter(metric != "z_shannon")

date_comp = da %>% ggplot(aes(x = metric_value_lidar, y = metric_value_densecloud))+
  geom_hex()+
  scale_x_continuous(name = "Normalized Index: Lidar", breaks = c(0,0.5,1),
                     labels = c("0", ".5", "1"), expand = c(0.01,0.01), limits = c(-0.1,1.1))+
  scale_y_continuous(name = paste0("Normalized Index: DAP"), breaks = c(0,0.5,1),
                     labels = c("0", ".5", "1"), expand = c(0.01,0.01), limits = c(-0.1,1.1))+
  scale_fill_gradientn(name = "Count",colors = viridis(25), trans = "log10")+
  geom_abline(slope = 1, intercept = 0, color = "red", lwd = 1)+
  facet_grid(metric ~ date_densecloud)+
  coord_equal()+
  theme(legend.position = "bottom", panel.background = element_blank(),
        panel.grid.major = element_line(color = "grey80"), panel.grid.minor = element_blank())
saveRDS(date_comp, "data/results/scatterplots/lidar_densecloud_bakx1_4m_dates.RDS")


da = df %>% filter(metric_group_densecloud == "zVoxel") %>% filter(resolution == "4m")

date_comp = da %>% ggplot(aes(x = metric_value_lidar, y = metric_value_densecloud))+
  geom_hex()+
  scale_x_continuous(name = "Normalized Index: Lidar", breaks = c(0,0.5,1),
                     labels = c("0", ".5", "1"), expand = c(0.01,0.01), limits = c(-0.1,1.1))+
  scale_y_continuous(name = paste0("Normalized Index: DAP"), breaks = c(0,0.5,1),
                     labels = c("0", ".5", "1"), expand = c(0.01,0.01), limits = c(-0.1,1.1))+
  scale_fill_gradientn(name = "Count",colors = viridis(25), trans = "log10")+
  geom_abline(slope = 1, intercept = 0, color = "red", lwd = 1)+
  facet_grid(metric ~ date_densecloud)+
  coord_equal()+
  theme(legend.position = "bottom", panel.background = element_blank(),
        panel.grid.major = element_line(color = "grey80"), panel.grid.minor = element_blank())
saveRDS(date_comp, "data/results/scatterplots/lidar_densecloud_zvoxel_4m_dates.RDS")





# bakx1 single dates
plots_bakx1 = df %>%
  filter(metric_group_densecloud == "bakx1") %>% filter(datasource_densecloud == "densecloud") %>% 
  filter(metric != "z_shannon") %>% 
  lidar_densecloud_plot()
saveRDS(plots_bakx1, "data/results/scatterplots/lidar_densecloud_bakx1_resolutions_plots.RDS")

# bakx1 multi dates
plots_bakx1_multi = df %>%
  filter(metric_group_densecloud == "bakx1") %>% filter(datasource_densecloud == "multi") %>% 
  filter(metric != "z_shannon") %>% 
  lidar_densecloud_plot()
saveRDS(plots_bakx1_multi, "data/results/scatterplots/lidar_multi_bakx1_resolutions_plots.RDS")


# voxel 

plots_zvoxel = df %>%
  filter(metric_group_densecloud == "zVoxel") %>% filter(datasource_densecloud %in% c("densecloud")) %>% 
  lidar_densecloud_plot()
saveRDS(plots_zvoxel, "data/results/scatterplots/lidar_densecloud_zvoxel_resolutions_plots.RDS")

plots_zvoxel_multi = df %>%
  filter(metric_group_densecloud == "zVoxel") %>% filter(datasource_densecloud %in% c("multi")) %>% 
  lidar_densecloud_plot()
saveRDS(plots_zvoxel_multi, "data/results/scatterplots/lidar_multi_zvoxel_resolutions_plots.RDS")



# heterogenity

df_hetero = df %>% filter(metric_group_densecloud == "bakx1_sd") %>% filter(datasource_densecloud == "densecloud") %>% 
  filter(resolution == "2m") %>% filter(metric != "z_shannon_sd")

plot_hetero = ggplot(df_hetero, aes(x = metric_value_lidar, y = metric_value_densecloud))+
  geom_hex()+
  scale_x_continuous(name = "Normalized Index: Lidar", breaks = c(0,0.5,1),
                     labels = c("0", ".5", "1"), expand = c(0.01,0.01), limits = c(-0.1,1.1))+
  scale_y_continuous(name = paste0("Normalized Index: DAP"), breaks = c(0,0.5,1),
                     labels = c("0", ".5", "1"), expand = c(0.01,0.01), limits = c(-0.1,1.1))+
  scale_fill_gradientn(name = "Count",colors = viridis(25), trans = "log10")+
  geom_abline(slope = 1, intercept = 0, color = "red", lwd = 1)+
  facet_grid(metric ~ date_densecloud)+
  coord_equal()+
  theme(legend.position = "bottom", panel.background = element_blank(),
        panel.grid.major = element_line(color = "grey80"), panel.grid.minor = element_blank())

saveRDS(plot_hetero, "data/results/scatterplots/lidar_densecloud_bakx1sd_dates_plots.RDS")



df_hetero_m = df %>% filter(metric_group_densecloud == "bakx1_sd") %>% filter(datasource_densecloud == "multi") %>% 
  filter(resolution == "2m") %>% filter(metric != "z_shannon_sd")

plot_hetero_m = ggplot(df_hetero_m, aes(x = metric_value_lidar, y = metric_value_densecloud))+
  geom_hex()+
  scale_x_continuous(name = "Normalized Index: Lidar", breaks = c(0,0.5,1),
                     labels = c("0", ".5", "1"), expand = c(0.01,0.01), limits = c(-0.1,1.1))+
  scale_y_continuous(name = paste0("Normalized Index: DAP"), breaks = c(0,0.5,1),
                     labels = c("0", ".5", "1"), expand = c(0.01,0.01), limits = c(-0.1,1.1))+
  scale_fill_gradientn(name = "Count",colors = viridis(25), trans = "log10")+
  geom_abline(slope = 1, intercept = 0, color = "red", lwd = 1)+
  facet_grid(metric ~ date_densecloud)+
  coord_equal()+
  theme(legend.position = "bottom", panel.background = element_blank(),
        panel.grid.major = element_line(color = "grey80"), panel.grid.minor = element_blank())

saveRDS(plot_hetero_m, "data/results/scatterplots/lidar_multi_bakx1sd_dates_plots.RDS")






