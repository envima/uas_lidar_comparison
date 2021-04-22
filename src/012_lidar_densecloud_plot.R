
lidar_densecloud_plot = function(df){
  
  
  plots = df %>% pull(date_densecloud) %>% unique() %>% 
    map(function(d){
      
      df %>% filter(date_densecloud == d) %>%  ggplot(aes(x = metric_value_lidar, y = metric_value_densecloud))+
        geom_hex()+
        scale_x_continuous(name = "Normalized Index: Lidar", breaks = c(0,0.5,1),
                           labels = c("0", ".5", "1"), expand = c(0.01,0.01), limits = c(-0.1,1.1))+
        scale_y_continuous(name = paste0("Normalized Index: DAP ", d), breaks = c(0,0.5,1),
                           labels = c("0", ".5", "1"), expand = c(0.01,0.01), limits = c(-0.1,1.1))+
        scale_fill_gradientn(name = "Count",colors = viridis(25), trans = "log10")+
        geom_abline(slope = 1, intercept = 0, color = "red", lwd = 1)+
        facet_grid(metric ~ resolution)+
        coord_equal()+
        theme(legend.position = "bottom", panel.background = element_blank(),
              panel.grid.major = element_line(color = "grey80"), panel.grid.minor = element_blank())
      
    })
  
  return(plots)
  
  
  
}


